import 'package:ark_module_profile/src/data/dto/coin_dto.dart';
import 'package:ark_module_profile/src/data/dto/course_dto.dart';
import 'package:ark_module_profile/src/data/dto/profile_dto.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileDTO> getProfile(String token);

  Future<List<CourseDTO>> getCourse(String token);

  Stream<CoinDTO> getCoin(String userId);
}
