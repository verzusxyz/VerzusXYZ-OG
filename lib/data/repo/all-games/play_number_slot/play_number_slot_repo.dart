import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';

class PlayNumberSlotRepo {
  ApiClient apiClient;

  PlayNumberSlotRepo({required this.apiClient});

  Future<ResponseModel> submitAnswer(String invest, String choose) async {
    Map<String, String> map = {
      'invest': invest.toString(),
      'choose': choose.toString(),
    };
    String url = '${UrlContainer.baseUrl}${UrlContainer.numberSlotAnswer}';
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
    String url = '${UrlContainer.baseUrl}${UrlContainer.numberSlotResult}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    return res;
  }

  Future<dynamic> loadData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.numberSlotdata}';

    final response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }
}
