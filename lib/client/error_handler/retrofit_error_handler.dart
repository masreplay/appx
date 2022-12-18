import 'package:error_handler/error_handler.dart' as eh;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit/dio.dart';

typedef RetrofitResponse<State> = Future<HttpResponse<State>>;
typedef RetrofitResponded<State> = RetrofitResponse<State> Function();

class AppErrorHandler extends eh.ErrorHandler {
  const AppErrorHandler() : super(logger: eh.stateLogger);
}

eh.StreamState<State> convertStream<State>(
  RetrofitResponded<State> apiCall, {
  eh.NetworkExceptionFilter? filter,
}) {
  return filter == null
      ? eh.safeApiCall(() => convert(apiCall))
      : eh.safeApiCall(
          filter: filter,
          () => convert(apiCall),
        );
}

eh.FutureResponse<State> convert<State>(
  RetrofitResponded<State> apiCall,
) async {
  final value = await apiCall();

  return eh.HttpResponse<State, dynamic>(
    value.data,
    eh.ResponseValue(
      value.response as dynamic,
      value.response.statusCode,
    ),
  );
}

typedef StateCubit<T> = Cubit<eh.UiState<T>>;

extension CubitApiHandler<DataType> on StateCubit<DataType> {
  Future<void> emitApiCall(
    Future<HttpResponse<DataType>> Function() apiCall,
  ) async {
    await const AppErrorHandler()
        .stream(() => convert<DataType>(apiCall))
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        .listen(emit)
        .asFuture();
  }
}

void stateTypeLogger<T>(
  eh.ResultState<T> resultState,
  Object? error,
  StackTrace? trace,
) {
  String type = resultState.runtimeType.toString();
  //  remove _$ part
  type = type.substring(2, type.length);
  if (kDebugMode) print("ResultState: $type");

  if (error != null || trace != null) {
    if (kDebugMode) {
      print(error);
      print(trace);
    }
  }
}

extension StreamResultStateExtension<T> on Stream<eh.ResultState<T>> {
  Future<void> listenThenEmit(void Function(eh.ResultState<T> state) emit) =>
      listen(emit).asFuture();

  Future<void> listenThenEmitData(void Function(T state) emit) =>
      listen((response) {
        response.whenOrNull(
          data: (T data, eh.ResponseValue response) {
            emit(data);
          },
        );
      }).asFuture();
}
