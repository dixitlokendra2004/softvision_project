import 'package:softvision_project/apis/models/error_response.dart';

class UserError {
  int code;
  ErrorResponse errorResponse;

  UserError(this.code, this.errorResponse);
}