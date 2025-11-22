import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  final String name = 'Susi Martini';
  final String npm = '23552011178';

  const AboutScreen({super.key});

  void _openGithub() async {
    final url = Uri.parse(
        'https://github.com/SusiMartini17/uts_mobile_project'); // ganti jika sudah upload
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tentang Aplikasi',
                style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text(
                'Aplikasi ini dibuat untuk kebutuhan Ujian Tengah Semester Mata Kuliah Pemrograman Mobile 2.\n\nFitur utama:\n- Splash Screen\n- Halaman Login & Register\n- List Informasi (ListView) dengan CRUD\n- Navigation (Drawer + BottomNavigation)\n- Halaman About\n- Peta sederhana (opsional)'),
            SizedBox(height: 16),
            Text('Copyright by: $name\nNPM: $npm'),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _openGithub,
              icon: Icon(Icons.code),
              label: Text('Lihat di GitHub (link)'),
            ),
          ],
        ),
      ),
    );
  }
}
