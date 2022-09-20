import 'package:ark_module_profile/src/domain/entities/provinsi_entity.dart';

class ProvinsiDTO extends ProvinsiEntity {
  ProvinsiDTO({
    required super.provinsi,
  });

  factory ProvinsiDTO.fromJson(Map<String, dynamic> json) => ProvinsiDTO(
        provinsi: List<ProvinsiDataDTO>.from(
            json["provinsi"].map((x) => ProvinsiDataDTO.fromJson(x))),
      );
}

class ProvinsiDataDTO extends ProvinsiDataEntity {
  ProvinsiDataDTO({
    required super.id,
    required super.nama,
  });

  factory ProvinsiDataDTO.fromJson(Map<String, dynamic> json) =>
      ProvinsiDataDTO(
        id: json["id"],
        nama: json["nama"],
      );
}
