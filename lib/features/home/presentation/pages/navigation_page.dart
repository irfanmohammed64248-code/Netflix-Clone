import 'package:api_netflix/features/downloads/presentation/pages/downloads_page.dart';
import 'package:api_netflix/features/home/presentation/pages/home_page.dart';
import 'package:api_netflix/features/home/presentation/providers/navigation_provider.dart';
import 'package:api_netflix/features/search/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationPage extends ConsumerWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    final pages = [const HomePage(), const SearchPage(), const DownloadsPage()];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: 
      Theme(
  data: Theme.of(context).copyWith(
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
  ),
  child: 
      BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(navigationProvider.notifier).changeIndex(index);
        },
        backgroundColor: const Color(0xFF141414),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_outlined),
            activeIcon: Icon(Icons.download),
            label: 'Downloads',
          ),
        ],
      ),
      ),
    );
  }
}
