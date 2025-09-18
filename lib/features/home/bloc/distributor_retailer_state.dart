import 'package:distributor_retailer_app/features/home/data/model/distributor_retailer_model.dart';
import 'package:equatable/equatable.dart';

abstract class DistributorRetailerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DistributorRetailerInitial extends DistributorRetailerState {}

class DistributorRetailerLoading extends DistributorRetailerState {}

class DistributorRetailerLoaded extends DistributorRetailerState {
  final List<Data> items;
  final List<Data>? originalItems;
  final bool? hasMore;
  final int currentPage;
  final int totalPages;
  final bool isLoadingMore;

  DistributorRetailerLoaded({
    required this.items,
    this.originalItems,
    this.hasMore = true,
    this.currentPage = 1,
    this.totalPages = 1,
    this.isLoadingMore = false,
  });

  DistributorRetailerLoaded copyWith({
    List<Data>? items,
    List<Data>? originalItems,
    bool? hasMore,
    int? currentPage,
    int? totalPages,
    bool? isLoadingMore,
  }) {
    return DistributorRetailerLoaded(
      items: items ?? this.items,
      originalItems: originalItems ?? this.originalItems ?? this.items,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    items,
    originalItems,
    hasMore,
    currentPage,
    totalPages,
    isLoadingMore,
  ];
}

class DistributorRetailerError extends DistributorRetailerState {
  final String message;
  DistributorRetailerError(this.message);

  @override
  List<Object?> get props => [message];
}

class DistributorRetailerSubmitting extends DistributorRetailerState {}

class DistributorRetailerSuccess extends DistributorRetailerState {
  final String message;
  DistributorRetailerSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class DistributorRetailerFailure extends DistributorRetailerState {
  final String message;
  DistributorRetailerFailure(this.message);

  @override
  List<Object?> get props => [message];
}
