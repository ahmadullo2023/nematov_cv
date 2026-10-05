import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'projects.dart';

void main() => runApp(const MyApp());
const navy = Color(0xff051424),
    low = Color(0xff0d1c2d),
    lowest = Color(0xff010f1f),
    panel = Color(0xff122131),
    high = Color(0xff1c2b3c),
    ink = Color(0xffd4e4fa),
    muted = Color(0xff94a3b8),
    pink = Color(0xfff472b6),
    rose = Color(0xffffafd3),
    blue = Color(0xff7bd0ff),
    purple = Color(0xffcebdff);
TextStyle heading(double size, {Color color = ink}) => TextStyle(
  fontFamily: 'PlusJakartaSans',
  fontSize: size,
  fontWeight: FontWeight.w800,
  letterSpacing: -size * .025,
  height: 1.2,
  color: color,
);
TextStyle mono([double size = 12, Color color = muted]) => TextStyle(
  fontFamily: 'JetBrainsMono',
  fontSize: size,
  color: color,
  height: 1.6,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Ahmadullo Nematov — Flutter Developer',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: navy,
      colorScheme: const ColorScheme.dark(primary: pink, surface: low),
      fontFamily: 'Inter',
      textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'Inter',
        bodyColor: ink,
        displayColor: ink,
      ),
      useMaterial3: true,
    ),
    home: const PortfolioPage(),
  );
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final sections = {
    for (final name in ['About', 'Projects', 'Skills', 'Experience'])
      name: GlobalKey(),
  };
  String active = 'About';
  void go(String name) {
    setState(() => active = name);
    Scrollable.ensureVisible(
      sections[name]!.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  Future<void> link(String url) async {
    if (!await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        ) &&
        mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open the link. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: navy,
            border: Border(
              bottom: BorderSide(color: Colors.white.withValues(alpha: .05)),
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 80,
                  child: LayoutBuilder(
                    builder: (context, c) => Row(
                      children: [
                        InkWell(
                          onTap: () => go('About'),
                          child: Row(
                            children: [
                              Text('Ahmadullo.', style: heading(20)),
                              const SizedBox(width: 8),
                              const CircleAvatar(
                                radius: 3,
                                backgroundColor: blue,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        if (c.maxWidth >= 950)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: lowest,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: sections.keys
                                  .map(
                                    (name) => TextButton(
                                      onPressed: () => go(name),
                                      style: TextButton.styleFrom(
                                        foregroundColor: active == name
                                            ? rose
                                            : muted,
                                        backgroundColor: active == name
                                            ? high
                                            : Colors.transparent,
                                      ),
                                      child: Text(
                                        name,
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        if (c.maxWidth >= 950) const Spacer(),
                        if (c.maxWidth < 950)
                          PopupMenuButton<String>(
                            tooltip: 'Open navigation',
                            icon: const Icon(Icons.menu, size: 22),
                            onSelected: go,
                            itemBuilder: (_) => sections.keys
                                .map(
                                  (name) => PopupMenuItem(
                                    value: name,
                                    child: Text(name),
                                  ),
                                )
                                .toList(),
                          ),
                        if (c.maxWidth >= 950)
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: rose,
                              child: Icon(
                                Icons.person,
                                color: Color(0xff620040),
                                size: 18,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Section(
                  key: sections['About'],
                  child: Column(
                    children: [
                      LayoutBuilder(
                        builder: (context, c) {
                          final size = c.maxWidth > 800 ? 54.0 : 38.0;
                          final intro = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Tag('●  FLUTTER DEVELOPER · TASHKENT'),
                              const SizedBox(height: 24),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: 'Building '),
                                    TextSpan(
                                      text: 'real mobile products',
                                      style: heading(size, color: pink),
                                    ),
                                    const TextSpan(text: ' with Flutter.'),
                                  ],
                                ),
                                style: heading(size),
                              ),
                              const SizedBox(height: 20),
                              const Copy(
                                'Flutter Engineer with 2+ commercial years building and maintaining production iOS and Android applications with clean architecture and reactive state management.',
                                size: 18,
                              ),
                              const SizedBox(height: 24),
                              const Tags([
                                'BLoC',
                                'Riverpod',
                                'REST',
                                'GraphQL',
                                'Clean Architecture',
                              ]),
                              const SizedBox(height: 32),
                              Wrap(
                                spacing: 16,
                                runSpacing: 12,
                                children: [
                                  ActionButton(
                                    'View my work',
                                    () => go('Projects'),
                                    primary: true,
                                    icon: Icons.arrow_forward,
                                  ),
                                  ActionButton(
                                    'Contact me',
                                    () => link('https://t.me/Axmadullo_01'),
                                  ),
                                ],
                              ),
                            ],
                          );
                          return c.maxWidth >= 950
                              ? Row(
                                  children: [
                                    Expanded(flex: 7, child: intro),
                                    const SizedBox(width: 32),
                                    const Expanded(flex: 5, child: CodeCard()),
                                  ],
                                )
                              : Column(
                                  children: [
                                    intro,
                                    const SizedBox(height: 40),
                                    const CodeCard(),
                                  ],
                                );
                        },
                      ),
                      const SizedBox(height: 60),
                      const ResponsiveGrid(
                        children: [
                          Metric(
                            '4+ Apps',
                            'Commercial Production',
                            'Live applications released to App Store, Google Play & Enterprise.',
                            rose,
                          ),
                          Metric(
                            '2 Platforms',
                            'iOS & Android',
                            'Native device APIs, Gradle builds, CocoaPods, and signing.',
                            blue,
                          ),
                          Metric(
                            '2+ Years',
                            'Commercial Engineering',
                            'Full lifecycle involvement from architecture to CI releases.',
                            purple,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Section(
                  alternate: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                        '01 / PERSPECTIVE',
                        'I build products, not just screens.',
                        'My focus is Flutter development for real-world products — from implementing UI and connecting APIs to state management, business logic, debugging, refactoring, and releasing applications to App Store and Google Play.',
                      ),
                      ResponsiveGrid(
                        children: [
                          InfoCard(
                            Icons.devices,
                            'Product Development',
                            'Production-ready Flutter applications and user flows built for real user behavior, varying screen ratios, and defensive edge-case handling.',
                            pink,
                          ),
                          InfoCard(
                            Icons.account_tree_outlined,
                            'Engineering & Architecture',
                            'BLoC, Riverpod, REST, GraphQL, Clean Architecture separation of concerns, dependency injection, and clean collaborative Git workflows.',
                            blue,
                          ),
                          InfoCard(
                            Icons.speed,
                            'Problem Solving',
                            'Deep debugging, refactoring legacy codebases, performance profiling for buttery 60fps rendering, and resolving complex business logic bugs.',
                            purple,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Section(
                  key: sections['Projects'],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(
                        '02 / PORTFOLIO',
                        'Selected work',
                        "Commercial products I've contributed to in production environments.",
                      ),
                      const Surface(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.lock_outline, color: blue, size: 20),
                            SizedBox(width: 12),
                            Expanded(
                              child: Copy(
                                'Confidentiality Note: Source code is private because these are proprietary commercial client projects. This portfolio highlights my architectural responsibilities, technical decisions, and tangible engineering contributions.',
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      ...projects.map(
                        (project) => Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: ProjectCard(project: project),
                        ),
                      ),
                    ],
                  ),
                ),
                Section(
                  key: sections['Skills'],
                  alternate: true,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                        '03 / CAPABILITIES',
                        'Tools I work with',
                        'Core technical competencies organized by architectural discipline without arbitrary percentage ratings.',
                      ),
                      ResponsiveGrid(
                        children: [
                          SkillCard(Icons.phone_iphone, 'Mobile Development', [
                            'Flutter',
                            'Dart',
                            'iOS Deployment',
                            'Android Gradle',
                            'Material 3',
                            'Cupertino',
                          ], rose),
                          SkillCard(Icons.sync_alt, 'State Management', [
                            'BLoC / Cubit',
                            'Riverpod',
                            'Provider',
                            'Reactive Streams',
                            'RxDart',
                          ], blue),
                          SkillCard(Icons.hub_outlined, 'Backend & Network', [
                            'REST API',
                            'GraphQL',
                            'Dio Client',
                            'WebSockets',
                            'Postman',
                          ], purple),
                          SkillCard(
                            Icons.layers_outlined,
                            'Architecture & Practices',
                            [
                              'Clean Architecture',
                              'SOLID Principles',
                              'Dependency Injection (Get_It)',
                              'Repository Pattern',
                              'Unit Testing',
                            ],
                            pink,
                          ),
                          SkillCard(Icons.construction, 'Tooling & Ecosystem', [
                            'Git & GitHub CI/CD',
                            'Fastlane Basics',
                            'Firebase (Crashlytics, FCM)',
                            'Hive & SQLite',
                            'Figma Handoff',
                            'DevTools Profiler',
                          ], blue),
                        ],
                      ),
                    ],
                  ),
                ),
                Section(
                  key: sections['Experience'],
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                        '04 / CAREER',
                        'Commercial Experience',
                        'Direct engineering roles contributing to commercial software companies.',
                      ),
                      Career(
                        '@ Sector Soft',
                        'March 2025 — Present · Tashkent',
                        'Developing and maintaining production iOS and Android apps across multiple commercial clients. Operating in agile sprints with high product ownership.',
                        [
                          'Standardized BLoC and Riverpod reactive state architectures across cross-functional products.',
                          'Executed GraphQL and REST API integrations with robust retry policies, token refresh, and network security.',
                          'Conducted Figma-to-Flutter pixel-perfect implementations, profiling frame rates to ensure sustained 60fps renders.',
                          'Managed release tracks, handling signing keys, Google Play Console, and Apple App Store Connect guidelines.',
                        ],
                        rose,
                      ),
                      SizedBox(height: 40),
                      Career(
                        '@ UIC / Imkon Uzbekistan',
                        '2024 — 2025 · Tashkent',
                        'Engineered core mobile user scenarios for high-stakes fintech, charity fundraising, and social review applications.',
                        [
                          'Built reusable custom UI widgets and design tokens ensuring visual cohesion across multiple sub-brands.',
                          'Integrated local persistence using Hive and secure storage for reliable offline caching and credential protection.',
                          'Connected regional payment gateways and tracked transaction telemetry to resolve critical production crash backlogs.',
                        ],
                        blue,
                      ),
                    ],
                  ),
                ),
                const Section(
                  alternate: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle(
                        '05 / PROCESS',
                        'How I approach development',
                        'A structured 4-stage engineering methodology built on reliability and performance.',
                      ),
                      ResponsiveGrid(
                        columns: 4,
                        children: [
                          ProcessCard(
                            '01',
                            'Understand',
                            'Understand the business rationale, user journey, and backend API contracts before writing a single Flutter widget.',
                          ),
                          ProcessCard(
                            '02',
                            'Build',
                            'Implement clean, type-safe, and modular Flutter code following Clean Architecture, strict SOLID guidelines, and reactive state patterns.',
                          ),
                          ProcessCard(
                            '03',
                            'Refine',
                            'Profile frame rendering with DevTools, audit network bottlenecks, handle edge-case nullabilities, and optimize memory footprints.',
                          ),
                          ProcessCard(
                            '04',
                            'Ship',
                            'Rigorous cross-device testing, automated release builds, and confident deployment to App Store & Google Play Console.',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Section(
                  alternate: true,
                  vertical: 32,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 30,
                    runSpacing: 20,
                    children: [
                      const Copy(
                        'Ahmadullo Nematov — Flutter Developer · Tashkent, Uzbekistan',
                        size: 12,
                      ),
                      Wrap(
                        spacing: 16,
                        children: [
                          TextButton(
                            onPressed: () => link(
                              'https://www.linkedin.com/in/axmadullo/',
                            ),
                            child: const Text('LinkedIn'),
                          ),
                          TextButton(
                            onPressed: () => link('https://t.me/Axmadullo_01'),
                            child: const Text('Telegram'),
                          ),
                        ],
                      ),
                      const Copy(
                        '© 2026 Ahmadullo Nematov. All rights reserved.',
                        size: 11,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.child,
    this.alternate = false,
    this.vertical = 64,
  });
  final Widget child;
  final bool alternate;
  final double vertical;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: alternate ? lowest.withValues(alpha: .6) : null,
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: vertical),
          child: child,
        ),
      ),
    ),
  );
}

class Copy extends StatelessWidget {
  const Copy(this.text, {super.key, this.size = 14});
  final String text;
  final double size;
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(fontSize: size, color: muted, height: 1.7),
  );
}

class Surface extends StatelessWidget {
  const Surface({
    super.key,
    required this.child,
    this.padding = 24,
    this.color = low,
    this.borderColor,
  });
  final Widget child;
  final double padding;
  final Color color;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: borderColor ?? Colors.white.withValues(alpha: .06),
      ),
    ),
    child: child,
  );
}

class ActionButton extends StatelessWidget {
  const ActionButton(
    this.label,
    this.onTap, {
    super.key,
    this.primary = false,
    this.compact = false,
    this.icon,
  });
  final String label;
  final VoidCallback onTap;
  final bool primary, compact;
  final IconData? icon;
  @override
  Widget build(BuildContext context) => FilledButton(
    onPressed: onTap,
    style: FilledButton.styleFrom(
      backgroundColor: primary ? pink : high,
      foregroundColor: primary ? const Color(0xff6d0047) : ink,
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 16 : 28,
        vertical: compact ? 16 : 22,
      ),
      side: BorderSide(
        color: primary
            ? Colors.transparent
            : Colors.white.withValues(alpha: .1),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: compact ? 12 : 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (icon != null) ...[const SizedBox(width: 8), Icon(icon, size: 16)],
      ],
    ),
  );
}

class Tag extends StatelessWidget {
  const Tag(this.text, {super.key, this.color = muted});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: panel,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(text, style: mono(11, color)),
  );
}

class Tags extends StatelessWidget {
  const Tags(this.items, {super.key});
  final List<String> items;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: items.map((e) => Tag(e)).toList(),
  );
}

class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({super.key, required this.children, this.columns = 3});
  final List<Widget> children;
  final int columns;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (_, c) {
      final n = c.maxWidth >= 950
          ? columns
          : c.maxWidth >= 620
          ? 2
          : 1;
      return Wrap(
        spacing: 24,
        runSpacing: 24,
        children: children
            .map(
              (e) => SizedBox(width: (c.maxWidth - 24 * (n - 1)) / n, child: e),
            )
            .toList(),
      );
    },
  );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.label, this.title, this.description, {super.key});
  final String label, title, description;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 40),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: mono(12, rose)),
          const SizedBox(height: 8),
          Text(title, style: heading(32)),
          const SizedBox(height: 12),
          Copy(description),
        ],
      ),
    ),
  );
}

class Metric extends StatelessWidget {
  const Metric(
    this.value,
    this.title,
    this.description,
    this.color, {
    super.key,
  });
  final String value, title, description;
  final Color color;
  @override
  Widget build(BuildContext context) => Surface(
    color: high.withValues(alpha: .5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: heading(30, color: color)),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 5),
        Copy(description, size: 12),
      ],
    ),
  );
}

class InfoCard extends StatelessWidget {
  const InfoCard(
    this.icon,
    this.title,
    this.description,
    this.color, {
    super.key,
  });
  final IconData icon;
  final String title, description;
  final Color color;
  @override
  Widget build(BuildContext context) => Surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 18),
        Text(title, style: heading(18)),
        const SizedBox(height: 12),
        Copy(description),
      ],
    ),
  );
}

class SkillCard extends StatelessWidget {
  const SkillCard(this.icon, this.title, this.skills, this.color, {super.key});
  final IconData icon;
  final String title;
  final List<String> skills;
  final Color color;
  @override
  Widget build(BuildContext context) => Surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Tags(skills),
      ],
    ),
  );
}

class Career extends StatelessWidget {
  const Career(
    this.company,
    this.date,
    this.description,
    this.points,
    this.color, {
    super.key,
  });
  final String company, date, description;
  final List<String> points;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(maxWidth: 850),
    padding: const EdgeInsets.only(left: 24),
    decoration: BoxDecoration(
      border: Border(left: BorderSide(color: color.withValues(alpha: .4))),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: [
            Text('Flutter Developer', style: heading(18)),
            Text(company, style: TextStyle(fontSize: 18, color: color)),
          ],
        ),
        const SizedBox(height: 10),
        Text(date, style: mono()),
        const SizedBox(height: 16),
        Copy(description),
        const SizedBox(height: 12),
        ...points.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Copy('•  $e', size: 12),
          ),
        ),
      ],
    ),
  );
}

class ProcessCard extends StatelessWidget {
  const ProcessCard(this.number, this.title, this.description, {super.key});
  final String number, title, description;
  @override
  Widget build(BuildContext context) => Surface(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(number, style: heading(32, color: muted.withValues(alpha: .4))),
        const SizedBox(height: 12),
        Text(title, style: heading(17)),
        const SizedBox(height: 12),
        Copy(description, size: 12),
      ],
    ),
  );
}

class CodeCard extends StatelessWidget {
  const CodeCard({super.key});
  @override
  Widget build(BuildContext context) => Surface(
    padding: 0,
    color: lowest,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            color: low,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Row(
            children: [
              for (final color in [
                const Color(0xffFF5F56),
                const Color(0xffFFBD2E),
                const Color(0xff27C93F),
              ])
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: CircleAvatar(radius: 5, backgroundColor: color),
                ),
              const Spacer(),
              Text('ahmadullo_specs.dart', style: mono(10), maxLines: 1),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('// Production Engineer Specification', style: mono(11)),
                const SizedBox(height: 12),
                Text('final candidate = Engineer(', style: mono(12, blue)),
                for (final entry in const {
                  'developer': "'Ahmadullo Nematov'",
                  'role': "'Flutter Engineer'",
                  'experience': "'2+ years commercial'",
                  'platforms': "['iOS', 'Android']",
                  'architecture': "'Clean Architecture + SOLID'",
                  'status': "'Ready for high-impact products'",
                }.entries)
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '  ${entry.key}: ',
                            style: mono(11, ink),
                          ),
                          TextSpan(
                            text: '${entry.value},',
                            style: mono(
                              11,
                              entry.key == 'experience' || entry.key == 'status'
                                  ? pink
                                  : purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 9),
                Text(');', style: mono()),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 16,
            runSpacing: 8,
            children: [
              Text('● tests passing: 100%', style: mono(10, blue)),
              Text('Tashkent, UZ (GMT+5)', style: mono(10)),
            ],
          ),
        ),
      ],
    ),
  );
}
