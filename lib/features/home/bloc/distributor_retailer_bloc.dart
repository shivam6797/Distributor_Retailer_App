import 'package:distributor_retailer_app/core/error/api_exception.dart';
import 'package:distributor_retailer_app/features/home/data/repositories/distributor_retailer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'distributor_retailer_event.dart';
import 'distributor_retailer_state.dart';

class DistributorRetailerBloc
    extends Bloc<DistributorRetailerEvent, DistributorRetailerState> {
  final DistributorRetailerRepository repository;

  DistributorRetailerBloc(this.repository)
    : super(DistributorRetailerInitial()) {
    on<LoadDistributorRetailer>(_onLoadDistributorRetailer);
    on<FilterDistributorRetailerByName>(_onFilterDistributorRetailerByName);
    on<AddDistributorRetailer>(_onAddDistributorRetailer);
    on<UpdateDistributorRetailer>(_onUpdateDistributorRetailer);
  }

  String _getErrorMessage(dynamic e) {
    if (e is ApiException) {
      return e.message;
    } else {
      return e.toString();
    }
  }

  Future<void> _onLoadDistributorRetailer(
    LoadDistributorRetailer event,
    Emitter<DistributorRetailerState> emit,
  ) async {
    if (event.page == 1) {
      emit(DistributorRetailerLoading());
    } else {
      if (state is DistributorRetailerLoaded) {
        final currentState = state as DistributorRetailerLoaded;
        if (currentState.isLoadingMore || !currentState.hasMore!) {
          return;
        }
        emit(currentState.copyWith(isLoadingMore: true));
      }
    }
    try {
      final response = await repository.fetchDistributorRetailer(
        type: event.type,
        page: event.page,
      );
      final newCurrentPage = int.tryParse(response.page ?? "1") ?? event.page;
      final totalPages = response.numberOfPage ?? 1;
      final hasMore = newCurrentPage < totalPages;
      final newData = response.data ?? [];
      if (event.page == 1) {
        emit(
          DistributorRetailerLoaded(
            items: newData,
            originalItems: newData,
            currentPage: newCurrentPage,
            totalPages: totalPages,
            hasMore: hasMore,
            isLoadingMore: false,
          ),
        );
      } else {
        final currentState = state as DistributorRetailerLoaded;
        emit(
          currentState.copyWith(
            items: [...currentState.items, ...newData],
            originalItems: [...currentState.originalItems!, ...newData],
            currentPage: newCurrentPage,
            totalPages: totalPages,
            hasMore: hasMore,
            isLoadingMore: false,
          ),
        );
      }
    } catch (e) {
      final message = _getErrorMessage(e);
      print("Error from Bloc: $message");
      if (event.page == 1) {
        emit(DistributorRetailerError(message));
      } else {
        if (state is DistributorRetailerLoaded) {
          emit(
            (state as DistributorRetailerLoaded).copyWith(isLoadingMore: false),
          );
        } else {
          emit(DistributorRetailerError(message));
        }
      }
    }
  }

  Future<void> _onFilterDistributorRetailerByName(
    FilterDistributorRetailerByName event,
    Emitter<DistributorRetailerState> emit,
  ) async {
    if (state is DistributorRetailerLoaded) {
      final currentState = state as DistributorRetailerLoaded;

      if (event.query.isEmpty) {
        emit(currentState.copyWith(items: currentState.originalItems));
        return;
      }

      final filteredItems = currentState.originalItems!
          .where(
            (item) => (item.businessName ?? "").toLowerCase().contains(
              event.query.toLowerCase(),
            ),
          )
          .toList();

      emit(currentState.copyWith(items: filteredItems));
    }
  }

  Future<void> _onAddDistributorRetailer(
    AddDistributorRetailer event,
    Emitter<DistributorRetailerState> emit,
  ) async {
    emit(DistributorRetailerSubmitting());
    try {
      final response = await repository.addOrUpdateDistributorRetailer(
        event.model,
      );

      if (response['st'] == 'success') {
        emit(
          DistributorRetailerSuccess(
            response['msg'] ?? "${event.model.type} added successfully!",
          ),
        );
      } else {
        emit(
          DistributorRetailerFailure(
            response['msg'] ?? "Something went wrong!",
          ),
        );
      }
    } catch (e) {
      final message = e is ApiException ? e.message : e.toString();
      print("Error from Bloc: $message");
      emit(DistributorRetailerFailure(message));
    }
  }

  Future<void> _onUpdateDistributorRetailer(
    UpdateDistributorRetailer event,
    Emitter<DistributorRetailerState> emit,
  ) async {
    emit(DistributorRetailerSubmitting());
    try {
      final response = await repository.addOrUpdateDistributorRetailer(
        event.model,
      );
      emit(
        DistributorRetailerSuccess(response['msg'] ?? "Updated successfully"),
      );
    } catch (e) {
      final message = _getErrorMessage(e);
      print("Error from Bloc: $message");
      emit(DistributorRetailerFailure(message));
    }
  }
}
