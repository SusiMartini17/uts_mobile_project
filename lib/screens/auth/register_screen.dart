import 'package:flutter/material.dart';
import '../../services/storage_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _msg = '';

  void _register() async {
    final u = _userCtrl.text.trim();
    final p = _passCtrl.text.trim();
    if (u.isEmpty || p.isEmpty) {
      setState(() {
        _msg = 'Username dan password harus diisi.';
      });
      return;
    }
    await StorageService.register(u, p);
    setState(() {
      _msg = 'Registrasi berhasil. Silakan login.';
    });
    Future.delayed(Duration(milliseconds: 800), () {
      Navigator.pop(context);
    });
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
        title: Text('Register'),
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
            ElevatedButton(onPressed: _register, child: Text('Registrasi')),
            if (_msg.isNotEmpty) ...[
              SizedBox(height: 12),
              Text(_msg, style: TextStyle(color: Colors.green)),
            ]
          ],
        ),
      ),
    );
  }
}
