import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_task/core/viewmodels/viewmodels.dart';
import 'package:mon_task/views/tabs/home/widget/listing_widget.dart';

class SpaceListings extends StatefulHookConsumerWidget {
  const SpaceListings({super.key});

  @override
  ConsumerState<SpaceListings> createState() => _SpaceListingsState();
}

class _SpaceListingsState extends ConsumerState<SpaceListings>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _animation = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 3600));
      if (mounted) {
       _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final listing = ref.watch(homeVM.select((value) => value.listings));
    return AnimatedBuilder(animation: _animation, builder: (context, _){
      return SlideTransition(
        position: _animation,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: Color(0xffffffff),
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children:
                        listing
                            .map(
                              (listing) => StaggeredGridTile.count(
                                crossAxisCellCount: listing.mainAxis,
                                mainAxisCellCount: listing.crossAxis,
                                child: ListingWidget(
                                  image: listing.image,
                                  address: listing.address,
                                  alignment:
                                      listing.mainAxis > listing.crossAxis
                                          ? Alignment.center
                                          : Alignment.centerLeft,
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
