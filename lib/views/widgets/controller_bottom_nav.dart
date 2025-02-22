import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_task/core/core.dart';

class ControllerBottomNav extends StatefulHookConsumerWidget {
  const ControllerBottomNav({super.key});

  @override
  ConsumerState<ControllerBottomNav> createState() =>
      _ControllerBottomNavState();
}

class _ControllerBottomNavState extends ConsumerState<ControllerBottomNav> {
  bool _navBarAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        _navBarAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = ref.watch(
      controllerVM.select(
        (it) => it.pages,
      ),
    );

    final currentIndex = ref.watch(
      controllerVM.select(
        (it) => it.currentTab,
      ),
    );

    return AnimatedSlide(
      offset: _navBarAnimation ? Offset.zero : const Offset(0, 1),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.decelerate,
      child: SafeArea(
        child: Container(
          decoration: const ShapeDecoration(
            color: Color(0xff2C2C2C),
            shape: StadiumBorder(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: pages.indexed.map(
              (e) {
                final selected = e.$1 == currentIndex;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      
                    });
                    ref.read(controllerVM).currentTab = e.$1;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: CircleAvatar(
                      backgroundColor: selected
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
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}