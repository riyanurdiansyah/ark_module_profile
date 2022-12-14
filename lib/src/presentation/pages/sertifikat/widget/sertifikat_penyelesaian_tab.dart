import 'package:ark_module_profile/ark_module_profile.dart';
import 'package:ark_module_setup/ark_module_setup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SertifikatPenyelesaianTab extends StatelessWidget {
  SertifikatPenyelesaianTab({Key? key}) : super(key: key);

  final _sC = Get.find<ArkSertifikatController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 4),
                alignment: Alignment.center,
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFFFDA00),
                      Color(0xFFFFB200),
                    ],
                  ),
                ),
                child: Text(
                  'i',
                  style: AppStyleText.styleMontserrat(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Sertifikat Penyelesaian ',
                    style: AppStyleText.styleSourceSansPro(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(
                        text: "akan anda dapatkan setelah ",
                        style: AppStyleText.styleSourceSansPro(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                      TextSpan(
                        text: 'menyelesaikan seluruh seri dan kuis ',
                        style: AppStyleText.styleSourceSansPro(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          height: 1.4,
                        ),
                      ),
                      TextSpan(
                        text: "dalam kursus (tanpa nilai minimum).",
                        style: AppStyleText.styleSourceSansPro(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: Obx(
              () {
                if (_sC.isLoading.value) {
                  return ListView(
                    children: List.generate(
                      3,
                      (index) => const SertifikatCardShimmer(),
                    ),
                  );
                } else if (_sC.sertifikat.value.error) {
                  return ErrorImageWithTextWidget(
                    errorMsg: _sC.sertifikat.value.messageError,
                    refreshBtn: () => _sC.fnGetAllCertificate(),
                  );
                } else if (_sC.sertifikatPenyelesaian.isEmpty) {
                  return const SertifikatEmptyWidget();
                } else {
                  final sertif = _sC.sertifikatPenyelesaian;
                  return ListView(
                    children: List.generate(
                      sertif.length,
                      (i) => SertifikatCard(
                        sertif: sertif[i],
                        onTapUnduh: () => _sC.fnCheckPermission(i),
                        onTapShare: () => _sC.fnSharedCertificate(
                            'Saya telah menyelesaikan kursus ${sertif[i].courseName} yang diselenggarakan oleh Arkademi. Cek link berikut ini: ${sertif[i].certificateUrl}'),
                        onTapShareLinkedin: () async {
                          await AppFirebaseAnalyticsService()
                              .addLog("click_share_linkedin_penyelesaian");
                          _sC.fnShareToLinkedin(sertif[i]);
                        },
                        downloadProgress: _sC.progresDownload,
                        index: i,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
