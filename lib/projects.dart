import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';

class Project {
  const Project(
    this.name,
    this.category,
    this.description,
    this.contribution,
    this.tags,
    this.screens, {
    required this.appStoreUrl,
    required this.googlePlayUrl,
    this.framed = true,
    this.enterprise = false,
    this.images = const [],
    this.detailHeading = 'My Tangible Engineering Contributions:',
  });
  final String name, category, description, contribution;
  final String appStoreUrl, googlePlayUrl;
  final List<String> tags, screens;
  final bool framed, enterprise;
  final List<String> images;
  final String detailHeading;
}

const projects = [
  Project(
    'HR Pulse Admin',
    'ENTERPRISE HR & MANAGEMENT',
    'HR Pulse Admin is a workforce management application for administrators to monitor attendance and employee locations, manage staff and branches, review compensation data, and process leave or time-off requests.',
    'I built this application from scratch through production release. My work covered the mobile architecture, UI implementation, API integration, BLoC state management, attendance and live-location flows, payroll controls, testing, production fixes, and store release process.',
    [
      'Flutter',
      'BLoC',
      'REST API',
      'Live Location',
      'Attendance',
      'Payroll Controls',
    ],
    [
      'Attendance Overview',
      'Check-in Monitoring',
      'Admin Profile',
      'Live Employee Location',
    ],
    appStoreUrl: 'https://apps.apple.com/uz/app/hr-pulse-admin/id6758334988',
    googlePlayUrl:
        'https://play.google.com/store/search?q=HR%20pulse%20admin&c=apps&hl=ru',
    images: [
      'assets/images/hr_pulse_admin/attendance_overview.png',
      'assets/images/hr_pulse_admin/checkin_monitoring.png',
      'assets/images/hr_pulse_admin/admin_profile.png',
      'assets/images/hr_pulse_admin/live_location.png',
    ],
    detailHeading: 'My role and contribution:',
  ),
  Project(
    'HR Pulse Xodimlar',
    'HR TECH & EMPLOYEE SELF-SERVICE',
    'HR Pulse Xodimlar is an employee self-service application for location- and face-verified check-ins, attendance history, leave requests, and salary, advance, bonus, or penalty records.',
    'I built this application from scratch through production release. My work included the architecture, responsive UI, API integration, BLoC state management, face verification and GPS-based office validation, attendance, leave and payroll flows, testing, production fixes, and store release process.',
    [
      'Flutter',
      'BLoC',
      'Face Verification',
      'GPS Geofencing',
      'Attendance',
      'Payroll Self-Service',
    ],
    [
      'Attendance & Check-in',
      'Payroll, Bonuses & Penalties',
      'Employee Profile',
    ],
    appStoreUrl: 'https://apps.apple.com/uz/app/hr-pulse-xodimlar/id6755289545',
    googlePlayUrl:
        'https://play.google.com/store/apps/details?id=uz.sectorsoft.hrpulse',
    images: [
      'assets/images/hr_pulse_employees/attendance.jpg',
      'assets/images/hr_pulse_employees/payroll.jpg',
      'assets/images/hr_pulse_employees/profile.jpg',
    ],
    detailHeading: 'My role and contribution:',
  ),
  Project(
    'Paylov',
    'FINTECH · BANKING & PAYMENTS',
    'Paylov is a fintech mobile application for card-to-card transfers, everyday payments, transaction monitoring, expense tracking, and Uzcard and Humo card management.',
    'I worked on Paylov from the early stages through its production release. I contributed across most areas of the application, with substantial work on transaction monitoring and payment flows, as well as transfers and related core screens.',
    [
      'Flutter 3.x',
      'BLoC / Cubit',
      'REST API',
      'Biometrics',
      'Secure Storage',
      'Custom Keyboard',
    ],
    [
      'Card Transfers',
      'Payments',
      'My Home',
      'Expense Monitoring',
      'Transfers to Uzbekistan',
    ],
    appStoreUrl: 'https://apps.apple.com/uz/app/paylov/id6743964462',
    googlePlayUrl: 'https://play.google.com/store/search?q=paylov&c=apps&hl=ru',
    detailHeading: 'My role and contribution:',
    images: [
      'assets/images/paylov/telefon_1.png',
      'assets/images/paylov/telefon_2.png',
      'assets/images/paylov/telefon_3.png',
      'assets/images/paylov/telefon_4.png',
      'assets/images/paylov/telefon_5.png',
    ],
  ),
  Project(
    'Sharh',
    'REVIEWS · BUSINESS DISCOVERY',
    'Sharh is a business discovery and review application where users can find companies by category, compare ratings, read or publish reviews, and save useful businesses.',
    'I worked on an existing version of Sharh with a focus on performance and product development. I optimized slow parts of the application, improved the responsiveness and stability of existing flows, and implemented new functionality while maintaining the features already used in production.',
    [
      'Flutter',
      'REST API',
      'Business Directory',
      'Ratings & Reviews',
      'Search & Categories',
      'Bookmarks',
    ],
    [
      'Company Reviews',
      'Business Directory',
      'Service Categories',
      'Discovery Home',
    ],
    appStoreUrl: 'https://apps.apple.com/uz/app/sharh/id6454791625',
    googlePlayUrl:
        'https://play.google.com/store/apps/details?id=io.commeta.sharhuz&hl=ru',
    images: [
      'assets/images/sharh/sharh_1.jpg',
      'assets/images/sharh/sharh_2.jpg',
      'assets/images/sharh/sharh_3.jpg',
      'assets/images/sharh/sharh_4.jpg',
    ],
    detailHeading: 'My role and contribution:',
    framed: false,
  ),
];

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final Project project;

  Future<void> openStore(
    BuildContext context,
    String storeName,
    String url,
  ) async {
    final opened = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$storeName linkini ochib bo\u2018lmadi.')),
      );
    }
  }

  void preview(BuildContext context, int index) => showDialog<void>(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: low,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${project.name} · ${project.screens[index]}',
                      style: heading(16),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    tooltip: 'Close preview',
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: project.images.isNotEmpty ? 360 : 230,
                    height: project.images.isNotEmpty ? 700 : 410,
                    child: DeviceScreen(project: project, index: index),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) => Surface(
    padding: MediaQuery.sizeOf(context).width < 600 ? 18 : 32,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Tag(project.category, color: project.enterprise ? blue : pink),
            Tag(
              project.enterprise
                  ? 'MDM / Enterprise Distribution'
                  : '● Production Live',
              color: blue,
            ),
            Tag('${project.screens.length} Production Screens'),
          ],
        ),
        const SizedBox(height: 14),
        Text(project.name, style: heading(30)),
        const SizedBox(height: 8),
        Text(
          project.enterprise
              ? '(Corporate Tablet & Mobile)'
              : '(iOS & Android)',
          style: mono(11),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 770),
          child: Copy(project.description),
        ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 770),
          child: Surface(
            color: lowest,
            padding: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '●  ${project.detailHeading}',
                  style: TextStyle(
                    color: rose,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Copy(project.contribution, size: 12),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Tags(project.tags),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            OutlinedButton(
              onPressed: () =>
                  openStore(context, 'App Store', project.appStoreUrl),
              child: const Text('App Store'),
            ),
            OutlinedButton(
              onPressed: () =>
                  openStore(context, 'Google Play', project.googlePlayUrl),
              child: const Text('Google Play'),
            ),
          ],
        ),
        const Divider(color: high, height: 40),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          spacing: 16,
          runSpacing: 8,
          children: [
            Text(
              '${project.name} Production UI Showcase',
              style: mono(11, ink),
            ),
            Text('Select a screen to preview  ↗', style: mono(10, blue)),
          ],
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (_, c) {
            final columns = project.screens.length == 8
                ? 4
                : project.screens.length;
            final width = project.framed
                ? ((c.maxWidth - 32 - (columns - 1) * 14) / columns).clamp(
                    140.0,
                    245.0,
                  )
                : 172.0;
            final items = List.generate(
              project.screens.length,
              (index) => SizedBox(
                width: width,
                child: InkWell(
                  onTap: () => preview(context, index),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: project.framed && project.images.isEmpty
                          ? const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xff0055ff), Color(0xff003db3)],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          project.screens[index].toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .6,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: project.images.isNotEmpty
                              ? 330
                              : project.framed
                              ? 235
                              : 215,
                          child: DeviceScreen(project: project, index: index),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: project.framed
                    ? const Color(0xff030c17)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: project.screens.length == 8 && c.maxWidth > 700
                  ? Wrap(spacing: 14, runSpacing: 16, children: items)
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < items.length; i++) ...[
                            if (i > 0) const SizedBox(width: 14),
                            items[i],
                          ],
                        ],
                      ),
                    ),
            );
          },
        ),
      ],
    ),
  );
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({super.key, required this.project, required this.index});
  final Project project;
  final int index;
  @override
  Widget build(BuildContext context) {
    if (project.images.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          project.images[index],
          fit: BoxFit.contain,
          semanticLabel: '${project.name} — ${project.screens[index]}',
        ),
      );
    }
    final dark =
        project.name == 'Paylov' ||
        !project.framed ||
        (project.name == 'HR Pulse Xodimlar' && [3, 4].contains(index));
    final splash = project.name == 'HR Pulse Xodimlar' && index == 0;
    final foreground = dark || splash ? Colors.white : const Color(0xff1e293b);
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        width: 130,
        height: 240,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: project.framed ? Colors.white : high,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: splash
                ? const Color(0xff0055ff)
                : dark
                ? const Color(0xff0a1727)
                : Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 7,
              color: foreground,
              height: 1.5,
            ),
            child: Column(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(child: _content(dark, splash, foreground)),
                const SizedBox(height: 8),
                Container(
                  width: 36,
                  height: 2,
                  color: foreground.withValues(alpha: .25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _content(bool dark, bool splash, Color foreground) {
    if (splash) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.psychology_outlined,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(height: 12),
            const Text(
              'HR-IQ',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const Text(
              'ENTERPRISE SUITE',
              style: TextStyle(fontSize: 5, letterSpacing: 1.4),
            ),
          ],
        ),
      );
    }
    if (project.name == 'Paylov') return _paylov();
    return _xodimlar(foreground);
  }

  Widget title(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      text,
      style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
    ),
  );
  Widget tile(String left, [String right = '', bool dark = false]) => Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: dark ? high : const Color(0xfff1f5f9),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        Expanded(child: Text(left, style: const TextStyle(fontSize: 6))),
        Text(
          right,
          style: const TextStyle(fontSize: 6, color: Color(0xff3b82f6)),
        ),
      ],
    ),
  );
  Widget button(String text, {Color color = const Color(0xff0055ff)}) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 7,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  Widget _paylov() {
    switch (index) {
      case 0:
        return Column(
          children: [
            const Icon(Icons.account_balance_wallet, color: pink, size: 30),
            title('Paylov ID'),
            const Text(
              'Biometric Secured',
              style: TextStyle(color: muted, fontSize: 6),
            ),
            const SizedBox(height: 12),
            const Text(
              '● ● ○ ○',
              style: TextStyle(color: pink, letterSpacing: 4),
            ),
            const Spacer(),
            Wrap(
              spacing: 22,
              runSpacing: 10,
              children: List.generate(
                9,
                (i) => Text('${i + 1}', style: const TextStyle(fontSize: 10)),
              ),
            ),
            const SizedBox(height: 8),
            const Icon(Icons.fingerprint, color: pink, size: 20),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('Total Balance'),
            Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0xff30254d),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '14,280k UZS',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text('•••• 4829 HUMO', style: TextStyle(fontSize: 6)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Transfer     Cards     QR Pay',
              style: TextStyle(color: blue, fontSize: 6),
            ),
            const SizedBox(height: 14),
            tile('Beeline', '-45,000', true),
            tile('Korzinka', '-112,000', true),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('Card to Card'),
            const Text('Recipient Card'),
            tile('9860 •••• •••• 7102', '', true),
            const SizedBox(height: 12),
            const Text('Amount UZS'),
            tile('500,000', '', true),
            const Spacer(),
            button('Send 500,000', color: pink),
          ],
        );
      case 3:
        return Column(
          children: [
            title('QR Scanner'),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.qr_code_scanner, color: blue, size: 40),
            ),
            const Spacer(),
            const Text(
              'Scan merchant QR to pay',
              style: TextStyle(fontSize: 5, color: muted),
            ),
          ],
        );
      case 4:
        return Column(
          children: [
            title('My Cards'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: const Color(0xff0868d5),
              child: const Text('HUMO Virtual\n\n•••• 4829'),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: const Color(0xff14996d),
              child: const Text('Uzcard Primary\n\n•••• 1943'),
            ),
            const Spacer(),
            const Text('+ Add New Card', style: TextStyle(color: blue)),
          ],
        );
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('Expenses · March'),
            const SizedBox(height: 10),
            SizedBox(
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  6,
                  (i) => Container(
                    width: 7,
                    height: [35.0, 58.0, 42.0, 68.0, 30.0, 53.0][i],
                    color: i.isEven ? pink : blue,
                  ),
                ),
              ),
            ),
            const Spacer(),
            tile('Transfers', '62%', true),
            tile('Utilities', '24%', true),
          ],
        );
    }
  }

  Widget calendar() => Wrap(
    spacing: 4,
    runSpacing: 4,
    children: List.generate(
      28,
      (i) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: [3, 10, 19].contains(i)
              ? const Color(0xff22c55e)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text('${i + 1}', style: const TextStyle(fontSize: 5)),
        ),
      ),
    ),
  );
  Widget _xodimlar(Color foreground) {
    switch (index) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('HR-IQ Apex'),
            const SizedBox(height: 12),
            const Text('Employee ID'),
            tile('UZ-78401'),
            const Text('Password'),
            tile('••••••••'),
            const SizedBox(height: 12),
            button('Sign In'),
            const Spacer(),
            const Text('Forgot credentials?'),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('Ahmadullo N.'),
            tile('Check-in time', '08:58 AM'),
            tile('On Time', '✓'),
            const SizedBox(height: 10),
            tile('Shift Status', 'Active HQ'),
            tile('8.5 hrs', 'Apex'),
            const Spacer(),
            button('Shift GPS Clocked', color: const Color(0xff22c55e)),
          ],
        );
      case 3:
        return Column(
          children: [
            title('Shaxsni tasdiqlash'),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.face, color: blue, size: 48),
            ),
            const SizedBox(height: 10),
            const Text(
              'Position your face within the frame',
              style: TextStyle(fontSize: 5),
            ),
            const Spacer(),
            button('Tasdiqlash'),
          ],
        );
      case 4:
        return Column(
          children: [
            const Text(
              'Muvaffaqiyatli tasdiqlandi',
              style: TextStyle(color: Colors.greenAccent, fontSize: 6),
            ),
            const Spacer(),
            const Icon(
              Icons.check_circle_outline,
              color: Colors.greenAccent,
              size: 50,
            ),
            title('Tasdiqlandi!'),
            const Text(
              "Biometrik ro‘yxatga olindi",
              style: TextStyle(fontSize: 6),
            ),
            const Spacer(),
            button('Davom etish'),
          ],
        );
      case 5:
        return Column(
          children: [
            title('Fevral 2026'),
            const SizedBox(height: 20),
            calendar(),
            const Spacer(),
            tile('Keldi: 21 kun', '✓'),
          ],
        );
      case 6:
        return Column(
          children: [
            title('Apex Wheel'),
            const Spacer(),
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xff1e293b), width: 4),
                gradient: const SweepGradient(
                  colors: [
                    Colors.amber,
                    Color(0xff1e293b),
                    Colors.amber,
                    Color(0xff1e293b),
                    Colors.amber,
                  ],
                ),
              ),
              child: const Icon(Icons.circle, color: Colors.white, size: 18),
            ),
            const Spacer(),
            const Text(
              'Har kuni omadingizni sinang',
              style: TextStyle(fontSize: 5),
            ),
            const SizedBox(height: 8),
            button('Aylantirish', color: const Color(0xff84cc16)),
          ],
        );
      default:
        return Column(
          children: [
            const CircleAvatar(
              radius: 17,
              backgroundColor: Color(0xffe2e8f0),
              child: Icon(Icons.person, size: 20, color: muted),
            ),
            title('Ahmadullo N.'),
            const Text(
              'Flutter Dev',
              style: TextStyle(color: Color(0xff2563eb), fontSize: 6),
            ),
            const SizedBox(height: 12),
            tile("Shaxsiy ma’lumot", '›'),
            tile('Oylik maosh varaqasi', '›'),
            tile('Bildirishnomalar', '›'),
            const Spacer(),
            const Icon(Icons.fingerprint, color: Color(0xff2563eb), size: 22),
          ],
        );
    }
  }
}
