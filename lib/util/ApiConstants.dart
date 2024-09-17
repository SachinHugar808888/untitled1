// api_constants.dart
class ApiConstants {
  static const String baseUrl = 'https://ilpuat.finfotech.co.in/';
  static const String loginEndpoint = 'usrmgmt/p2pusers/v2/login';
  static const String fetchData = 'configuration/getgroupinfo';
  static const String stateList = 'usrmgmt/getstatelist';
  static const String districtList = 'usrmgmt/getdistrictlist?';
  static const String userbasicinfo= 'lsp/getuserbasicinfo';
  static const String jlgRegistrationService= 'usrmgmt/jlg/groupregistration';
  static const String createKycRequest= 'vf/createvkycrequest';
  static const String getVkycRequestStatusService= 'vf/getvkycrequeststatus';
  static const String vkycrequest= 'vf/getvkycrequests';
  static const String acceptVkycRequest= 'vf/getvkycrequests';
  static const String completeOtp= 'usrmgmt/p2pusers/v2/login';
  static const String generateSecretKey= 'usrmgmt/getkey';
  static const String getDueLoans= 'lms/getdueloans';
  static const String getBorProfileInfo= 'lsp/getborprofileinfo';
  static const String getRepaymentBreakdown = "lsp/getrepaymentbreakdown";
  static const String generateQRCode = "lms/getpaymentqrcode";
  static const String payUsingUpiId = "lms/getpaymentcollectrequest";
  static const String bulkRegistration = "usrmgmt/bulkregistration";
  static const String importLoans ="cms/bulkuploadcmsloans";













// Add other endpoints as needed
}
