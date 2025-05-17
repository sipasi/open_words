enum StatisticLoadStatus {
  loading,
  success;

  bool get isLoading => this == StatisticLoadStatus.loading;
  bool get isSuccess => this == StatisticLoadStatus.success;
}
