import 'package:equatable/equatable.dart';

class Failure extends Equatable with EquatableMixin {
  @override
  List<Object> get props => [];
}

// Failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
