import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';

class MinesRepo {
  ApiClient apiClient;

  MinesRepo({required this.apiClient});

  Future<ResponseModel> invest(String invest, String minesNumber) async {
    Map<String, dynamic> map = {
      'invest': invest.toString(),
      'mines': minesNumber,
    };
    String url = '${UrlContainer.baseUrl}${UrlContainer.minesInvest}';

    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    print("this is invest ${res.responseJson}");
    return res;
  }

  Future<ResponseModel> cashOut(String gameId) async {
    Map<String, dynamic> map = {'game_id': gameId};
    String url = '${UrlContainer.baseUrl}${UrlContainer.minesCashOut}';

    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    print("this is cashOut ${res.responseJson}");
    return res;
  }

  Future<ResponseModel> minesEnd(String gameId) async {
    Map<String, dynamic> map = {'game_id': gameId};
    String url = '${UrlContainer.baseUrl}${UrlContainer.minesEnd}';

    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    print("this is minesEnd ${res.responseJson}");
    return res;
  }

  Future<dynamic> loadData() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.minesdata}';

    final response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }
}
