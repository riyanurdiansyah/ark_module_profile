import 'package:ark_module_profile/src/core/failures.dart';
import 'package:ark_module_profile/src/domain/entities/city_entity.dart';
import 'package:ark_module_profile/src/domain/entities/coin_entity.dart';
import 'package:ark_module_profile/src/domain/entities/face_recog_entity.dart';
import 'package:ark_module_profile/src/domain/entities/my_course_entity.dart';
import 'package:ark_module_profile/src/domain/entities/profile_entity.dart';
import 'package:ark_module_profile/src/domain/entities/provinsi_entity.dart';
import 'package:ark_module_profile/src/domain/entities/sertifikat_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ArkProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile(String token);

  Stream<CoinEntity> getCoin(String userId);

  Future<Either<Failure, FaceRecogEntity>> getFaceRecog(String token);

  Future<Either<Failure, SertifikatEntity>> getAllCertificate(String userId);

  Future<Either<Failure, bool>> resetPassword(String email, String token);

  Future<Either<Failure, ProvinsiEntity>> getProvinsi();

  Future<Either<Failure, CityEntity>> getCity(int id);

  Future<Either<Failure, bool>> updateProfile(
      ProfileDataEntity profile, String token);

  Future<Either<Failure, bool>> updateCoin(
      String id, Map<String, dynamic> data);

  Future<Either<Failure, bool>> updateProfilePrakerja(
      String token, Map<String, Map<String, Object>> data);

  Future<Either<Failure, List<MyCourseEntity>>> getMyCourse(String token);
}
