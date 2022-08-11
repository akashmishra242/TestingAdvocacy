import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginController extends GetxController {
  var _googlesignin = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  login() async {
    googleAccount.value = await _googlesignin.signIn();
  }

  logout() async {
    googleAccount.value = await _googlesignin.signOut();
  }
}
