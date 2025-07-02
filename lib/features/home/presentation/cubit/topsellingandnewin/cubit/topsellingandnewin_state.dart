part of 'topsellingandnewin_cubit.dart';

sealed class TopsellingandnewinState extends Equatable {
  const TopsellingandnewinState();

  @override
  List<Object> get props => [];
}

final class TopsellingandnewinInitial extends TopsellingandnewinState {}

final class TopsellingandnewinLoading extends TopsellingandnewinState {}

final class TopsellingandnewinLoaded extends TopsellingandnewinState {
  final List<ProductEntity> topsellingandnewincubit;

  const TopsellingandnewinLoaded(this.topsellingandnewincubit);
}

final class TopsellingandnewinError extends TopsellingandnewinState {
  final String message;

  const TopsellingandnewinError(this.message);
}
