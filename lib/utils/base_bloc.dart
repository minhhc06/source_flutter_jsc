import 'package:rxdart/rxdart.dart';

class BaseBloc{
  BehaviorSubject<bool> _setIsLoadingUtil = BehaviorSubject<bool>();

  Stream<bool> get getIsLoadingUtil => _setIsLoadingUtil.stream;

  void setIsLoadingUtil({required bool isLoading}) {
    _setIsLoadingUtil.sink.add(isLoading);
  }

  BehaviorSubject<bool> _setIsLoadingPagination = BehaviorSubject<bool>();

  Stream<bool> get getIsLoadingPagination => _setIsLoadingPagination.stream;

  void setIsLoadingPagination({required bool isLoading}) {
    _setIsLoadingPagination.sink.add(isLoading);
  }
}