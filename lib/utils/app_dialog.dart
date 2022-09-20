import 'package:ark_module_profile/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'app_style_text.dart';

class AppDialog {
  static dialogSuccessDownloadSertif() {
    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: Image.asset(
                'assets/images/popup-kelas-sudahselesai.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 15),
              child: Material(
                color: Colors.white,
                child: Text(
                  'Anda telah berhasil mendownload\nSertifikat belajar.',
                  style: AppStyleText.styleMontserrat(
                    fontSize: 13.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              width: 90,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  primary: Colors.blue,
                ),
                child: const Text(
                  'Oke',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Get.back(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static dialogWithQuestion(
    String title,
    String content,
    String txtBatal,
    String txtOke,
    VoidCallback onTapOK,
  ) {
    return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 15, bottom: 10),
      title: title,
      titleStyle: AppStyleText.styleMontserrat(
        fontSize: 16,
        color: Colors.red.shade600,
        fontWeight: FontWeight.bold,
      ),
      middleText: content,
      middleTextStyle: AppStyleText.styleMontserrat(
        fontSize: 14,
        color: Colors.grey.shade400,
      ),
      cancel: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: TextButton(
          onPressed: () => Get.back(),
          child: Text(
            txtBatal,
            style: AppStyleText.styleMontserrat(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      confirm: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: TextButton(
          onPressed: () => onTapOK(),
          child: Text(
            txtOke,
            style: AppStyleText.styleMontserrat(
              fontSize: 14,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  static dialogLoading() {
    return Get.defaultDialog(
      barrierDismissible: false,
      onWillPop: () async => false,
      radius: 8,
      middleText: '',
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          const SizedBox(height: 25),
          Lottie.asset('assets/images/loading-animation.json',
              height: 100, width: 100),
          const SizedBox(height: 35),
          const Text(
            'Harap Tunggu',
            style: TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  static dialogStateWithLottie(
    String lottiFile,
    String txt,
  ) {
    return Get.defaultDialog(
      radius: 8,
      middleText: '',
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: Column(
        children: [
          const SizedBox(height: 25),
          Lottie.asset('assets/images/$lottiFile',
              height: 100, width: 100, repeat: false),
          const SizedBox(height: 35),
          Text(
            txt,
            style: AppStyleText.styleMontserrat(
              fontSize: 16,
              height: 1.4,
              color: kNewBlack1,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
