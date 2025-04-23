part of 'result.dart';

extension CrudResult<T> on Result<T> {
  static Result<T> created<T>(T value) => CreatedResult(value);
  static Result<T> modified<T>(T value) => ModifiedResult(value);
  static Result<T> deleted<T>(T value) => DeletedResult(value);

  bool get isCreated => this is CreatedResult<T>;
  bool get isModified => this is ModifiedResult<T>;
  bool get isDeleted => this is DeletedResult<T>;

  void onCreated(void Function(T value) callback) {
    if (this is CreatedResult<T>) callback((this as CreatedResult<T>).value);
  }

  void onModified(void Function(T value) callback) {
    if (this is ModifiedResult<T>) callback((this as ModifiedResult<T>).value);
  }

  void onDeleted(void Function(T value) callback) {
    if (this is DeletedResult<T>) callback((this as DeletedResult<T>).value);
  }
}

final class CreatedResult<T> extends SuccessResult<T> {
  const CreatedResult(super.value);
}

final class ModifiedResult<T> extends SuccessResult<T> {
  const ModifiedResult(super.value);
}

final class DeletedResult<T> extends SuccessResult<T> {
  const DeletedResult(super.value);
}
