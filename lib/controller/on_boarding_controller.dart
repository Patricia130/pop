import 'package:driver/model/on_boarding_model.dart';
import 'package:driver/model/language_title.dart';
import 'package:driver/model/language_description.dart';
import 'package:driver/utils/fire_store_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  var selectedPageIndex = 0.obs;

  bool get isLastPage => selectedPageIndex.value == onBoardingList.length - 1;
  var pageController = PageController();

  @override
  void onInit() {
    // TODO: implement onInit
    getOnBoardingData();
    super.onInit();
  }

  RxBool isLoading = true.obs;
  RxList<OnBoardingModel> onBoardingList = <OnBoardingModel>[].obs;

  getOnBoardingData() async {
    try {
      debugPrint('[OnBoarding] Fetching onboarding data');
      await FireStoreUtils.getOnBoardingList().then((value) {
        onBoardingList.value = value;
        // Add fallback data if Firestore returns empty list
        if (onBoardingList.isEmpty) {
          onBoardingList.value = [
            OnBoardingModel(
              image: "assets/images/onboarding_1.png",
              title: [LanguageTitle(title: "Welcome to GoRide", type: "en")],
              description: [LanguageDescription(description: "Your reliable ride companion", type: "en")]
            ),
            OnBoardingModel(
              image: "assets/images/onboarding_2.png",
              title: [LanguageTitle(title: "Easy Navigation", type: "en")],
              description: [LanguageDescription(description: "Find your way around easily", type: "en")]
            ),
            OnBoardingModel(
              image: "assets/images/onboarding_3.png",
              title: [LanguageTitle(title: "Start Driving", type: "en")],
              description: [LanguageDescription(description: "Begin your journey with us", type: "en")]
            ),
          ];
        }
      }).catchError((error) {
        debugPrint('[OnBoarding] Error fetching data: $error');
        // Use fallback data on error
        onBoardingList.value = [
          OnBoardingModel(
            image: "assets/images/onboarding_1.png",
            title: [LanguageTitle(title: "Welcome to GoRide", type: "en")],
            description: [LanguageDescription(description: "Your reliable ride companion", type: "en")]
          ),
          OnBoardingModel(
            image: "assets/images/onboarding_2.png",
            title: [LanguageTitle(title: "Easy Navigation", type: "en")],
            description: [LanguageDescription(description: "Find your way around easily", type: "en")]
          ),
          OnBoardingModel(
            image: "assets/images/onboarding_3.png",
            title: [LanguageTitle(title: "Start Driving", type: "en")],
            description: [LanguageDescription(description: "Begin your journey with us", type: "en")]
          ),
        ];
      });
    } catch (e) {
      debugPrint('[OnBoarding] Error in getOnBoardingData: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
