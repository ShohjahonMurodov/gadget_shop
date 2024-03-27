import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gadget_shop/data/user/user_model.dart';
import 'package:gadget_shop/screens/login/login_screen.dart';
import 'package:gadget_shop/screens/tab_box/tab_box_screen.dart';
import 'package:gadget_shop/utils/constants/app_constants.dart';
import 'package:gadget_shop/utils/fuctions/utility_functions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get loading => _isLoading;

  User? get getUser => FirebaseAuth.instance.currentUser;

  registerUser(BuildContext context,
      {required String email,
      required String password,
      required String username}) async {
    if (AppConstants.emailRegExp.hasMatch(email) &&
        AppConstants.passwordRegExp.hasMatch(password)) {
      try {
        _notify(true);
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        if (userCredential.user != null) {
          await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
          _insertUser(email: email, name: username, password: password);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TabBoxScreen(),
            ),
          );
        }
        _notify(false);
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TabBoxScreen(),
          ),
        );
      } on FirebaseAuthException catch (error) {
        if (!context.mounted) return;
        showErrorForLogin(error.code, context);
      } catch (error) {
        if (!context.mounted) return;
        showSnackbar(context: context, message: "Nomalum xatolik yuz berdi");
      }
    } else {
      showSnackbar(
          context: context, message: "Login yoki parolni notogri kiritdingiz");
    }
  }

  loginUser(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    if (AppConstants.emailRegExp.hasMatch(email) &&
        AppConstants.passwordRegExp.hasMatch(password)) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TabBoxScreen(),
          ),
        );
      } on FirebaseAuthException catch (error) {
        if (!context.mounted) return;
        showErrorForLogin(error.code, context);
      } catch (error) {
        if (!context.mounted) return;
        showSnackbar(
          context: context,
          message: "Noma'lum xatolik yuz berdi",
        );
      }
    } else {
      showSnackbar(
        context: context,
        message: "Login yoki Parolni xato kiritdingiz!",
      );
    }
  }

  logout(BuildContext context) async {
    _notify(true);
    await FirebaseAuth.instance.signOut();
    _notify(false);
    if (!context.mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  updateUsername(String username) async {
    _notify(true);
    await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
    _notify(false);
  }

  updateImageUrl(String imagePath) async {
    _notify(true);
    try {
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imagePath);
    } catch (error) {
      debugPrint("ERROR:$error");
    }
    _notify(false);
  }

  updateEmail(String changeEmail) async {
    _notify(true);
    try {
      await FirebaseAuth.instance.currentUser!
          .verifyBeforeUpdateEmail(changeEmail);
    } catch (error) {
      debugPrint("ERROE: $error");
    }
    _notify(false);
  }

  Future<void> signInWithGoogle(BuildContext context,
      [String? clientId]) async {
    _notify(true);

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    _notify(false);
    if (userCredential.user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const TabBoxScreen(),
        ),
      );
    }
  }

  Future<void> _insertUser({
    required String email,
    required String name,
    required String password,
  }) async {
    var tokId = await FirebaseMessaging.instance.getToken();
    UserModel userModel = UserModel(
      email: email,
      docId: "",
      password: password,
      tokenId: tokId ?? "",
    );

    var docId = await FirebaseFirestore.instance
        .collection(AppConstants.userTable)
        .add(userModel.toJson());

    await FirebaseFirestore.instance
        .collection(AppConstants.userTable)
        .doc(docId.id)
        .update({"doc_id": docId.id});
  }

  _notify(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
