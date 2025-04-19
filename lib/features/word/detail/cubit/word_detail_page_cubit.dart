import 'package:flutter_bloc/flutter_bloc.dart';

part 'word_detail_page_state.dart';

class WordDetailPageCubit extends Cubit<WordDetailPageState> {
  WordDetailPageCubit() : super(WordDetailPageInitial());
}
