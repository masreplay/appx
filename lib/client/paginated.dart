import 'package:appx/client/client.dart';
import 'package:appx/types/json_type.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'paginated.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class Paginated<T extends dynamic> {
  final List<T> data;

  final int total;

  const Paginated({
    required this.data,
    required this.total,
  });

  factory Paginated.fromJson(
          Map<String, dynamic> json, FromJsonT<T> fromJsonT) =>
      _$PaginatedFromJson<T>(json, fromJsonT);
}

const int defaultLimitSize = 25;
const int firstPage = 1;

extension PaginatedExtension on PagingController {
  // skip limit
  void addItems<T>(
    Paginated<T> data,
    int pageKey, [
    int limitSize = defaultLimitSize,
  ]) {
    final isLastPage = (itemList ?? []).length + limitSize >= data.total;
    if (isLastPage) {
      appendLastPage(data.data);
    } else {
      final nextPageKey = pageKey + 1;
      appendPage(data.data, nextPageKey);
    }
  }
}

extension PaginatedResultState<T> on UiState<Paginated<T>> {
  handleState(PagingController<int, T> controller, int page) {
    whenOrNull(
      data: (data, _) => controller.addItems(data, page),
      error: (error) => controller.error = error,
    );
  }
}
