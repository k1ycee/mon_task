import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_task/core/core.dart';

class ControllerBottomNav extends StatefulHookConsumerWidget {
  const ControllerBottomNav({super.key});

  @override
  ConsumerState<ControllerBottomNav> createState() =>
      _ControllerBottomNavState();
}

class _ControllerBottomNavState extends ConsumerState<ControllerBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _navAnimationController;
  late Animation<Offset> _navAnimation;

  @override
  void initState() {
    super.initState();

    _navAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _navAnimation = Tween<Offset>(
      begin:const Offset(0, 1) ,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _navAnimationController,
        curve: Curves.easeIn,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 4100));
      if (mounted) {
        _navAnimationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = ref.watch(controllerVM.select((it) => it.pages));

    final currentIndex = ref.watch(controllerVM.select((it) => it.currentTab));

    return AnimatedBuilder(
      animation: _navAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: _navAnimation,
          child: SafeArea(
            child: Container(
              decoration: const ShapeDecoration(
                color: Color(0xff2C2C2C),
                shape: StadiumBorder(),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children:
                    pages.indexed.map((e) {
                      final selected = e.$1 == currentIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {});
                          ref.read(controllerVM).currentTab = e.$1;
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: CircleAvatar(
                            backgroundColor:
                                selected
                                    ? const Color(0xfffc9f13)
                                    : const Color(0xff232120),
                            radius: selected ? 24 : 20,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: e.$1 == 0 ? 24 : 0,
                              ),
                              child: Icon(
                                e.$2.icon,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
