import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';

class HeadTailRepo {
  ApiClient apiClient;

  HeadTailRepo({required this.apiClient});

  Future<ResponseModel> submitAnswer(String invest, String choose) async {
    String chooseBet = choose.isEmpty ? "" : choose.toString();

    Map<String, String> map = {
      'invest': invest.toString(),
      'choose': chooseBet.toString(),
    };
    String url = '${UrlContainer.baseUrl}${UrlContainer.headTailSubmitAnswer}';
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
    String url = '${UrlContainer.baseUrl}${UrlContainer.headTailResult}';
    final responseModel = await apiClient.request(
      url,
      Method.postMethod,
      map,
      passHeader: true,
    );

    return responseModel;
  }

  Future<dynamic> loadGameInformation() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.headTaildata}';

    final response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: true,
    );
    return response;
  }
}
