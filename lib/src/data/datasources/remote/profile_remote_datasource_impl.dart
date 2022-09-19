import 'dart:developer';
import 'package:ark_module_profile/ark_module_profile.dart';
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
    log("RESPONSE GET COURSE : ${response.data}");
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
}
