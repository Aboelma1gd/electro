import 'package:equatable/equatable.dart';

class Failure  extends Equatable {
  final String message;

   const Failure(this.message);

  @override
  String toString() => message;
  
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}