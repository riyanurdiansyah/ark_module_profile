import 'package:ark_module_profile/src/core/failures.dart';
import 'package:ark_module_profile/src/domain/entities/coin_entity.dart';
import 'package:ark_module_profile/src/domain/entities/course_entity.dart';
import 'package:ark_module_profile/src/domain/entities/face_recog_entity.dart';
import 'package:ark_module_profile/src/domain/entities/profile_entity.dart';
import 'package:ark_module_profile/src/domain/entities/sertifikat_entitiy.dart';
import 'package:ark_module_profile/src/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileUseCase {
  final ProfileRepository repository;

  ProfileUseCase(this.repository);

  Future<Either<Failure, ProfileEntity>> getProfile(String token) async =>
      await repository.getProfile(token);

  Future<Either<Failure, List<CourseEntity>>> getCourse(String token) async =>
      await repository.getCourse(token);

  Stream<CoinEntity> getCoin(String userId) => repository.getCoin(userId);

  Future<Either<Failure, FaceRecogEntity>> getFaceRecog(String token) async =>
      await repository.getFaceRecog(token);

  Future<Either<Failure, SertifikatEntity>> getAllCertificate(
          String userId) async =>
      await repository.getAllCertificate(userId);

  Future<Either<Failure, bool>> resetPassword(
          String email, String token) async =>
      await repository.resetPassword(email, token);
}
