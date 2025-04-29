import 'dart:convert';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Application> _apps = [];
  List<String> _lockedApps = [];
  static const platform = MethodChannel('appLocker');
  @override
  void initState() {
    super.initState();
    _loadApps();
    _loadLockedApps();
  }

  Future<void> _loadApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      onlyAppsWithLaunchIntent: true,
    );
    setState(() {
      _apps = apps;
    });
  }

  Future<void> _loadLockedApps() async {
    final prefs = await SharedPreferences.getInstance();
    final lockedAppsData = prefs.get('lockedApps');

    if (lockedAppsData is String) {
      final List<dynamic> decoded = jsonDecode(lockedAppsData);
      _lockedApps = decoded.cast<String>();
    } else if (lockedAppsData is List<String>) {
      _lockedApps = lockedAppsData;
    } else {
      _lockedApps = [];
    }

    setState(() {});
  }

  Future<void> _toggleLock(String packageName) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_lockedApps.contains(packageName)) {
        _lockedApps.remove(packageName);
      } else {
        _lockedApps.add(packageName);
      }
    });
    await prefs.setString('lockedApps', jsonEncode(_lockedApps));
  }

  Future<void> enableAccessibilityService() async {
    try {
      await platform.invokeMethod('enableAccessibility');
      print('Accessibility service activation requested');
    } catch (e) {
      print('Error enabling accessibility: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اختار التطبيقات للقفل'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: enableAccessibilityService,
        child: const Icon(Icons.accessibility),
        tooltip: 'تفعيل خدمة الوصول',
      ),
      body: _apps.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _apps.length,
              itemBuilder: (context, index) {
                final app = _apps[index];
                final isLocked = _lockedApps.contains(app.packageName);
                return ListTile(
                  leading: app is ApplicationWithIcon
                      ? Image.memory(app.icon, width: 40, height: 40)
                      : null,
                  title: Text(app.appName),
                  trailing: Icon(
                    isLocked ? Icons.lock : Icons.lock_open,
                    color: isLocked ? Colors.red : Colors.green,
                  ),
                  onTap: () => _toggleLock(app.packageName),
                );
              },
            ),
    );
  }
}
