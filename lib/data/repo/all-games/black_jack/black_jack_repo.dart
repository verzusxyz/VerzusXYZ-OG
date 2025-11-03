import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';

class BlackJackRepo {
  ApiClient apiClient;

  BlackJackRepo({required this.apiClient});

  Future<ResponseModel> blackJackInvest(String invest) async {
    Map<String, String> map = {'invest': invest.toString()};
    String url = '${UrlContainer.baseUrl}${UrlContainer.blackJackInvest}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    return res;
  }

  Future<ResponseModel> blackJackhitRepo(String gameLogId) async {
    Map<String, String> map = {"game_log_id": gameLogId};
    String url = '${UrlContainer.baseUrl}${UrlContainer.blackJackHit}';
    final responseModel = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );

    return responseModel;
  }

  Future<ResponseModel> stay(String gameLogId) async {
    Map<String, String> map = {"game_log_id": gameLogId};
    String url = '${UrlContainer.baseUrl}${UrlContainer.blackJackStay}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );

    return res;
  }

  Future<dynamic> loadData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.blackJackdata}';

    final response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }
}
