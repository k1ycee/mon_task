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
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _animateCount;

  bool _animateSize = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animateCount = StepTween(
      begin: 0,
      end: widget.count,
    ).animate(_animationController);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) {
        setState(() {
          _animateSize = true;
        });
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _animateSize ? 1 : 0,
      duration: Duration(milliseconds: 300),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.color,
          shape: widget.shape ?? BoxShape.rectangle,
          borderRadius: widget.borderRadius
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
                    animation: _animationController,
                    builder: (context, _) {
                      return FittedBox(
                        child: Text(
                          '${_animateCount.value}',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
  }
}
