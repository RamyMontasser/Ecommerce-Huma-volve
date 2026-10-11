class LoginModel {
  final String? accessToken;
  final String? refreshToken;

  const LoginModel({this.accessToken, this.refreshToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }
}
