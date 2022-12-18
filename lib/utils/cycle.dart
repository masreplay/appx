// handle list as circular linked list
extension Cycle<T> on List<T> {
  T next(T current) => this[(indexOf(current) + 1) % length];
  T back(T current) => this[(indexOf(current) - 1) % length];
}
