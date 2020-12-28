
class AuthenticationResult{
 final String Token;
 final String RefreshToken;
 final bool Success;
 final List<String> Errors;

  AuthenticationResult({this.Token, this.RefreshToken, this.Success, this.Errors});
  AuthenticationResult.fromJson(Map<String,dynamic> map):
        Token =map["Token"],
        RefreshToken = map["RefreshToken"],
        Success = map["Success"],
        Errors = map["Errors"];
}