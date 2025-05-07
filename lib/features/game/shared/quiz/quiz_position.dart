class QuizPosition {
  final int index;

  const QuizPosition({this.index = 0});

  QuizPosition next() => QuizPosition(index: index + 1);
}
