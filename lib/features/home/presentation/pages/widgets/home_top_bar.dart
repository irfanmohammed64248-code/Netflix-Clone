import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:api_netflix/features/home/presentation/providers/top_navigation_provider.dart';

class HomeTopBar extends ConsumerWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(topNavigationProvider);

    Widget buildNavItem(String title, int index) {
      final isSelected = selectedIndex == index;

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          ref.read(topNavigationProvider.notifier).changeTab(index);
        },
          child: SizedBox(
    width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 17,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFE84141)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
          ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'NETFLIX',
              style: TextStyle(
                color: Color(0xFFE84141),
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const Icon(Icons.person_outline, color: Colors.white, size: 30),
          ],
        ),

        const SizedBox(height: 20),

       
      Row(
  children: [
    Expanded(child: buildNavItem('Home', 0)),
    Expanded(child: buildNavItem('TV Shows', 1)),
    Expanded(child: buildNavItem('Movies', 2)),
  ],
),
      ],
    );
  }
}
