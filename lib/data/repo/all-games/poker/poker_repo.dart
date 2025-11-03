import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';

class PokerRepo {
  ApiClient apiClient;

  PokerRepo({required this.apiClient});

  Future<ResponseModel> investRepo(String invest) async {
    Map<String, String> map = {'invest': invest.toString()};
    String url = '${UrlContainer.baseUrl}${UrlContainer.pokerInvest}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    return res;
  }

  Future<ResponseModel> dealRepo(String gameID) async {
    Map<String, String> map = {'game_id': gameID.toString()};
    String url = '${UrlContainer.baseUrl}${UrlContainer.pokerDeal}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );
    return res;
  }

  Future<ResponseModel> callRepo(String gameID) async {
    Map<String, String> map = {'game_id': gameID.toString()};
    String url = '${UrlContainer.baseUrl}${UrlContainer.pokerCall}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );

    return res;
  }

  Future<ResponseModel> foldRepo(String gameID) async {
    Map<String, String> map = {'game_id': gameID.toString()};
    String url = '${UrlContainer.baseUrl}${UrlContainer.pokerFold}';
    final res = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );

    return res;
  }

  Future<dynamic> loadDataRepo() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.pokerdata}';

    final response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }
}
