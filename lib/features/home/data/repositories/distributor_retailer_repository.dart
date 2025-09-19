import 'package:dio/dio.dart';
import 'package:distributor_retailer_app/core/error/api_exception.dart';
import 'package:distributor_retailer_app/core/network/api_client.dart';
import 'package:distributor_retailer_app/core/network/api_endpoint.dart';
import 'package:distributor_retailer_app/features/home/data/model/distributor_retailer_model.dart';
import 'package:distributor_retailer_app/features/home/data/model/add_distributor_retailer_model.dart';

class DistributorRetailerRepository {
  final ApiClient apiClient;

  DistributorRetailerRepository(this.apiClient);

  Future<DistributorRetailerModel> fetchDistributorRetailer({
    required String type,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await apiClient.get(
        ApiEndpoints.getDistriRetailUrl(page),
        headers: {"Authorization": "4ccda7514adc0f13595a585205fb9761"},
        data: {"type": type},
      );

      if (response['st'] != 'success') {
        throw ApiException(response['msg']);
      }

      print("API Response: $response");
      return DistributorRetailerModel.fromJson(response);
    } catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  Future<Map<String, dynamic>> addOrUpdateDistributorRetailer(
    AddDistributorRetailerModel model,
  ) async {
    try {
      final formData = FormData.fromMap(model.toJson());

      print("FormData fields: ${model.toJson()}");

      if (model.imagePath != null && model.imagePath!.isNotEmpty) {
        formData.files.add(
          MapEntry(
            "image",
            await MultipartFile.fromFile(
              model.imagePath!,
              filename: model.imagePath!.split('/').last,
            ),
          ),
        );

        print("Image added: ${model.imagePath!}");
      }

      formData.fields.forEach((field) {
        print("Field: ${field.key} = ${field.value}");
      });
      formData.files.forEach((file) {
        print("File: ${file.key} = ${file.value.filename}");
      });

      final response = await apiClient.post(
        ApiEndpoints.addDistributorUrl,
        headers: {"Authorization": "4ccda7514adc0f13595a585205fb9761"},
        data: formData,
      );
      print("API Response: $response");
      return response;
    } catch (e) {
      print("API Error in addOrUpdateDistributorRetailer: $e");
      if (e is DioException) {
        final errorMsg = e.response?.data?['msg'] ?? e.message;
        throw ApiException(errorMsg);
      }
      throw ApiException(e.toString());
    }
  }
}
