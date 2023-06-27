part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  final String message;

  const ProductSuccess(this.message);
}

class ProductDeleted extends ProductState {
  final String message;

  const ProductDeleted(this.message);
}

class ProductFailed extends ProductState {
  final Map<String, dynamic> error;

  const ProductFailed(this.error);
}
