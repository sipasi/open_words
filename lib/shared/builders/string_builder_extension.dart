part of 'value_builder_extension.dart';

extension StringBuilderExtension on String? {
  U? isNotEmptyBuilder<U>(ValueBuilder<U, String> builder, {OrBuilder<U>? or}) {
    return valueBuilder(
      when: (value) => value.isNotEmpty,
      builder: builder,
      or: or,
    );
  }

  U isNotEmptyBuilderOr<U>({
    required ValueBuilder<U, String> builder,
    required OrBuilder<U> or,
  }) {
    return valueBuilder(
      when: (value) => value.isNotEmpty,
      builder: builder,
      or: or,
    );
  }
}
