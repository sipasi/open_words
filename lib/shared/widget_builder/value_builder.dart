typedef ValueBuilder<U, T> = U Function(T value);

extension ValueBuilderExtension<T, U> on T? {
  U? valueBuilder({
    required bool Function(T value) when,
    required ValueBuilder<U, T> builder,
  }) {
    final value = this;

    if (value == null || !when(value)) {
      return null;
    }

    return builder(value);
  }
}

extension StringWidgetBuilderExtension on String? {
  U? isNotEmptyBuilder<U>(ValueBuilder<U, String> builder) {
    return valueBuilder(when: (value) => value.isNotEmpty, builder: builder);
  }
}
