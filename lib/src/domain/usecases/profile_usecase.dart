import 'package:ark_module_profile/src/core/failures.dart';
import 'package:ark_module_profile/src/domain/entities/coin_entity.dart';
import 'package:ark_module_profile/src/domain/entities/course_entity.dart';
import 'package:ark_module_profile/src/domain/entities/profile_entity.dart';
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
}
