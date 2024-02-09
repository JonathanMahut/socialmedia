import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_app/models/enum/tatoo_style.dart';
import 'package:social_media_app/utils/firebase.dart';

class AuthService {
  User getCurrentUser() {
    User user = firebaseAuth.currentUser!;
    return user;
  }

  // Crée un utilisateur Firebase
  Future<bool> createUser({
    String? name,
    User? user,
    String? email,
    String? country,
    String? password,
    String gender = 'UNKNOWN',
    bool isArtist = false,
    String? displayName,
    String? phoneNumber,
    String? website,
    String? language,
    String? countryCode,
    String? postalAdress,
    String? city,
    List<TatooStyle>? tatooStyles,
  }) async {
    var res = await firebaseAuth.createUserWithEmailAndPassword(
      email: '$email',
      password: '$password',
    );
    if (res.user != null) {
      await saveUserToFirestore(
        name!,
        res.user!,
        email!,
        country!,
        gender,
        isArtist,
        displayName,
        phoneNumber,
        website,
        language,
        countryCode,
        postalAdress,
        city,
        tatooStyles,
      );
      return true;
    } else {
      return false;
    }
  }

  // Enregistre les détails de l'utilisateur dans Firestore
  saveUserToFirestore(
    String name,
    User user,
    String email,
    String country,
    String gender,
    bool isArtist,
    String? displayName,
    String? phoneNumber,
    String? website,
    String? language,
    String? countryCode,
    String? postalAdress,
    String? city,
    List<TatooStyle>? tatooStyles,
  ) async {
    Map<String, dynamic> userData = {
      'username': name,
      'email': email,
      'time': Timestamp.now(),
      'id': user.uid,
      'bio': "",
      'country': country,
      'photoUrl': user.photoURL ?? '',
      'gender': gender,
      'isArtist': isArtist,
      'displayName': displayName ?? '',
      'phoneNumber': phoneNumber ?? '',
      'website': website ?? '',
      'language': language ?? '',
      'countryCode': countryCode ?? '',
      'postalAdress': postalAdress ?? '',
      'city': city ?? '',
      'tatooStyles': tatooStyles ?? [],
    };
    print(userData);
    // // Vérifier si tatooStyles n'est pas nul avant de l'ajouter aux données utilisateur
    // if (tatooStyles != null) {
    //   userData['tatooStyles'] =
    //       tatooStyles.map((style) => style.index).toList();
    // } else {
    //   userData['tatooStyles'] = [];
    // }

    await usersRef.doc(user.uid).set(userData);
  }

  // Fonction pour connecter un utilisateur avec son email et son mot de passe
  Future<bool> loginUser({String? email, String? password}) async {
    var res = await firebaseAuth.signInWithEmailAndPassword(
      email: '$email',
      password: '$password',
    );

    if (res.user != null) {
      return true;
    } else {
      return false;
    }
  }

  // Réinitialiser le mot de passe
  forgotPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Déconnexion
  logOut() async {
    await firebaseAuth.signOut();
  }

  // Gestion des erreurs Firebase Auth
  String handleFirebaseAuthError(String e) {
    if (e.contains("ERROR_WEAK_PASSWORD")) {
      return "Le mot de passe est trop faible";
    } else if (e.contains("invalid-email")) {
      return "Email invalide";
    } else if (e.contains("ERROR_EMAIL_ALREADY_IN_USE") ||
        e.contains('email-already-in-use')) {
      return "L'adresse email est déjà utilisée par un autre compte.";
    } else if (e.contains("ERROR_NETWORK_REQUEST_FAILED")) {
      return "Erreur réseau!";
    } else if (e.contains("ERROR_USER_NOT_FOUND") ||
        e.contains('firebase_auth/user-not-found')) {
      return "Identifiants invalides.";
    } else if (e.contains("ERROR_WRONG_PASSWORD") ||
        e.contains('wrong-password')) {
      return "Identifiants invalides.";
    } else if (e.contains('firebase_auth/requires-recent-login')) {
      return 'Cette opération est sensible et nécessite une authentification récente.'
          ' Connectez-vous à nouveau avant de réessayer cette demande.';
    } else {
      return e;
    }
  }
}
