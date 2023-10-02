class AuthException {
  static void authExceptionToast(String error) {
    String errorMessage = "An Error Occured";
    switch (error) {
      case 'invalid-email':
        errorMessage = 'Invalid email address';
        break;
      case 'user-not-found':
        errorMessage = 'User not found';
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password';
        break;
      case 'email-already-in-use':
        errorMessage = 'Email is already in use';
        break;
      case 'weak-password':
        errorMessage = 'Weak password';
        break;
      default:
        errorMessage = error.toString();
        break;
    }
    //Utils.snackBar('Error', errorMessage);
  }
}
