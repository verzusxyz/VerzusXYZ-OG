import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';

class WalletScreenRepo {
  ApiClient apiClient;

  WalletScreenRepo({required this.apiClient});

  Future<dynamic> loadData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.transactionEndpoint}';

    final response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }

  Future<ResponseModel> getTransactionList(
    int page, {
    String type = "",
    String remark = "",
    String searchText = "",
    String walletType = '',
  }) async {
    if (type.toLowerCase() == "all" ||
        (type.toLowerCase() != 'plus' && type.toLowerCase() != 'minus')) {
      type = '';
    }

    if (remark.isEmpty || remark.toLowerCase() == "all") {
      remark = '';
    }

    String url =
        '${UrlContainer.baseUrl}${UrlContainer.transactionEndpoint}?page=$page&type=$type&remark=$remark&search=$searchText';
    ResponseModel responseModel = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return responseModel;
  }
}
