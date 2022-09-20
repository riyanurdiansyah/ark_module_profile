import 'dart:developer';
import 'package:ark_module_profile/ark_module_profile.dart';
import 'package:ark_module_profile/src/data/dto/city_dto.dart';
import 'package:ark_module_profile/src/data/dto/face_recog_dto.dart';
import 'package:ark_module_profile/src/data/dto/provinsi_dto.dart';
import 'package:ark_module_profile/utils/app_url.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  late Dio dio;
  ProfileRemoteDataSourceImpl({Dio? dio}) {
    this.dio = dio ?? Dio();
  }
  @override
  Future<ProfileDTO> getProfile(String token) async {
    final response = await dio.get(
      profileUrl,
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
    log("RESPONSE GET PROFILE : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code >= 500) {
      throw CustomException(code, 'Error... failed connect to server');
    } else if (code != 200) {
      throw CustomException(
          code, response.data['message'] ?? 'Failed... Please try again');
    } else {
      return ProfileDTO.fromJson(response.data);
    }
  }

  @override
  Future<List<CourseDTO>> getCourse(String token) async {
    final response = await dio.get(
      courseUrl,
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
    int code = response.statusCode ?? 500;
    if (code >= 500) {
      throw CustomException(code, 'Error... failed connect to server');
    } else if (code != 200) {
      throw CustomException(
          code, response.data['message'] ?? 'Failed... Please try again');
    } else {
      List<CourseDTO> listCourse = [];
      for (var data in response.data) {
        listCourse.add(CourseDTO.fromJson(data));
      }
      return listCourse;
    }
  }

  @override
  Stream<CoinDTO> getCoin(String userId) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream =
        FirebaseFirestore.instance.collection("coins").doc(userId).snapshots();
    return stream.map(
      (event) {
        if (event.data() != null) {
          if (event.exists) {
            return CoinDTO.fromJson(event.data()!);
          } else {
            return CoinDTO();
          }
        } else {
          return CoinDTO();
        }
      },
    );
  }

  @override
  Future<FaceRecogDTO> getFaceRecog(String token) async {
    final response = await dio.get(
      faceRecogUrl,
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
    int code = response.statusCode ?? 500;
    if (code >= 500) {
      throw CustomException(code, 'Error... failed connect to server');
    } else if (code != 200) {
      throw CustomException(
          code, response.data['message'] ?? 'Failed... Please try again');
    } else {
      return FaceRecogDTO.fromJson(response.data);
    }
  }

  @override
  Future<SertifikatDTO> getAllCertificate(String userId) async {
    final response = await dio.get("$sertifUrl/$userId");
    log("RESPONSE GET ALL CERTIFICATE : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code >= 500) {
      throw CustomException(code, 'Error... failed connect to server');
    } else if (code != 200) {
      throw CustomException(
          code, response.data['message'] ?? 'Failed... Please try again');
    } else {
      return SertifikatDTO.fromJson(response.data);
    }
  }

  @override
  Future<bool> resetPassword(String email, String token) async {
    final response = await dio.post(
      resetPasswordUrl,
      data: {
        "email": email,
      },
      options: Options(headers: {
        'Authorization': token,
      }),
    );
    log("RESPONSE RESET PASSWORD : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code >= 500) {
      throw CustomException(code, 'Error... failed connect to server');
    } else if (code != 200) {
      throw CustomException(
          code, response.data['message'] ?? 'Failed... Please try again');
    } else {
      return response.data['success'];
    }
  }

  @override
  Future<ProvinsiDTO> getProvinsi() async {
    final response = await dio.get(provinsiUrl);
    log("RESPONSE GET PROVINSI : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code >= 500) {
      throw CustomException(code, 'Error... failed connect to server');
    } else if (code != 200) {
      throw CustomException(
          code, response.data['message'] ?? 'Failed... Please try again');
    } else {
      return ProvinsiDTO.fromJson(response.data);
    }
  }

  @override
  Future<CityDTO> getCity(int id) async {
    final response = await dio.get("$cityUrl=$id");
    log("RESPONSE GET CITY : ${response.data}");
    int code = response.statusCode ?? 500;
    if (code >= 500) {
      throw CustomException(code, 'Error... failed connect to server');
    } else if (code != 200) {
      throw CustomException(
          code, response.data['message'] ?? 'Failed... Please try again');
    } else {
      return CityDTO.fromJson(response.data);
    }
  }
}
