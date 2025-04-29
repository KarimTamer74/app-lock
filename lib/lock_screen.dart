import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

class LockScreen extends StatefulWidget {
  final String packageName;

  const LockScreen({Key? key, required this.packageName}) : super(key: key);

  @override
  _LockScreenState createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  static const platform = MethodChannel('appLocker');
  static const serviceChannel = MethodChannel(
      'appLockServiceChannel'); // ✅ قناة جديدة للتواصل مع AppLockService
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating || widget.packageName.isEmpty) {
      print(
          'Not authenticating: isAuthenticating=$_isAuthenticating, packageName=${widget.packageName}');
      return;
    }

    setState(() => _isAuthenticating = true);

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'ادخل بصمة الاصبع او رمز المرور لفتح التطبيق',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      if (didAuthenticate) {
        if (mounted) {
          try {
            await platform
                .invokeMethod('openApp', {'packageName': widget.packageName});
          } on PlatformException catch (e) {
            print("Failed to open app: $e");
          }
          _unlockAndExit();
        }
      } else {
        if (mounted) {
          _showErrorDialog();
        }
      }
    } catch (e) {
      print('Authentication error: $e');
      if (mounted) {
        _showErrorDialog();
      }
    } finally {
      setState(() => _isAuthenticating = false);
    }
  }

  Future<void> _unlockAndExit() async {
    try {
      await serviceChannel.invokeMethod(
          'resetLockScreenState'); // ✅ نادينا على الخدمة ترجّع isLockScreenActive = false
    } catch (e) {
      log('Failed to reset lock screen state: $e');
    }
    Navigator.pop(context); // ✅ قفل شاشة القفل
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('فشل التأمين'),
        content: const Text('البصمة أو رمز المرور غير صحيح. حاول مرة أخرى.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // اغلاق الرسالة
              _authenticate(); // حاول تاني
            },
            child: const Text('إعادة المحاولة'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // اغلاق الرسالة
              _unlockAndExit(); // قفل شاشة القفل وخبر الخدمة
            },
            child: const Text('إلغاء'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Lottie.asset(
                  'assets/face_id_animation.json',
                  repeat: true,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'افتح باستخدام بصمة الوجه',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (_isAuthenticating)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _authenticate,
                  child: const Text('حاول مرة أخرى'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
