import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
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
  bool _isAuthenticating = false;
  bool _hasFaceID = false;

  @override
  void initState() {
    super.initState();
    _checkFaceIDSupport();
    _authenticate();
  }

  Future<void> _checkFaceIDSupport() async {
    try {
      final List<BiometricType> availableBiometrics =
      await auth.getAvailableBiometrics();
      print('Available biometrics: $availableBiometrics');
      if (availableBiometrics.contains(BiometricType.face)) {
        setState(() => _hasFaceID = true);
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        setState(() => _hasFaceID = true); // Assume Face ID on iOS
      }
    } catch (e) {
      print('Error checking biometrics: $e');
    }
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;

    setState(() => _isAuthenticating = true);

    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'استخدم Face ID لفتح التطبيق',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
        authMessages: const [
        ],
      );

      if (didAuthenticate) {
        if (mounted) {
          // افتح التطبيق المقفول
          await DeviceApps.openApp(widget.packageName);
          Navigator.pop(context);
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

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('فشل التأمين'),
        content: const Text('حاول استخدام Face ID مرة أخرى'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _authenticate();
            },
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // منع الرجوع بدون تأمين
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
              Text(
                _hasFaceID ? 'افتح باستخدام Face ID' : 'افتح باستخدام البصمة',
                style: const TextStyle(
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