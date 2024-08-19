class ProjectInfo {
  final String projectNumber;
  final String projectId;
  final String storageBucket;
  final String mobilesdkAppId;
  final String packageName;
  final String oauthClientId;
  final int oauthClientType;
  final String apiKey;
  final String otherPlatformOauthClientId;
  final int otherPlatformOauthClientType;
  final String configurationVersion;

  ProjectInfo({
    required this.projectNumber,
    required this.projectId,
    required this.storageBucket,
    required this.mobilesdkAppId,
    required this.packageName,
    required this.oauthClientId,
    required this.oauthClientType,
    required this.apiKey,
    required this.otherPlatformOauthClientId,
    required this.otherPlatformOauthClientType,
    required this.configurationVersion,
  });

  factory ProjectInfo.fromJson(Map<String, dynamic> json) {
    return ProjectInfo(
      projectNumber: json['project_info']['project_number'],
      projectId: json['project_info']['project_id'],
      storageBucket: json['project_info']['storage_bucket'],
      mobilesdkAppId: json['client'][0]['client_info']['mobilesdk_app_id'],
      packageName: json['client'][0]['client_info']['android_client_info']['package_name'],
      oauthClientId: json['client'][0]['oauth_client'][0]['client_id'],
      oauthClientType: json['client'][0]['oauth_client'][0]['client_type'],
      apiKey: json['client'][0]['api_key'][0]['current_key'],
      otherPlatformOauthClientId: json['client'][0]['services']['appinvite_service']['other_platform_oauth_client'][0]['client_id'],
      otherPlatformOauthClientType: json['client'][0]['services']['appinvite_service']['other_platform_oauth_client'][0]['client_type'],
      configurationVersion: json['configuration_version'],
    );
  }
}
