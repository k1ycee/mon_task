import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_task/core/viewmodels/providers.dart';

class ControllerPage extends StatefulHookConsumerWidget {
  const ControllerPage({
    super.key,
  });

  @override
  ConsumerState<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends ConsumerState<ControllerPage> {

  final _controller = PageController(initialPage: 0);

  
  @override
  Widget build(BuildContext context) {
    final currentTab = ref.watch(
      controllerVM.select(
        (it) => it.currentTab,
      ),
    );

    final pages = ref.watch(
      controllerVM.select(
        (it) => it.pages,
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [pages.indexed.where((it) => it.$1 == currentTab).first.$2.page],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(),
          ),
        ],
      ),
    );
  }
}