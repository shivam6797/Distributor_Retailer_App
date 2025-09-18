import 'package:equatable/equatable.dart';
import 'package:distributor_retailer_app/features/home/data/model/add_distributor_retailer_model.dart';

abstract class DistributorRetailerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDistributorRetailer extends DistributorRetailerEvent {
  final String type;
  final int page;
  final bool isInitialLoad;

  LoadDistributorRetailer({
    required this.type,
    this.page = 1,
    this.isInitialLoad = true,
  });

  @override
  List<Object?> get props => [type, page, isInitialLoad];
}

class FilterDistributorRetailerByName extends DistributorRetailerEvent {
  final String query;

  FilterDistributorRetailerByName(this.query);

  @override
  List<Object?> get props => [query];
}

class AddDistributorRetailer extends DistributorRetailerEvent {
  final AddDistributorRetailerModel model;
  AddDistributorRetailer({required this.model});

  @override
  List<Object?> get props => [model];
}

class UpdateDistributorRetailer extends DistributorRetailerEvent {
  final AddDistributorRetailerModel model;
  UpdateDistributorRetailer({required this.model});

  @override
  List<Object?> get props => [model];
}
