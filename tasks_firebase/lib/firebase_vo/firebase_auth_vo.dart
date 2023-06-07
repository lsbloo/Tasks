class FirebaseAuthVO {
  bool hasAuthenticateSuccessful;
  String message;
  String? accessToken;
  String? signInMethodAutenticate;

  FirebaseAuthVO(this.hasAuthenticateSuccessful, this.message, this.accessToken,
      this.signInMethodAutenticate);
}
