part of 'value_builder_extension.dart';

extension ListBuilderExtension<T> on List<T>? {
  U? isNotEmptyBuilder<U>(
    ValueBuilder<U, List<T>> builder, {
    OrBuilder<U>? or,
  }) {
    return valueBuilder(
      when: (value) => value.isNotEmpty,
      builder: builder,
      or: or,
    );
  }
}
