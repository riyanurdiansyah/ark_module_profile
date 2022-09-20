import 'package:ark_module_profile/ark_module_profile.dart';
import 'package:ark_module_profile/src/data/dto/provinsi_dto.dart';
import 'package:ark_module_profile/src/domain/entities/city_entity.dart';
import 'package:ark_module_profile/src/domain/entities/provinsi_entity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ArkEditProfileController extends GetxController {
  final ProfileUseCase _useCase;

  ArkEditProfileController(this._useCase);

  @override
  void onInit() async {
    await _fnSetup();
    // await fnGetProfile();
    await fnGetProvinsi();
    if (_userProvinsi.value.isNotEmpty) {
      await fnGetCity();
      _newProvinsi.value =
          _provinsi[_provinsi.indexWhere((e) => e.nama == _userProvinsi.value)];
    } else {
      newProvinsi.value = _provinsi[0];
    }
    await _fnChangeLoading(false);
    super.onInit();
  }

  final _pC = Get.find<ArkProfileController>();

  final Rx<bool> _isLoading = true.obs;
  Rx<bool> get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final Rx<ProfileEntity> _profile = ProfileEntity().obs;
  Rx<ProfileEntity> get profile => _profile;

  final Rx<String> _token = ''.obs;
  Rx<String> get token => _token;

  final Rx<String> _userProvinsi = ''.obs;
  Rx<String> get userProvinsi => _userProvinsi;

  final RxList<ProvinsiDataEntity> _provinsi = <ProvinsiDataEntity>[].obs;
  RxList<ProvinsiDataEntity> get provinsi => _provinsi;

  final Rx<ProvinsiDataEntity> _newProvinsi =
      ProvinsiDataEntity(id: -1, nama: '').obs;
  Rx<ProvinsiDataEntity> get newProvinsi => _newProvinsi;

  final Rx<CityEntity> _city = const CityEntity(kotaKabupaten: []).obs;
  Rx<CityEntity> get city => _city;

  final TextEditingController _tcName = TextEditingController();
  TextEditingController get tcName => _tcName;

  final TextEditingController _tcHp = TextEditingController();
  TextEditingController get tcHp => _tcHp;

  final TextEditingController _tcProfesiLainnya = TextEditingController();
  TextEditingController get tcProfesiLainnya => _tcProfesiLainnya;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final Rx<String> _txtTanggalLahir = ''.obs;
  Rx<String> get txtTanggalLahir => _txtTanggalLahir;

  final Rx<String> _txtProfesi = ''.obs;
  Rx<String> get txtProfesi => _txtProfesi;

  final Rx<String> _txtCity = ''.obs;
  Rx<String> get txtCity => _txtCity;

  final Rx<String> _txtPendidikan = ''.obs;
  Rx<String> get txtPendidikan => _txtPendidikan;

  final Rx<JenisKelamin> _selectedGender = JenisKelamin.defaultGender.obs;
  Rx<JenisKelamin> get selectedGender => _selectedGender;

  Future _fnSetup() async {
    _token.value = _pC.token.value;
    _userProvinsi.value = _pC.provinsiName.value;
    _tcHp.text = _pC.noHp.value;
    _tcName.text = _pC.name.value;
    _txtProfesi.value = _pC.profesi.value;
    _txtCity.value = _pC.city.value;
    _txtTanggalLahir.value = _pC.tanggalLahir.value;
    _txtProfesi.value = _pC.profesi.value;
    _txtPendidikan.value = _pC.pendidikan.value;
    if (_pC.gender.value == 'L') {
      selectedGender.value = JenisKelamin.pria;
    } else if (_pC.gender.value == 'P') {
      selectedGender.value = JenisKelamin.wanita;
    } else {
      selectedGender.value = JenisKelamin.defaultGender;
    }
  }

  Future _fnChangeLoading(bool val) async {
    _isLoading.value = val;
  }

  Future fnGetProfile() async {
    _fnChangeLoading(true);
    final response = await _useCase.getProfile(_token.value);
    response.fold(
      ///IF RESPONSE IS ERROR
      (fail) {
        if (fail is HttpFailure) {
          Fluttertoast.showToast(msg: "Error ${fail.code}x : ${fail.message}");
          _errorMessage = fail.message;
        } else {
          _errorMessage =
              'Failed connect to server \n Please check your connection';
        }
        _profile.value = ProfileEntity.withError(errorMessage);
      },

      ///IF RESPONSE SUCCESS
      (data) {
        _profile.value = data;
      },
    );
    await _fnChangeLoading(false);
  }

  Future fnGetProvinsi() async {
    final response = await _useCase.getProvinsi();
    response.fold(
      ///IF RESPONSE IS ERROR
      (fail) {
        if (fail is HttpFailure) {
          Fluttertoast.showToast(msg: "Error ${fail.code}x : ${fail.message}");
          _errorMessage = fail.message;
        } else {
          _errorMessage =
              'Failed connect to server \n Please check your connection';
        }
      },

      ///IF RESPONSE SUCCESS
      (data) {
        _provinsi.value = data.provinsi;
        _provinsi.insert(
            0, ProvinsiDataDTO(id: -1, nama: 'Silahkan Pilih Provinsi'));
        _txtCity.value = '';
      },
    );
  }

  Future fnGetCity() async {
    final id = _provinsi[_provinsi.indexWhere((e) =>
            e.nama.toLowerCase().contains(_userProvinsi.value.toLowerCase()))]
        .id;
    final response = await _useCase.getCity(id);
    response.fold(
      ///IF RESPONSE IS ERROR
      (fail) {
        if (fail is HttpFailure) {
          Fluttertoast.showToast(msg: "Error ${fail.code}x : ${fail.message}");
          _errorMessage = fail.message;
        } else {
          _errorMessage =
              'Failed connect to server \n Please check your connection';
        }
      },

      ///IF RESPONSE SUCCESS
      (data) {
        _city.value = data;
      },
    );
  }

  void fnGetNewCity() async {
    final response = await _useCase.getCity(_newProvinsi.value.id);
    response.fold(
      ///IF RESPONSE IS ERROR
      (fail) {
        if (fail is HttpFailure) {
          Fluttertoast.showToast(msg: "Error ${fail.code}x : ${fail.message}");
          _errorMessage = fail.message;
        } else {
          _errorMessage =
              'Failed connect to server \n Please check your connection';
        }
      },

      ///IF RESPONSE SUCCESS
      (data) {
        _city.value = data;
        _txtCity.value = _city.value.kotaKabupaten[0].nama;
      },
    );
  }

  void fnOnChangedProvinsi(ProvinsiDataEntity? value) {
    _newProvinsi.value = value!;
    _txtCity.value = '';
    fnGetNewCity();
  }

  void fnOnChangedGender(JenisKelamin? val) {
    _selectedGender.value = val!;
    if (_selectedGender.value == JenisKelamin.pria) {
      _pC.gender.value = 'Laki-laki';
    } else if (_selectedGender.value == JenisKelamin.wanita) {
      _pC.gender.value = 'Perempuan';
    } else {
      _pC.gender.value = '';
    }
  }
}
