import 'package:softvision_project/apis/apis.dart';

const USER_BASE_URL = "http://www.paketta.ai/backend/v1/user";

class UserServices {
  static Future<Object> saveLastActiveTime() async {
    return await Apis.apiCall(
      'http://www.paketta.ai/backend/v1/user/saveLastActiveTime',
      "PUT",
      (s) {
        return Object();
      },
    );
  }
}
