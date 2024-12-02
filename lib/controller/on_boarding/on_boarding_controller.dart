import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_routes.dart';
import '../../consts/app_consts.dart';
import '../../utils/preference_manager.dart';

class OnBoardingController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  RxInt selectedPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  nextPage() {
    if (selectedPage.value < 2) {
      selectedPage.value++;
      pageController.animateToPage(selectedPage.value,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    } else {
      PreferenceManager.save2Pref(PreferenceManager.prefIsFirstLaunch, false);
      Get.offAllNamed(AppRoutes.routeSignup,
          arguments: {AppConsts.keySignupFrom: AppRoutes.routeOnBoarding});
    }
  }

  previousPage() {
    if (selectedPage > 0) {
      selectedPage.value--;
      pageController.animateToPage(selectedPage.value,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }

  createPages() {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
