import 'package:flutter/material.dart';
import '../../services/storage_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _err = '';

  void _login() {
    final u = _userCtrl.text.trim();
    final p = _passCtrl.text.trim();
    final ok = StorageService.login(u, p);
    if (ok) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _err =
            'Login gagal. Periksa username/password atau registrasi terlebih dahulu.';
      });
    }
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _userCtrl,
                decoration: InputDecoration(labelText: 'Username')),
            TextField(
                controller: _passCtrl,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true),
            SizedBox(height: 12),
            ElevatedButton(onPressed: _login, child: Text('Login')),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RegisterScreen()));
                },
                child: Text('Belum punya akun? Registrasi')),
            if (_err.isNotEmpty) ...[
              SizedBox(height: 12),
              Text(_err, style: TextStyle(color: Colors.red)),
            ]
          ],
        ),
      ),
    );
  }
}
