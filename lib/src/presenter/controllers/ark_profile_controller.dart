import 'dart:developer';

import 'package:ark_module_profile/ark_module_profile.dart';
import 'package:ark_module_profile/src/domain/entities/face_recog_entity.dart';
import 'package:ark_module_profile/utils/app_dialog.dart';
import 'package:ark_module_profile/utils/app_url.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArkProfileController extends GetxController {
  final ProfileUseCase _useCase;

  ArkProfileController(this._useCase);

  @override
  void onInit() async {
    await _fnSetup();
    await fnGetProfile();
    _fnGetFaceRecog();
    await fnGetCourse();
    await _fnChangeLoading(false);
    super.onInit();
  }

  final _googleSignIn = GoogleSignIn();
  final _googleSignInIos = GoogleSignIn(
    hostedDomain: baseUrl,
    clientId:
        '265001851813-uvseu68037o8lpo126p679sbm3sesns6.apps.googleusercontent.com',
  );

  late SharedPreferences prefs;

  final Rx<bool> _isLogin = false.obs;
  Rx<bool> get isLogin => _isLogin;

  final Rx<String> _token = ''.obs;
  Rx<String> get token => _token;

  final Rx<String> _tokenWP = ''.obs;
  Rx<String> get tokenWP => _tokenWP;

  final Rx<String> _userId = ''.obs;
  Rx<String> get userId => _userId;

  final Rx<String> _avatar = ''.obs;
  Rx<String> get avatar => _avatar;

  final Rx<String> _name = ''.obs;
  Rx<String> get name => _name;

  final Rx<String> _email = ''.obs;
  Rx<String> get email => _email;

  final Rx<bool> _isLoading = true.obs;
  Rx<bool> get isLoading => _isLoading;

  final Rx<bool> _isLoadingFaceRecog = true.obs;
  Rx<bool> get isLoadingFaceRecog => _isLoadingFaceRecog;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  final Rx<int> _jmlKelasSelesai = 0.obs;
  Rx<int> get jmlKelasSelesai => _jmlKelasSelesai;

  final RxList<CourseEntity> _listCourse = <CourseEntity>[].obs;
  RxList<CourseEntity> get listCourse => _listCourse;

  final Rx<ProfileEntity> _profile = ProfileEntity().obs;
  Rx<ProfileEntity> get profile => _profile;

  final Rx<FaceRecogEntity> _faceRecog =
      const FaceRecogEntity(base64image: '', subjectId: '').obs;

  Rx<FaceRecogEntity> get faceRecog => _faceRecog;

  Future _fnChangeLoading(bool val) async {
    _isLoading.value = val;
  }

  Future _fnSetup() async {
    prefs = await SharedPreferences.getInstance();
    _isLogin.value = prefs.getBool('user_login') ?? false;
    _token.value = prefs.getString('token_access') ?? '';
    _tokenWP.value = prefs.getString('token_access_wp') ?? '';
    _avatar.value = prefs.getString('user_avatar') ?? '';
    _name.value = prefs.getString('user_name') ?? '';
    _email.value = prefs.getString('user_email') ?? '';
    _userId.value = prefs.getString('user_id') ?? '';
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

  Future fnGetCourse() async {
    _fnChangeLoading(true);
    final response = await _useCase.getCourse(_token.value);
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
        _jmlKelasSelesai.value =
            data.where((e) => e.userStatus == '4').toList().length;
        _listCourse.value = data;
      },
    );
    await _fnChangeLoading(false);
  }

  Stream<CoinEntity> fnGetCoin() {
    return _useCase.getCoin(userId.value).map((event) => event);
  }

  void _fnGetFaceRecog() async {
    _isLoadingFaceRecog.value = true;
    final response = await _useCase.getFaceRecog(_tokenWP.value);
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
        _faceRecog.value = data;
      },
    );
    _isLoadingFaceRecog.value = false;
  }

  void fnConfirmLogout() {
    AppDialog.dialogWithQuestion(
      'Keluar',
      'Anda yakin ingin keluar?',
      'Batal',
      'Lanjut',
      () {},
    );
  }

  void fnResetPassword() async {
    log('RESET PASSWORD');
    final response = await _useCase.resetPassword(_email.value, _token.value);
    response.fold(
      ///IF RESPONSE IS ERROR
      (fail) {
        if (fail is HttpFailure) {
          Fluttertoast.showToast(msg: "Error ${fail.code}x : ${fail.message}");
          _errorMessage = fail.message;
        } else {
          _errorMessage =
              'Failed connect to server \n Please check your connection';
          Fluttertoast.showToast(msg: "Error 500x : $_errorMessage");
        }
      },

      ///IF RESPONSE SUCCESS
      (data) {
        AppDialog.dialogSuccesState(
            'Tautan ubah password terkirim ke email anda!');
        Future.delayed(const Duration(seconds: 2), () {
          Get.back();
        });
      },
    );
  }
}
