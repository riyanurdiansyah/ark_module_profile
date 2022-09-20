class ProvinsiEntity {
  ProvinsiEntity({
    required this.provinsi,
  });

  final List<ProvinsiDataEntity> provinsi;
}

class ProvinsiDataEntity {
  ProvinsiDataEntity({
    required this.id,
    required this.nama,
  });

  final int id;
  final String nama;
}
