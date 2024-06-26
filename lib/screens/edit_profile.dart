import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/components/text_form_builder.dart';
import 'package:social_media_app/models/enum/gender_type.dart';
import 'package:social_media_app/models/enum/user_type.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/utils/firebase.dart';
import 'package:social_media_app/utils/validation.dart';
import 'package:social_media_app/view_models/profile/edit_profile_view_model.dart';
import 'package:social_media_app/widgets/genredropdownwidget.dart';
import 'package:social_media_app/widgets/indicators.dart';
import 'package:social_media_app/widgets/usertypedropdownwidget.dart';

class EditProfile extends StatefulWidget {
  final UserModel? user;

  const EditProfile({super.key, this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserModel? user;

  // final List<String> values = GenderType.values.map((e) => e.name).toList();

  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel viewModel = Provider.of<EditProfileViewModel>(context);
    return LoadingOverlay(
      progressIndicator: circularProgress(context),
      isLoading: viewModel.loading,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit Profile"),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: GestureDetector(
                  onTap: () => viewModel.editProfile(context),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: () => viewModel.pickImage(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: viewModel.imgLink != null
                      ? Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            radius: 65.0,
                            backgroundImage: NetworkImage(viewModel.imgLink!),
                          ),
                        )
                      : viewModel.image == null
                          ? Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage:
                                    NetworkImage(widget.user!.photoUrl!),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage: FileImage(viewModel.image!),
                              ),
                            ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            buildForm(viewModel, context)
          ],
        ),
      ),
    );
  }

  buildForm(EditProfileViewModel viewModel, BuildContext context) {
    GenderType selectedGenre;
    UserType selectedUserType;

    switch (viewModel.getGender()) {
      case GenderType.MALE:
        selectedGenre = GenderType.MALE;
        break;
      case GenderType.FEMALE:
        selectedGenre = GenderType.FEMALE;
        break;
      case GenderType.NONBINARY:
        selectedGenre = GenderType.NONBINARY;
        break;
      case GenderType.UNKNOWN:
        selectedGenre = GenderType.UNKNOWN;
        break;
      default:
        selectedGenre = GenderType.UNKNOWN;
        break;
    }

    switch (viewModel.getUserType()) {
      case UserType.CLIENT:
        selectedUserType = UserType.CLIENT;
        break;
      case UserType.TATOOARTIST:
        selectedUserType = UserType.TATOOARTIST;
        break;
      case UserType.EVENTORGANISATOR:
        selectedUserType = UserType.EVENTORGANISATOR;
        break;
      case UserType.VENDOR:
        selectedUserType = UserType.VENDOR;
        break;
      case UserType.UNKNOWN:
        selectedUserType = UserType.UNKNOWN;
        break;
      default:
        selectedUserType = UserType.UNKNOWN;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: viewModel.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormBuilder(
              enabled: !viewModel.loading,
              initialValue: widget.user!.username,
              prefix: Ionicons.person_outline,
              hintText: "Username",
              textInputAction: TextInputAction.next,
              validateFunction: Validations.validateName,
              onSaved: (String val) {
                viewModel.setUsername(val);
              },
            ),
            const SizedBox(height: 10.0),
            TextFormBuilder(
              initialValue: widget.user!.country,
              enabled: !viewModel.loading,
              prefix: Ionicons.pin_outline,
              hintText: "Country",
              textInputAction: TextInputAction.next,
              validateFunction: Validations.validateName,
              onSaved: (String val) {
                viewModel.setCountry(val);
              },
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Bio",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              maxLines: null,
              initialValue: widget.user!.bio,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? value) {
                if (value!.length > 1000) {
                  return 'Bio must be short';
                }
                return null;
              },
              onSaved: (String? val) {
                viewModel.setBio(val!);
              },
              onChanged: (String val) {
                viewModel.setBio(val);
              },
            ),
            const SizedBox(height: 10.0),
            GenreDDWidget(
              initial: selectedGenre,
              onItemChange: (GenderType g) => viewModel.setGender(g),
              //  onItemChange: (GenderType g) => selectedGenre = g,
            ),
            const SizedBox(height: 10.0),
            UserTypeDDWidget(
              initial: selectedUserType,
              onItemChange: (UserType g) => viewModel.setUserType(g),
              //  onItemChange: (UserType g) => selectedUserType = g,
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
