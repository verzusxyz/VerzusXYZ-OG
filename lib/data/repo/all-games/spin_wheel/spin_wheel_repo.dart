import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';

class SpinWheelRepo {
  ApiClient apiClient;

  SpinWheelRepo({required this.apiClient});

  Future<ResponseModel> submitAnswer(String invest, String choose) async {
    String chooseBet = choose.isEmpty ? "" : choose.toString();

    Map<String, String> map = {
      'invest': invest.toString(),
      'choose': chooseBet.toString(),
    };
    String url = '${UrlContainer.baseUrl}${UrlContainer.spinWheelSubmitAnswer}';
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
    String url = '${UrlContainer.baseUrl}${UrlContainer.spinWheelResult}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    return res;
  }

  Future<dynamic> loadData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.spinWheeldata}';

    final response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }
}
