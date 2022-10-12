import 'package:ark_module_profile/src/domain/entities/coin_entity.dart';

class CoinDTO extends CoinEntity {
  const CoinDTO({
    required super.coins,
    required super.isCompleted,
    required super.isOldUser,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CoinDTO.fromJson(Map<String, dynamic> json) => CoinDTO(
        coins: json["coins"] ?? 0,
        isCompleted: json["isCompleted"],
        isOldUser: json["isOldUser"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );
}
