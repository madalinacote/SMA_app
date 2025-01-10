part of 'get_categories_bloc.dart';

sealed class GetCategoriesState extends Equatable {
  const GetCategoriesState();
}

final class GetCategoriesInitial extends GetCategoriesState {
  @override
  List<Object> get props => [];
}
