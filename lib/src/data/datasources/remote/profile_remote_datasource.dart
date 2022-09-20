import 'package:ark_module_profile/ark_module_profile.dart';
import 'package:ark_module_profile/src/data/dto/city_dto.dart';
import 'package:ark_module_profile/src/data/dto/face_recog_dto.dart';
import 'package:ark_module_profile/src/data/dto/provinsi_dto.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileDTO> getProfile(String token);

  Future<List<CourseDTO>> getCourse(String token);

  Stream<CoinDTO> getCoin(String userId);

  Future<FaceRecogDTO> getFaceRecog(String token);

  Future<SertifikatDTO> getAllCertificate(String userId);

  Future<bool> resetPassword(String email, String token);

  Future<ProvinsiDTO> getProvinsi();

  Future<CityDTO> getCity(int id);

  Future<bool> updateProfile(ProfileDataEntity profile, String token);

  Future<bool> updateCoin(String id, Map<String, dynamic> data);
}
