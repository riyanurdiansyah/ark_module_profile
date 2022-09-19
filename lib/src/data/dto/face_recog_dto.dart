import 'package:ark_module_profile/src/domain/entities/face_recog_entity.dart';

class FaceRecogDTO extends FaceRecogEntity {
  FaceRecogDTO({
    required super.base64image,
    required super.subjectId,
  });

  factory FaceRecogDTO.fromJson(Map<String, dynamic> json) => FaceRecogDTO(
        base64image: json['face_recog_image'],
        subjectId: json['subject_id'],
      );
}
