import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

typedef UpdateState = void Function(void Function());

class ViewModel {
  const ViewModel();

  Future load() {
    return Future.value();
  }

  Future unload() {
    return Future.value();
  }
}

abstract class StatefulView<T extends ViewModel> extends StatefulWidget {
  const StatefulView({super.key});

  @override
  ViewState<T> createState();
}

abstract class ViewState<T extends ViewModel> extends State<StatefulView<T>> {
  late T _viewmodel;
  late Future _load;

  T get viewmodel => _viewmodel;

  @override
  void initState() {
    super.initState();

    _viewmodel = GetIt.I.get<T>();

    _load = _viewmodel.load();
  }

  @override
  void dispose() {
    super.dispose();

    _viewmodel.unload();
  }

  Widget error(BuildContext context, String message) {
    return Column(
      children: [
        const Text('has error'),
        Text(runtimeType.toString()),
        Text(message),
      ],
    );
  }

  Widget loading(BuildContext context) => const LinearProgressIndicator();
  Widget success(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _load,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return error(context, snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loading(context);
        }

        return success(context);
      },
    );
  }
}
