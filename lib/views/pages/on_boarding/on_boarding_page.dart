import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_routes.dart';
import '../../../consts/app_consts.dart';
import '../../../consts/app_icons.dart';
import '../../../consts/app_images.dart';
import '../../../controller/on_boarding/on_boarding_controller.dart';
import '../../../utils/preference_manager.dart';
import '../../widgets/common/common_button.dart';
import '../../widgets/common/page_indicators.dart';
import 'components/on_boarding_page_view.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));
    return GetBuilder(
        init: OnBoardingController(),
        builder: (OnBoardingController onBoardingController) {
          return Scaffold(
            backgroundColor: AppColors.appBackgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.appBackgroundColor,
              leading: Obx(
                    () => onBoardingController.selectedPage.value == 0
                    ? const SizedBox()
                    : IconButton(
                    onPressed: () {
                      onBoardingController.previousPage();
                    }, icon: SvgPicture.asset(AppIcons.ic_back,
                        color: Colors.black),
                    ),
              ),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: PageView(
                      controller: onBoardingController.pageController,
                      onPageChanged: (index) {
                        onBoardingController.selectedPage.value = index;
                      },
                      children: [
                        OnBoardingPageView(
                            title: "on_boarding_title_1",
                            subtitle: 'on_boarding_subtitle_1',
                            image: AppImages.img_on_boarding_1),
                        OnBoardingPageView(
                            title: "on_boarding_title_2",
                            subtitle: 'on_boarding_subtitle_2',
                            image: AppImages.img_on_boarding_2),
                        OnBoardingPageView(
                            title: "on_boarding_title_3",
                            subtitle: 'on_boarding_subtitle_3',
                            image: AppImages.img_on_boarding_3)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  height: 10,
                  margin: const EdgeInsets.only(left: 8),
                  child: Obx(
                        () => PageIndicator(
                        selectedIndex:
                        onBoardingController.selectedPage.value,
                        length: 3),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Obx(
                      () => CommonButton(
                      text: onBoardingController.selectedPage.value < 2
                          ? 'next'
                          : 'sign_up',
                      onClick: () {
                        onBoardingController.nextPage();
                      }),
                ),
                const SizedBox(
                  height: 32,
                ),
                Center(
                  child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'already_have_account'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                color: Colors.black.withOpacity(0.6),
                                fontSize:
                                AppConsts.commonFontSizeFactor * 12)),
                        const WidgetSpan(
                            child: SizedBox(
                              width: 4,
                            )),
                        TextSpan(
                            text: 'sign_in'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: AppConsts.commonFontSizeFactor * 12,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                PreferenceManager.save2Pref(
                                    PreferenceManager.prefIsFirstLaunch, false);
                                Get.offAllNamed(AppRoutes.routeLogin);
                              })
                      ])),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      PreferenceManager.save2Pref(
                          PreferenceManager.prefIsFirstLaunch, false);
                      PreferenceManager.save2Pref(
                          PreferenceManager.prefIsVisitor, true);
                      Get.offAllNamed(AppRoutes.routeDashboard);
                    },
                    child: Text(
                      'login_as_a_visitor'.tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: AppConsts.commonFontSizeFactor * 12,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          );
        });
  }
}
