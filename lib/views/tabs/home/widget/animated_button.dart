import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    super.key,
    required this.address,
    required this.alignment,
  });

  final String address;
  final AlignmentGeometry alignment;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonAnimation;

  late AnimationController _addressAnimationController;
  late Animation<double> _addressAnimation;

  late AnimationController _sliderAnimationController;
  late Animation<double> _sliderAnimation;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _buttonAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.decelerate,
      ),
    );

    _addressAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _addressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _addressAnimationController,
        curve: Curves.decelerate,
      ),
    );

    _sliderAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _sliderAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _sliderAnimationController,
        curve: Curves.decelerate,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 4000));
      if (mounted) {
        _buttonAnimationController.forward();
         _sliderAnimationController.forward();
      }
      _buttonAnimationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _buttonAnimationController.dispose();
          _addressAnimationController.forward();
        }
      });

    });
  }

  @override
  void dispose() {
    _addressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _buttonAnimation,
          builder: (context, _) {
            return Container(
              height: 40,
              width: constraints.maxWidth * _buttonAnimation.value,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: const Color(0xffa5957d).withOpacity(0.3),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          Container(
                            alignment: widget.alignment,
                            child: AnimatedBuilder(
                              animation: _addressAnimation,
                              builder: (context, _) {
                                return Opacity(
                                  opacity: _addressAnimation.value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(widget.address),
                                  ),
                                );
                              },
                            ),
                          ),

                          AnimatedBuilder(
                            animation: _sliderAnimation,
                            builder: (context, _) {
                              return Transform.translate(
                                offset: Offset( (constraints.maxWidth - 40) * _sliderAnimation.value , 0),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    right: 1,
                                    top: 2,
                                  ),
                                  child: const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Color(0xffffffff),
                                    child: Icon(
                                      Icons.keyboard_arrow_right_sharp,
                                      color: Color(0xff000000),
                                      size: 16,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          // AnimatedPositioned(
                          //   right: constraints.maxWidth - 40,
                          //   duration: const Duration(milliseconds: 400),
                          //   child:
                          // ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
