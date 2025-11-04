import 'package:verzusxyz/core/utils/method.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/services/api_service.dart';

class GeneralSettingRepo {
  ApiClient apiClient;
  GeneralSettingRepo({required this.apiClient});

  Future<dynamic> getGeneralSetting() async {
    String url =
        '${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
    ResponseModel response = await apiClient.request(
      url,
      Method.getMethod,
      null,
      passHeader: false,
    );
    print("this bis response${response.responseJson}");
    return response;
  }

  Future<dynamic> getLanguage(String languageCode) async {
    try {
      String url =
          '${UrlContainer.baseUrl}${UrlContainer.languageUrl}$languageCode';
      ResponseModel response = await apiClient.request(
        url,
        Method.getMethod,
        null,
        passHeader: false,
      );
      return response;
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong, 300, '');
    }
  }
}
