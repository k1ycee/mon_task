import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mon_task/core/core.dart';
import 'package:mon_task/views/tabs/home/widget/widget.dart';


class HomeTopSection extends StatefulWidget {
  const HomeTopSection({super.key});

  @override
  State<HomeTopSection> createState() => _HomeTopSectionState();
}

class _HomeTopSectionState extends State<HomeTopSection>
    with TickerProviderStateMixin {
  late AnimationController locationAnimationController;
  late Animation<double> widthAnimation;

  late AnimationController locationContentAnimationController;
  late Animation<double> locationContentAnimation;

  late AnimationController avatarAnimationController;
  late Animation<double> avatarAnimation;

  late AnimationController nameAnimationController;
  late Animation<double> nameAnimation;

  late AnimationController headLineAnimationController;
  late Animation<Offset> headLineAnimation;

  @override
  void initState() {
    super.initState();

    locationAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    widthAnimation = Tween<double>(begin: 0, end: 170).animate(
      CurvedAnimation(
        parent: locationAnimationController,
        curve: Curves.decelerate,
      ),
    );

    locationContentAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    locationContentAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: locationContentAnimationController,
        curve: Curves.easeIn,
      ),
    );

    nameAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    nameAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: nameAnimationController, curve: Curves.easeIn),
    );

    avatarAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    avatarAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: avatarAnimationController, curve: Curves.easeIn),
    );

    headLineAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    headLineAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: headLineAnimationController,
        curve: Curves.decelerate,
      ),
    );

    locationAnimationController.forward();
    avatarAnimationController.forward();
    locationAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        locationContentAnimationController.forward();
      }
    });

    locationContentAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        nameAnimationController.forward();
      }
    });

    nameAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        headLineAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    headLineAnimationController.dispose();
    nameAnimationController.dispose();
    locationContentAnimationController.dispose();
    locationAnimationController.dispose();
    avatarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedBuilder(
                  animation: widthAnimation,
                  builder: (context, child) {
                    return Container(
                      height: 45,
                      width: widthAnimation.value,
                      decoration: BoxDecoration(
                        color: Color(0xffFEF8F1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: AnimatedBuilder(
                        animation: locationContentAnimationController,
                        builder: (context, _) {
                          return Opacity(
                            opacity: locationContentAnimation.value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.location,
                                  color: Color(0xffA4967C),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Saint Petersburg',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    color: Color(0xffA4967C),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                AnimatedBuilder(
                  animation: avatarAnimation,
                  builder: (context, _) {
                    return ScaleTransition(
                      scale: avatarAnimation,
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.1, 0.6],
                            colors: [Color(0xffFEF8F1), Color(0xffA4967C)],
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://images.pexels.com/photos/3992656/pexels-photo-3992656.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.topLeft,
              child: AnimatedBuilder(
                animation: nameAnimation,
                builder: (context, _) {
                  return Opacity(
                    opacity: nameAnimation.value,
                    child: Text(
                      'Hi, Marina',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(0xffA4967C),
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  );
                },
              ),
            ),
            ClipRRect(
              child: Align(
                alignment: Alignment.topLeft,
                child: AnimatedBuilder(
                  animation: headLineAnimation,
                  builder: (context, _) {
                    return SlideTransition(
                      position: headLineAnimation,
                      child: Text(
                        "let's select your \nperfect place",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color(0xff26221F),
                          fontSize: 36,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OptionWidget(
                    count: 1034,
                    color: AppTheme.light.primary,
                    textColor: AppTheme.light.onPrimary,
                    option: 'BUY',
                    shape: BoxShape.circle,
                  ),
                ),

                Expanded(
                  child: OptionWidget(
                    count: 2212,
                    color: Color(0xffFEF8F1),
                    textColor: Color(0xffA4967C),
                    borderRadius: BorderRadius.circular(20),
                    option: 'RENT',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
