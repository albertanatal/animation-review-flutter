
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentProfileApp());
}

const Color primaryColor = Color(0xFF6558D3);
const Color backgroundColor = Color(0xFFF6F7FC);

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          foregroundColor: Color(0xFF20213A),
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const StudentHomePage(),
    );
  }
}

// ======================================================
// HALAMAN UTAMA
// ======================================================

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  bool isVisible = true;
  bool showDetail = false;

  late final AnimationController controller;
  late final Animation<double> sizeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    sizeAnimation = Tween<double>(
      begin: 70,
      end: 110,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleSize() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void toggleDetail() {
    setState(() {
      showDetail = !showDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.school_rounded, color: primaryColor),
            SizedBox(width: 10),
            Text(
              'Student Profile',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  const Text(
                    'Halo, Mahasiswa! 👋',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF20213A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Kenali profilmu dan eksplorasi animasi Flutter.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // KARTU PROFIL
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF6558D3),
                          Color(0xFF9388F2),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.20),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Hero(
                          tag: 'student-avatar',
                          child: Material(
                            color: Colors.white.withValues(alpha: 0.18),
                            shape: const CircleBorder(),
                            child: const SizedBox(
                              width: 82,
                              height: 82,
                              child: Icon(
                                Icons.person_rounded,
                                size: 48,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mahasiswa computer science',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'Program Studi computer science',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Semester 5',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: 'Lihat profil',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const StudentDetailPage(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // BAGIAN ANIMASI
                  const SectionTitle(
                    title: 'Eksplorasi Animasi',
                    subtitle: 'Coba setiap fitur di bawah ini.',
                  ),

                  const SizedBox(height: 16),

                  // ANIMATED CONTAINER
                  DemoCard(
                    icon: Icons.open_in_full_rounded,
                    title: 'AnimatedContainer',
                    description:
                        'Mengubah ukuran kotak dengan transisi halus.',
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          width: isExpanded ? 200 : 110,
                          height: isExpanded ? 100 : 80,
                          decoration: BoxDecoration(
                            color: isExpanded
                                ? const Color(0xFFFFA45B)
                                : primaryColor,
                            borderRadius: BorderRadius.circular(
                              isExpanded ? 28 : 16,
                            ),
                          ),
                          child: const Icon(
                            Icons.auto_awesome_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.tonal(
                          onPressed: toggleSize,
                          child: Text(
                            isExpanded ? 'Perkecil Kotak' : 'Perbesar Kotak',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ANIMATED OPACITY
                  DemoCard(
                    icon: Icons.visibility_rounded,
                    title: 'AnimatedOpacity',
                    description:
                        'Mengatur transparansi widget secara bertahap.',
                    child: Column(
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: isVisible ? 1.0 : 0.15,
                          child: const Icon(
                            Icons.favorite_rounded,
                            size: 85,
                            color: Color(0xFFE85D75),
                          ),
                        ),
                        const SizedBox(height: 12),
                        FilledButton.tonal(
                          onPressed: toggleVisibility,
                          child: Text(
                            isVisible ? 'Samarkan Ikon' : 'Tampilkan Ikon',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ANIMATED CROSS FADE
                  DemoCard(
                    icon: Icons.swap_vert_rounded,
                    title: 'AnimatedCrossFade',
                    description:
                        'Beralih di antara dua tampilan dengan animasi.',
                    child: Column(
                      children: [
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 400),
                          crossFadeState: showDetail
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          firstChild: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0EEFF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.lock_outline_rounded,
                                  size: 35,
                                  color: primaryColor,
                                ),
                                SizedBox(height: 8),
                                Text('Detail disembunyikan'),
                              ],
                            ),
                          ),
                          secondChild: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6F7EF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 35,
                                  color: Color(0xFF25845A),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Status: Aktif',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Jurusan: computer science'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        FilledButton.tonal(
                          onPressed: toggleDetail,
                          child: Text(
                            showDetail ? 'Sembunyikan Detail' : 'Lihat Detail',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ANIMATION CONTROLLER
                  DemoCard(
                    icon: Icons.animation_rounded,
                    title: 'AnimationController',
                    description:
                        'Mengatur jalannya animasi dengan kontrol manual.',
                    child: Column(
                      children: [
                        AnimatedBuilder(
                          animation: sizeAnimation,
                          builder: (context, child) {
                            return Container(
                              width: sizeAnimation.value,
                              height: sizeAnimation.value,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: const Icon(
                                Icons.school_rounded,
                                color: Colors.white,
                                size: 42,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FilledButton(
                              onPressed: () {
                                controller.forward(from: 0);
                              },
                              child: const Text('Mulai'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                controller.reverse();
                              },
                              child: const Text('Kembali'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                controller.repeat(reverse: true);
                              },
                              child: const Text('Ulangi'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                controller.stop();
                              },
                              child: const Text('Berhenti'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // RINGKASAN MATERI
                  const SectionTitle(
                    title: 'Ringkasan Materi',
                    subtitle: 'Konsep dasar yang sudah dipelajari.',
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          icon: Icons.view_column_rounded,
                          title: 'Column',
                          description: 'Susunan vertikal',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SummaryCard(
                          icon: Icons.view_stream_rounded,
                          title: 'Row',
                          description: 'Susunan horizontal',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          icon: Icons.layers_rounded,
                          title: 'Expanded',
                          description: 'Membagi ruang',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SummaryCard(
                          icon: Icons.navigation_rounded,
                          title: 'Navigator',
                          description: 'Pindah halaman',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  Center(
                    child: Text(
                      'Dibuat untuk latihan Flutter • Animation & Review',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// WIDGET JUDUL BAGIAN
// ======================================================

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF20213A),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

// ======================================================
// WIDGET KARTU DEMO
// ======================================================

class DemoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Widget child;

  const DemoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE9EAF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EEFF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(child: child),
        ],
      ),
    );
  }
}

// ======================================================
// WIDGET RINGKASAN
// ======================================================

class SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const SummaryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE9EAF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryColor, size: 26),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// HALAMAN DETAIL MAHASISWA
// ======================================================

class StudentDetailPage extends StatelessWidget {
  const StudentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mahasiswa'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'student-avatar',
                  child: Material(
                    color: const Color(0xFFEAE7FF),
                    shape: const CircleBorder(),
                    child: const SizedBox(
                      width: 150,
                      height: 150,
                      child: Icon(
                        Icons.person_rounded,
                        size: 95,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Profil Mahasiswa',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF20213A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Informasi akademik',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 28),
                const DetailInfoTile(
                  icon: Icons.person_outline_rounded,
                  label: 'Nama',
                  value: 'Alberta',
                ),
                const DetailInfoTile(
                  icon: Icons.computer_rounded,
                  label: 'Program Studi',
                  value: 'computer science',
                ),
                const DetailInfoTile(
                  icon: Icons.school_outlined,
                  label: 'Semester',
                  value: '5',
                ),
                const DetailInfoTile(
                  icon: Icons.check_circle_outline_rounded,
                  label: 'Status',
                  value: 'Aktif',
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_rounded),
                    label: const Text('Kembali ke Beranda'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================================================
// WIDGET INFORMASI DETAIL
// ======================================================

class DetailInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9EAF2)),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
