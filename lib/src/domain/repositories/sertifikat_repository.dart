import 'package:ark_module_profile/src/core/failures.dart';
import 'package:ark_module_profile/src/domain/entities/sertifikat_entitiy.dart';
import 'package:dartz/dartz.dart';

abstract class SertifikatRepository {
  Future<Either<Failure, SertifikatEntity>> getAllCertificate(String userId);
}
