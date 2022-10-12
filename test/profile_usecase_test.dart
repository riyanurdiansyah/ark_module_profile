import 'package:ark_module_profile/ark_module_profile.dart';
import 'package:ark_module_profile/src/data/dto/provinsi_dto.dart';
import 'package:ark_module_profile/src/domain/entities/provinsi_entity.dart';
import 'package:ark_module_setup/ark_module_setup.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'profile_usecase_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late ProfileRemoteDataSourceImpl datasource;
  late ProfileRepositoryImpl repository;
  late ProfileUseCase useCase;

  setUpAll(() {
    mockDio = MockDio();
    datasource = ProfileRemoteDataSourceImpl(dio: mockDio);
    repository = ProfileRepositoryImpl(datasource);
    useCase = ProfileUseCase(repository);
  });
  test('Get Provinsi Success', () async {
    ProvinsiEntity provinsi = const ProvinsiEntity(provinsi: []);
    when(mockDio.get(provinsiUrl)).thenAnswer(
      (_) => Future.value(
        Response<dynamic>(
          statusCode: 200,
          requestOptions: RequestOptions(
            path: provinsiUrl,
          ),
          data: {
            "provinsi": [
              {"id": 11, "nama": "Aceh"},
              {"id": 12, "nama": "Sumatera Utara"},
              {"id": 13, "nama": "Sumatera Barat"},
              {"id": 14, "nama": "Riau"},
              {"id": 15, "nama": "Jambi"},
              {"id": 16, "nama": "Sumatera Selatan"},
              {"id": 17, "nama": "Bengkulu"},
              {"id": 18, "nama": "Lampung"},
              {"id": 19, "nama": "Kepulauan Bangka Belitung"},
              {"id": 21, "nama": "Kepulauan Riau"},
              {"id": 31, "nama": "Dki Jakarta"},
              {"id": 32, "nama": "Jawa Barat"},
              {"id": 33, "nama": "Jawa Tengah"},
              {"id": 34, "nama": "Di Yogyakarta"},
              {"id": 35, "nama": "Jawa Timur"},
              {"id": 36, "nama": "Banten"},
              {"id": 51, "nama": "Bali"},
              {"id": 52, "nama": "Nusa Tenggara Barat"},
              {"id": 53, "nama": "Nusa Tenggara Timur"},
              {"id": 61, "nama": "Kalimantan Barat"},
              {"id": 62, "nama": "Kalimantan Tengah"},
              {"id": 63, "nama": "Kalimantan Selatan"},
              {"id": 64, "nama": "Kalimantan Timur"},
              {"id": 65, "nama": "Kalimantan Utara"},
              {"id": 71, "nama": "Sulawesi Utara"},
              {"id": 72, "nama": "Sulawesi Tengah"},
              {"id": 73, "nama": "Sulawesi Selatan"},
              {"id": 74, "nama": "Sulawesi Tenggara"},
              {"id": 75, "nama": "Gorontalo"},
              {"id": 76, "nama": "Sulawesi Barat"},
              {"id": 81, "nama": "Maluku"},
              {"id": 82, "nama": "Maluku Utara"},
              {"id": 91, "nama": "Papua Barat"},
              {"id": 94, "nama": "Papua"}
            ]
          },
        ),
      ).then((value) {
        provinsi = ProvinsiDTO.fromJson(value.data);
        return value;
      }),
    );

    final response = await useCase.getProvinsi();
    response.fold((fail) {
      if (fail is HttpFailure) {
        expect(500, fail.code);
      }
    }, (data) {
      expect(provinsi, data);
    });
  });
}
