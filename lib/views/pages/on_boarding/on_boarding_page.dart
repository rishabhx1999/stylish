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
            backgroundColor: Colors.white,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: Container(
                  color: Colors.white,
                  child: SafeArea(
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Text.rich(TextSpan(
                                      text: (onBoardingController
                                                  .selectedPage.value +
                                              1)
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: AppConsts
                                                      .commonFontSizeFactor *
                                                  18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text: "/3",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontSize: AppConsts
                                                            .commonFontSizeFactor *
                                                        18,
                                                    color:
                                                        AppColors.color_AO_A1,
                                                    fontWeight:
                                                        FontWeight.w600))
                                      ])),
                                ),
                                GestureDetector(
                                  child: Text('skip'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: AppConsts
                                                      .commonFontSizeFactor *
                                                  18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600)),
                                )
                              ])),
                    ),
                  ),
                )),
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
                        selectedIndex: onBoardingController.selectedPage.value,
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
                                fontSize: AppConsts.commonFontSizeFactor * 12)),
                    const WidgetSpan(
                        child: SizedBox(
                      width: 4,
                    )),
                    TextSpan(
                        text: 'sign_in'.tr,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
            bottomNavigationBar: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                child: Text(
                              "prev".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          AppConsts.commonFontSizeFactor * 18,
                                      color: AppColors.color_C4),
                            )),
                            GestureDetector(
                                child: Text(
                              "next".tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          AppConsts.commonFontSizeFactor * 18),
                            ))
                          ],
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 10,
                              margin: const EdgeInsets.only(left: 8),
                              child: Obx(
                                () => PageIndicator(
                                    selectedIndex:
                                        onBoardingController.selectedPage.value,
                                    length: 3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22)
                ],
              ),
            ),
          );
        });
  }
}
