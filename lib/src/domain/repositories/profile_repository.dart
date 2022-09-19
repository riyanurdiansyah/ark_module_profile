import 'package:ark_module_profile/src/core/failures.dart';
import 'package:ark_module_profile/src/domain/entities/coin_entity.dart';
import 'package:ark_module_profile/src/domain/entities/course_entity.dart';
import 'package:ark_module_profile/src/domain/entities/face_recog_entity.dart';
import 'package:ark_module_profile/src/domain/entities/profile_entity.dart';
import 'package:ark_module_profile/src/domain/entities/sertifikat_entitiy.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile(String token);

  Future<Either<Failure, List<CourseEntity>>> getCourse(String token);

  Stream<CoinEntity> getCoin(String userId);

  Future<Either<Failure, FaceRecogEntity>> getFaceRecog(String token);

  Future<Either<Failure, SertifikatEntity>> getAllCertificate(String userId);

  Future<Either<Failure, bool>> resetPassword(String email, String token);
}
