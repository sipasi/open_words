import 'package:get_it/get_it.dart';

abstract class AppDependency {
  Future inject(GetIt container);
}
