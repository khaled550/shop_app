import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import '../../../constants/strings.dart';
import '../../widgets.dart';

import '../../../cubit/home_cubit/home_page_cubit.dart';
import '../../../cubit/home_cubit/home_page_state.dart';
import '../../../constants/shared_pref.dart';

class SettingsPage extends StatelessWidget {
  HomePageCubit? cubit;
  SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit = HomePageCubit.get(context);
    return BlocConsumer<HomePageCubit, HomeLayoutState>(
      listener: (context, state) {
        if (state is UpdateProfileDataLoadingState) {
          showLoadingModal(context);
        }
        if (state is UpdateProfileDataSucState) {
          Navigator.pop(context);
          showDoneModal(
              context: context,
              text: getAppStrings(context).updated,
              iconData: Icons.done_outlined);
        }
      },
      builder: (context, state) {
        return _buildProfilePage(context);
      },
    );
  }

  Widget _buildProfilePage(BuildContext context) => Column(
        children: [
          AppBar(
            title: Text(getAppStrings(context).gn_profile),
            leading:
                IconButton(onPressed: (() {}), icon: const Icon(Icons.menu)),
          ),
          Column(
            children: [
              _buildProfileItem(context),
            ],
          )
        ],
      );

  Widget _buildProfileItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserDetails(context),
            const Divider(
              thickness: 2,
            ),
            Column(
              children: [
                SettingsGroup(
                    title: getAppStrings(context).settings,
                    children: [
                      _buildLangToggle(context),
                      _buildDarkModeToggle(context),
                      _buildAccountSettings(context),
                      _buildLogout(context),
                    ])
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSettings(BuildContext context) => SimpleSettingsTile(
        title: getAppStrings(context).account_settings,
        subtitle: '',
        leading: customIcon(context, Icons.person_outline),
        onTap: () {
          _editProfile(context);
        },
      );

  Widget _buildDarkModeToggle(BuildContext context) => SwitchSettingsTile(
        settingKey: APP_THEME,
        title: getAppStrings(context).dark_mode,
        leading: customIcon(context, Icons.dark_mode),
        onChange: (isDark) {},
      );

  Widget _buildLangToggle(BuildContext context) => DropDownSettingsTile(
        settingKey: APP_LANG,
        selected: 1,
        values: const <int, String>{1: "English", 2: "العربية"},
        title: getAppStrings(context).my_lang,
        onChange: (lang) {},
      );

  Widget _buildLogout(BuildContext context) => SimpleSettingsTile(
        title: getAppStrings(context).logout,
        subtitle: '',
        leading: customIcon(context, Icons.logout_outlined),
        onTap: () {
          signout(context);
        },
      );

  void signout(BuildContext context) {
    SharedPref.removeData(key: 'token').then((value) {
      SharedPref.removeData(key: LOGIN_SHARED).then((value) {
        navigateAndReplace(context, LOGIN_PAGE_PATH);
      });
    });
  }

  void _editProfile(BuildContext context) {
    buildBottomSheet(
        context: context,
        title: getAppStrings(context).account_settings,
        emailController: cubit!.emailController,
        passwordController: cubit!.passwordController,
        nameController: cubit!.nameController,
        phoneController: cubit!.phoneController,
        btnText: getAppStrings(context).edit,
        cubit: cubit!,
        onPressedBtn: () {
          _submitProfileUpdate(getAppStrings(context).language);
        });
  }

  Widget _buildUserDetails(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: cubit!.userProfile.image!,
            imageBuilder: (context, imageProvider) => Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                  //shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white24,
                  image:
                      DecorationImage(fit: BoxFit.cover, image: imageProvider)),
            ),
            placeholder: (context, url) => Transform.scale(
              scale: 0.2,
              child: const CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bigText(
                  context: context, text: cubit!.userProfile.name!, size: 16),
              const SizedBox(
                height: 10,
              ),
              smallText(text: cubit!.userProfile.email!, size: 12)
            ],
          ),
          /* const Spacer(),
                bigText(context: context, text: getAppStrings(context).edit, size: 16) */
        ],
      );

  void _submitProfileUpdate(String lang) {
    cubit!.updateProfileData(lang);
  }
}
