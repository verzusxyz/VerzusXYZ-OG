import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';

class RouletteRepo {
  ApiClient apiClient;

  RouletteRepo({required this.apiClient});

  Future<ResponseModel> submitAnswer(String invest, String choose) async {
    String chooseBet = choose.isEmpty
        ? ""
        : choose.toString().replaceAll('[', '').replaceAll(']', '');

    Map<String, String> map = {
      'invest': invest.toString(),
      'choose': chooseBet.toString(),
    };

    String url = '${UrlContainer.baseUrl}${UrlContainer.rouletteSubmitAnswer}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    print("roulette response +${res.responseJson}");
    return res;
  }

  Future<ResponseModel> getAnswer(String gameID) async {
    Map<String, String> map = {'gameLog_id': gameID.toString()};
    String url = '${UrlContainer.baseUrl}${UrlContainer.rouletteResult}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    print("roulette ans response +${res.responseJson}");
    return res;
  }

  Future<dynamic> loadData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.roulettedata}';

    final response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }
}
