import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';

class CasinoDiceRepo {
  ApiClient apiClient;

  CasinoDiceRepo({required this.apiClient});

  Future<ResponseModel> submitAnswer(
    String percent,
    String invest,
    String range,
  ) async {
    Map<String, String> map = {
      'percent': percent.toString(),
      'invest': invest.toString(),
      'range': range.toString(),
    };
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.casinoDiceSubmitAnswer}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    return res;
  }

  Future<ResponseModel> getAnswer(String gameID) async {
    Map<String, String> map = {'game_id': gameID.toString()};
    String url = '${UrlContainer.baseUrl}${UrlContainer.casinoDiceResult}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    return res;
  }

  Future<dynamic> loadData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.casinoDicedata}';

    final response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }
}
