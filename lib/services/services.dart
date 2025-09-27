import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:softvision_project/model/users.dart';
import 'package:softvision_project/utils/sp_helper.dart';

import '../apis/apis.dart';
import '../constants.dart';
import '../model/all_associates_model.dart';
import '../model/image_model.dart';
import '../model/location_model.dart';

import 'package:http/http.dart' as http;
import '../model/login_model.dart';
import '../model/student_model.dart';

class Services {
  static Future<Object> searchLocationByCity(String cityName) async {
    return await Apis.apiCall(
      '$BASE_URL/locations/searchLocationByCity',
      "GET",
      queryParams: {"name": cityName},
      showSnackBarOnUserError: false,
          (s) {
        return locationModelFromJson(s);
      },
    );
  }


  static Future<List<Students>> getRegisterStudents(String userEmail, String queryString) async {

   try {
     print('$BASE_URL/getAllStudents.php?userEmail='+userEmail);
     final response = await http.get(Uri.parse('$BASE_URL/getAllStudents.php?userEmail='+userEmail+'&queryString='+queryString));
     print(response.body);
     print(response.statusCode);
     if (response.statusCode == 200) {
       return studentsFromJson(response.body);
     } else {
       return [];
     }
   } catch (error) {
     return [];
   }
  }

  // static Future<Object> getRegisterStudents(Map<String, String> requestBody) async {
  //   return await Apis.apiCall(
  //     '$BASE_URL/locations/searchLocationByCity',
  //     "GET",
  //     queryParams: {"name": cityName},
  //     showSnackBarOnUserError: false,
  //         (s) {
  //       return locationModelFromJson(s);
  //     },
  //   );
  // }


  static Future<List<Users>> getAllUsers(String queryString) async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL/get_all_users.php?queryString='+queryString));
      if (response.statusCode == 200) {
        print(response.body);
        return  usersFromJson(response.body);
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  static Future<List<Users>> getUsers(String queryString) async {
    try {
      print('$BASE_URL/get_users.php?queryString='+queryString);
      final response = await http.get(Uri.parse('$BASE_URL/get_users.php?queryString='+queryString));
      if (response.statusCode == 200) {
        print(response.body);
        return  usersFromJson(response.body);
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  // static Future<List<Users>> getChangePassword(String queryString) async {
  //   try {
  //     print('$BASE_URL/get_users.php?queryString='+queryString);
  //     final response = await http.get(Uri.parse('$BASE_URL/change_password.php?queryString='+queryString));
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       return  usersFromJson(response.body);
  //     } else {
  //       return [];
  //     }
  //   } catch (error) {
  //     return [];
  //   }
  // }

  // static getChangePassword(String email,String password) {
  //
  // }

 static  Future<int> login(String email, String password) async {
   int result = 2;
   Map<String, String> requestBody = {
     'email': email,
     'password': password,
   };
   try {
     http.Response response = await http.post(
       Uri.parse( '$BASE_URL/login.php'),
       body: requestBody,
     );

     // Check if the request was successful (status code 200)
     if (response.statusCode == 200) {
       Map<String, dynamic> responseData = json.decode(response.body);
       result = responseData['result'];
       print(responseData);
       Map<String, dynamic> userData = responseData['user'];
       //Map<String, dynamic> userData = json.decode(userInfo);
       SharedPreferencesHelper.saveUserInfo(userData["name"],userData["address"],userData["mobile_number"],userData["institute"]);
       SharedPreferencesHelper.userName = userData["name"];
       return result;
     } else {
       print('Request failed with status: ${response.statusCode}');
     }
   } catch (e) {
     print('Error: $e');
   }
   return result;
  }

  static  Future<int> getChangePassword(String email, String password) async {
    int result = 2;
    Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };
    print(requestBody);
    try {
      http.Response response = await http.post(
        Uri.parse( '$BASE_URL/change_password.php'),
        body: requestBody,
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        result = responseData['result'];
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }

  static  Future<int> registration(Map<String, String> requestBody) async {
    int result = 0;
    try {
      http.Response response = await http.post(
        Uri.parse( '$BASE_URL/registration.php'),
        body: requestBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        result = responseData['result'];
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }



  static  Future<int> registerStudent(Map<String, String> requestBody) async {
    int result = 13;
    //  Map<String, String> requestBody = {
    // 'studentName': studentName,
    // 'email': email,
    // "number": number,
    // "watssapNo": watssapNo,
    // "fatherName": fatherName,
    // "fatherNumber": fatherNo,
    // "schoolName": schoolName,
    // "city": city,
    // "emailIdStudent": emailIdStudent,
    // "district": district,
    // "comments": comments,
    // "counsellingDoneBy": counsellingDoneBy,
    // "dateOfCounselling": dateOfCounselling,
    //  };
    try {
      http.Response response = await http.post(
        Uri.parse( '$BASE_URL/registerstudent.php'),
        body: requestBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> responseData = json.decode(response.body);
        result = responseData['result'];
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }

  static  Future<int> registerUser(Map<String, String> requestBody) async {
    int result = 5;
    try {
      print(requestBody.toString());
      http.Response response = await http.post(
        Uri.parse( '$BASE_URL/registeruser.php'),
        body: requestBody,
      );
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> responseData = json.decode(response.body);
        result = responseData['result'];
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }

  static  Future<int> profileUpdate(Map<String, String> requestBody) async {
    int result = 5;
    try {
      http.Response response = await http.post(
        Uri.parse( '$BASE_URL/updateuser.php'),
        body: requestBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> responseData = json.decode(response.body);
        result = responseData['result'];
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }

  static  Future<int> getRegisterStudent(Map<String, String> requestBody) async {
    int result = 13;
    try {
      http.Response response = await http.post(
        Uri.parse( '$BASE_URL/getAllStudents.php'),
        body: requestBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print(studentsFromJson("str").toString());
        Map<String, dynamic> responseData = json.decode(studentsFromJson("str").toString());
        result = responseData['result'];
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }

  static updateUserStatus(String email, bool value) async {
    int result = 0;
    try {
      Map<String, String> requestBody = {
        'email': email,
        "active": value ? "1" : "0",
      };
      http.Response response = await http.post(
        Uri.parse( '$BASE_URL/update_user.php'),
        body: requestBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> responseData = json.decode(response.body);
        result = responseData['result'];
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }

  static Future<List<Students>> getAllStudents(String queryString) async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL/get_all_students.php?queryString='+queryString));
      if (response.statusCode == 200) {
        print(response.body);
        List<Students> students =   studentsFromJson(response.body);
        print(students);
        return students;
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  static Future<List<Students>> getAllStudentsByDate(String queryString) async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL/get_all_students_bydate.php?selectedDate='+queryString));
      if (response.statusCode == 200) {
        print(response.body);
        List<Students> students =   studentsFromJson(response.body);
        print(students);
        return students;
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  static Future<List<AllAssociates>> getAssociates(String queryString) async {
    try {
      print(queryString);
      final response = await http.get(Uri.parse('$BASE_URL/getAllAssociates.php?queryString='+queryString));
      if (response.statusCode == 200) {
        print(response.body);
        List<AllAssociates> associates =  allAssociatesFromJson(response.body);
        print(associates);
        return associates;
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  static updateStudentStatus(String id, bool value) async {
    int result = 0;
    try {
      Map<String, String> requestBody = {
        'id': id,
        "paymentStatus": value ? "1" : "0",
      };
      http.Response response = await http.post(
        Uri.parse( '$BASE_URL/update_student.php'),
        body: requestBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> responseData = json.decode(response.body);
        result = responseData['result'];
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }


  static updateStudentInfo(String id, bool document, bool fees, String adimitted,String adminComments) async {
    int result = 0;
    try {
      Map<String, String> requestBody = {
        'id': id,
        "document": document ? "1" : "0",
        "admitted": adimitted,
        "fees": fees ? "1" : "0",
        "admin_comments": adminComments,
      };

      http.Response response = await http.post(
        Uri.parse( '$BASE_URL/update_student_info.php'),
        body: requestBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> responseData = json.decode(response.body);
        result = responseData['result'];
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }




  static getStudentsById(String id) async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL/get_students_by_id.php?id='+id));
      if (response.statusCode == 200) {
        print(response.body);
        List<Students> students = studentsFromJson(response.body);
        print(students);
        return students;
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  static Future<List<AllImages>> getAllImages() async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL/get_all_promo.php'));
      if (response.statusCode == 200) {
        print(response.body);
        List<AllImages> images = allImagesFromJson (response.body);

        return images;
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  static updateImageStatus(String  id) async {
    int result = 0;
    try {
      Map<String, String> requestBody = {
        'id': id,
      };
      print(requestBody);
      http.Response response = await http.post(
        Uri.parse( '$BASE_URL/update_image_status.php'),
        body: requestBody,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> responseData = json.decode(response.body);
        result = responseData['result'];
        return result;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }
}

