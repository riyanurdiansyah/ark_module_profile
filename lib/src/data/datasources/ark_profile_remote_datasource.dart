import 'package:ark_module_profile/src/data/dto/city_dto.dart';
import 'package:ark_module_profile/src/data/dto/coin_dto.dart';
import 'package:ark_module_profile/src/data/dto/face_recog_dto.dart';
import 'package:ark_module_profile/src/data/dto/my_course_dto.dart';
import 'package:ark_module_profile/src/data/dto/profile_dto.dart';
import 'package:ark_module_profile/src/data/dto/provinsi_dto.dart';
import 'package:ark_module_profile/src/data/dto/sertifikat_dto.dart';
import 'package:ark_module_profile/src/domain/entities/profile_entity.dart';

abstract class ArkProfileRemoteDataSource {
  Future<ProfileDTO> getProfile(String token);

  Stream<CoinDTO> getCoin(String userId);

  Future<FaceRecogDTO> getFaceRecog(String token);

  Future<SertifikatDTO> getAllCertificate(String userId);

  Future<bool> resetPassword(String email, String token);

  Future<ProvinsiDTO> getProvinsi();

  Future<CityDTO> getCity(int id);

  Future<bool> updateProfile(ProfileDataEntity profile, String token);

  Future<bool> updateCoin(String id, Map<String, dynamic> data);

  Future<bool> updateProfilePrakerja(
      String token, Map<String, Map<String, Object>> data);

  Future<List<MyCourseDTO>> getMyCourse(String token);
}
