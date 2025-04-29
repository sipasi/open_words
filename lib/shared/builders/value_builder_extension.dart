part 'list_builder_extension.dart';
part 'string_builder_extension.dart';

typedef ValueBuilder<U, T> = U Function(T value);
typedef OrBuilder<U> = U Function();

extension ValueBuilderExtension<T, U> on T? {
  U? valueBuilder({
    required bool Function(T value) when,
    required ValueBuilder<U, T> builder,
    OrBuilder<U>? or,
  }) {
    final value = this;

    if (value == null || !when(value)) {
      return or?.call();
    }

    return builder(value);
  }

  U valueBuilderOr({
    required bool Function(T value) when,
    required ValueBuilder<U, T> builder,
    required OrBuilder<U> or,
  }) {
    return valueBuilder(when: when, builder: builder, or: or)!;
  }
}
