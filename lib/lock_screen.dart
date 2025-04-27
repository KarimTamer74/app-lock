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
  bool _isAuthenticating = false;
  static const platform = MethodChannel('appLocker');

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating || widget.packageName.isEmpty) {
      print('Not authenticating: isAuthenticating=$_isAuthenticating, packageName=${widget.packageName}');
      return;
    }

    setState(() => _isAuthenticating = true);

    try {
      final availableBiometrics = await auth.getAvailableBiometrics();
      print('Available biometrics: $availableBiometrics');
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'استخدم بصمة الوجه لفتح التطبيق',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (didAuthenticate) {
        if (mounted) {
          await platform.invokeMethod('openApp', {'packageName': widget.packageName});
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
        content: const Text('حاول استخدام بصمة الوجه مرة أخرى'),
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