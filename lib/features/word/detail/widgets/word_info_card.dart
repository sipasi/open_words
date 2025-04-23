import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/detail/cubit/word_detail_page_cubit.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class WordInfoCard extends StatelessWidget {
  const WordInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final origin = context.select(
      (WordDetailPageCubit value) => value.state.origin,
    );
    final translation = context.select(
      (WordDetailPageCubit value) => value.state.translation,
    );

    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  origin,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: Text(
                  translation,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
