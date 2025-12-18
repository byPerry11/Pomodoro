import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/pomodoro_screen.dart';
import 'screens/tasks_screen.dart';
import 'screens/profile_screen.dart';
import 'services/pomodoro_service.dart';
import 'services/task_service.dart';

void main() {
  runApp(const PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PomodoroService()),
        ChangeNotifierProvider(create: (context) => TaskService()),
      ],
      child: MaterialApp(
        title: 'Time to focus',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          textTheme: GoogleFonts.poiretOneTextTheme(),
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFFAFAFA),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFAFAFA),
            foregroundColor: Color(0xFF212121),
            elevation: 0,
          ),
          colorScheme: const ColorScheme.light(
            primary: Color(0xFFDFDFDC), // Beige claro principal
            secondary: Color(0xFF757575), // Gris medio
            surface: Color(0xFFFFFFFF), // Blanco
            onPrimary: Color(0xFF212121), // Negro sobre primary
            onSecondary: Color(0xFF212121), // Negro sobre secondary
            onSurface: Color(0xFF212121), // Negro sobre surface
            tertiary: Color(0xFF424242), // Gris oscuro
            outline: Color(0xFFE0E0E0), // Gris muy claro para bordes
          ),
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.grey,
          textTheme: GoogleFonts.poiretOneTextTheme(ThemeData.dark().textTheme),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF121212),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF121212),
            foregroundColor: Color(0xFFDFDFDC),
            elevation: 0,
          ),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFDFDFDC), // Beige claro principal
            secondary: Color(0xFF757575), // Gris medio
            surface: Color(0xFF1E1E1E), // Gris muy oscuro
            onPrimary: Color(0xFF121212), // Negro sobre primary
            onSecondary: Color(0xFFDFDFDC), // Beige sobre secondary
            onSurface: Color(0xFFDFDFDC), // Beige sobre surface
            tertiary: Color(0xFFBDBDBD), // Gris claro
            outline: Color(0xFF424242), // Gris oscuro para bordes
          ),
        ),
        themeMode: ThemeMode.system,
        home: const MainNavigationScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const PomodoroScreen(),
    const TasksScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 0.5,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedItemColor: Theme.of(context).colorScheme.onSurface,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          selectedLabelStyle: GoogleFonts.poiretOne(
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
          unselectedLabelStyle: GoogleFonts.poiretOne(
            fontSize: 11,
          ),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.timer_outlined, size: 24),
              activeIcon: Icon(Icons.timer, size: 24),
              label: 'Pomodoro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.flag_outlined, size: 24),
              activeIcon: Icon(Icons.flag, size: 24),
              label: 'Objetivos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 24),
              activeIcon: Icon(Icons.person, size: 24),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
