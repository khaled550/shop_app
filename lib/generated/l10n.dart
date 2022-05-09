// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `en`
  String get language {
    return Intl.message(
      'en',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `My Shop`
  String get app_title {
    return Intl.message(
      'My Shop',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_title {
    return Intl.message(
      'Login',
      name: 'login_title',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get signup_title {
    return Intl.message(
      'Signup',
      name: 'signup_title',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get login_via_google {
    return Intl.message(
      'Login with Google',
      name: 'login_via_google',
      desc: '',
      args: [],
    );
  }

  /// `Login with Facebook`
  String get login_via_facebook {
    return Intl.message(
      'Login with Facebook',
      name: 'login_via_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Login with Email`
  String get login_via_email {
    return Intl.message(
      'Login with Email',
      name: 'login_via_email',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account yet?`
  String get no_account {
    return Intl.message(
      'Don\'t have an account yet?',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get signup {
    return Intl.message(
      'Signup',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `ُEnter your email`
  String get enter_email {
    return Intl.message(
      'ُEnter your email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `ُEnter password`
  String get enter_password {
    return Intl.message(
      'ُEnter password',
      name: 'enter_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Signup with Google`
  String get signup_via_google {
    return Intl.message(
      'Signup with Google',
      name: 'signup_via_google',
      desc: '',
      args: [],
    );
  }

  /// `Signup with Facebook`
  String get signup_via_facebook {
    return Intl.message(
      'Signup with Facebook',
      name: 'signup_via_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Signup with Email`
  String get signup_via_email {
    return Intl.message(
      'Signup with Email',
      name: 'signup_via_email',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get have_account {
    return Intl.message(
      'Already have an account?',
      name: 'have_account',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enter_name {
    return Intl.message(
      'Enter your name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enter_phone {
    return Intl.message(
      'Enter your phone number',
      name: 'enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get gn_home {
    return Intl.message(
      'Home',
      name: 'gn_home',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get gn_cat {
    return Intl.message(
      'Categories',
      name: 'gn_cat',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get gn_orders {
    return Intl.message(
      'Orders',
      name: 'gn_orders',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get gn_profile {
    return Intl.message(
      'Profile',
      name: 'gn_profile',
      desc: '',
      args: [],
    );
  }

  /// `Search Anything...`
  String get search_text_field {
    return Intl.message(
      'Search Anything...',
      name: 'search_text_field',
      desc: '',
      args: [],
    );
  }

  /// `view all`
  String get view_all {
    return Intl.message(
      'view all',
      name: 'view_all',
      desc: '',
      args: [],
    );
  }

  /// `Deal of the day`
  String get hot_deals {
    return Intl.message(
      'Deal of the day',
      name: 'hot_deals',
      desc: '',
      args: [],
    );
  }

  /// `Best Selling`
  String get best_selling {
    return Intl.message(
      'Best Selling',
      name: 'best_selling',
      desc: '',
      args: [],
    );
  }

  /// `EGP`
  String get price_cur {
    return Intl.message(
      'EGP',
      name: 'price_cur',
      desc: '',
      args: [],
    );
  }

  /// `DISCOUNT`
  String get discount {
    return Intl.message(
      'DISCOUNT',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get my_lang {
    return Intl.message(
      'Language',
      name: 'my_lang',
      desc: '',
      args: [],
    );
  }

  /// `Your Account`
  String get account_settings {
    return Intl.message(
      'Your Account',
      name: 'account_settings',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get lang {
    return Intl.message(
      'English',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Updated Successfully`
  String get updated {
    return Intl.message(
      'Updated Successfully',
      name: 'updated',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get add_to_cart {
    return Intl.message(
      'Add to Cart',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
