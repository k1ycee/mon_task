import 'package:flutter/material.dart';

class OptionWidget extends StatefulWidget {
  const OptionWidget({
    super.key,
    required this.option,
    required this.count,
    this.shape,
    this.borderRadius,
    this.color,
    this.textColor,
  });
  final String option;
  final int count;
  final BoxShape? shape;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final Color? textColor;

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget>
    with TickerProviderStateMixin {
  late AnimationController _countAnimationController;
  late Animation<int> _countAnimation;

  late AnimationController _containerAnimationController;
  late Animation<double> _containerAnimation;

  @override
  void initState() {
    super.initState();

    _containerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _containerAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_containerAnimationController);
    _countAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _countAnimation = StepTween(
      begin: 0,
      end: widget.count,
    ).animate(_countAnimationController);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 3500));
      if (mounted) {
        _containerAnimationController.forward();
        _countAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _countAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _containerAnimation,
      builder: (context, _) {
        return ScaleTransition(
          scale: _containerAnimation,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.color,
              shape: widget.shape ?? BoxShape.rectangle,
              borderRadius: widget.borderRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.option,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: widget.textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      AnimatedBuilder(
                        animation: _countAnimationController,
                        builder: (context, _) {
                          return FittedBox(
                            child: Text(
                              '${_countAnimation.value}',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: widget.textColor,
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                        'Offers',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16,
                          color: widget.textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
