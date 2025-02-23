import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mon_task/core/viewmodels/home_vm.dart';
import 'package:mon_task/core/viewmodels/viewmodels.dart';

final controllerVM = ChangeNotifierProvider(ControllerViewModel.new);
final homeVM = ChangeNotifierProvider(HomeViewModel.new);