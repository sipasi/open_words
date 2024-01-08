abstract class JsonParcer<T> {
  String to(T entity);
  T from(String text);
}
