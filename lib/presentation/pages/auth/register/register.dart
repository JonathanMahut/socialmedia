import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/core/utils/validation.dart';
import 'package:social_media_app/data/models/enum/user_type.dart';
import 'package:social_media_app/domain/view_models/auth/auth_view_model.dart';
import 'package:social_media_app/domain/view_models/auth/register_view_model.dart';
import 'package:social_media_app/presentation/components/password_text_field.dart';
import 'package:social_media_app/presentation/components/text_form_builder.dart';
import 'package:social_media_app/presentation/pages/auth/register/profile_pic.dart';
import 'package:social_media_app/presentation/widgets/indicators.dart';
import 'package:social_media_app/presentation/widgets/usertypedropdownwidget.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../../../data/models/user.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(),
      builder: (context, child) {
        final viewModel = Provider.of<RegisterViewModel>(context);
        return LoadingOverlay(
          progressIndicator: circularProgress(context),
          isLoading: viewModel.loading,
          child: Scaffold(
            key: viewModel.scaffoldKey,
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                Text(
                  'Welcome to Tatoo Connect\nCreate a new account and connect with friends and artists',
                  style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                const SizedBox(height: 30.0),
                buildForm(viewModel, context),
                const SizedBox(height: 30.0),
                Center(
                  child: SignInButton(
                    Buttons.google,
                    onPressed: () => viewModel.signInWithGoogle(context),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account  ',
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildForm(RegisterViewModel viewModel, BuildContext context) {
    UserType selectedUserType = UserType.unknown;
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.person_outline,
            hintText: "Username",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            onSaved: (String val) {
              viewModel.setName(val);
            },
            focusNode: viewModel.usernameFN,
            nextFocusNode: viewModel.emailFN,
          ),
          const SizedBox(height: 20.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.mail_outline,
            hintText: "Email",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateEmail,
            onSaved: (String val) {
              viewModel.setEmail(val);
            },
            focusNode: viewModel.emailFN,
            nextFocusNode: viewModel.countryFN,
          ),
          const SizedBox(height: 20.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.pin_outline,
            hintText: "Country",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            onSaved: (String val) {
              viewModel.setCountry(val);
            },
            focusNode: viewModel.countryFN,
            nextFocusNode: viewModel.passFN,
          ),
          const SizedBox(height: 20.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.lock_closed_outline,
            suffix: Ionicons.eye_outline,
            hintText: "Password",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validatePassword,
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
            focusNode: viewModel.passFN,
            nextFocusNode: viewModel.cPassFN,
          ),
          const SizedBox(height: 20.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.lock_open_outline,
            hintText: "Confirm Password",
            textInputAction: TextInputAction.done,
            validateFunction: Validations.validatePassword,
            submitAction: () => viewModel.register(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setConfirmPass(val);
            },
            focusNode: viewModel.cPassFN,
          ),
          const SizedBox(height: 10.0),
          UserTypeDDWidget(
            initial: selectedUserType,
            onItemChange: (UserType g) {
              viewModel.setSelectedUserType(g);
              selectedUserType = g;
            },
          ),
          const SizedBox(height: 25.0),
          SizedBox(
            height: 45.0,
            width: 180.0,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
              ),
              child: Text(
                'sign up'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                if (viewModel.formKey.currentState!.validate()) {
                  viewModel.formKey.currentState!.save();
                  // Call signUpWithEmailAndPassword and handle navigation
                  if (viewModel.name != null &&
                      viewModel.email != null &&
                      viewModel.country != null &&
                      viewModel.password != null &&
                      viewModel.selectedUserType != null) {
                    UserModel? newUser =
                        await Provider.of<AuthViewModel>(context, listen: false).signUpWithEmailAndPassword(
                      name: viewModel.name!, // Use the non-null assertion operator (!)
                      email: viewModel.email!,
                      country: viewModel.country!,
                      password: viewModel.password!,
                      userType: viewModel.selectedUserType!,
                    );

                    if (newUser != null) {
                      // Navigate to ProfilePicture within the provider scope
                      Navigator.of(context).pushReplacement(
                        CupertinoPageRoute(
                          builder: (_) => ProfilePicture(user: newUser),
                        ),
                      );
                    } else {
                      // Handle sign-up error (e.g., display an error message)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registration failed. Please try again.')),
                      );
                    }
                  } else {
                    // Handle the case where one or more required fields are null
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all required fields.')),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
