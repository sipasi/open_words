enum MetadataLoadStatus {
  loading,
  success,
  lookupBefore,
  failure;

  bool get isLoading => this == MetadataLoadStatus.loading;
  bool get isSuccess => this == MetadataLoadStatus.success;
  bool get isLookupBefore => this == MetadataLoadStatus.lookupBefore;
  bool get isFailure => this == MetadataLoadStatus.failure;
}
