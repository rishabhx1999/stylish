import '../config/size_config.dart';

class AppConsts {
  AppConsts._();

  static const String appName = 'Retrieve Flutter';
  static const double tabFontFactor = 1.5;
  static const double mobileFontFactor = 1.0;

  static const String googleApiKey = "";

  static double commonFontSizeFactor =
  SizeConfig.isMobile ? mobileFontFactor : tabFontFactor;

  static const String baseUrl = "";

  //false on release

  static const bool isLog = true;
  static const bool isDebug = true;

  static const double mapCameraTilt = 50.440717697143555;
  static const double mapCameraZoom = 19.151926040649414;

  //Data Transfer Keys
  static String keyIsEditAppointment = 'key_is_edit_appointment';
  static String keySignupFrom = 'key_signup_from';
}
