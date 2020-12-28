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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `app_name`
  String get app_title {
    return Intl.message(
      'app_name',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `app_test`
  String get app_test {
    return Intl.message(
      'app_test',
      name: 'app_test',
      desc: '',
      args: [],
    );
  }

  /// `App Login`
  String get app_login {
    return Intl.message(
      'App Login',
      name: 'app_login',
      desc: '',
      args: [],
    );
  }

  /// `AppThemeColor`
  String get app_theme {
    return Intl.message(
      'AppThemeColor',
      name: 'app_theme',
      desc: '',
      args: [],
    );
  }

  /// `AppLanguage`
  String get app_language {
    return Intl.message(
      'AppLanguage',
      name: 'app_language',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get app_auto {
    return Intl.message(
      'System',
      name: 'app_auto',
      desc: '',
      args: [],
    );
  }

  /// `UserNameOrEmail`
  String get userNameOrEmail {
    return Intl.message(
      'UserNameOrEmail',
      name: 'userNameOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `UserName`
  String get userName {
    return Intl.message(
      'UserName',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `UserNameRequired`
  String get userNameRequired {
    return Intl.message(
      'UserNameRequired',
      name: 'userNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `PasswordRequired`
  String get passwordRequired {
    return Intl.message(
      'PasswordRequired',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `UserNameOrPasswordWrong`
  String get userNameOrPasswordWrong {
    return Intl.message(
      'UserNameOrPasswordWrong',
      name: 'userNameOrPasswordWrong',
      desc: '',
      args: [],
    );
  }

  /// `AppLogOut`
  String get AppLogOut {
    return Intl.message(
      'AppLogOut',
      name: 'AppLogOut',
      desc: '',
      args: [],
    );
  }

  /// `AppHasLogOut`
  String get AppHasLogOut {
    return Intl.message(
      'AppHasLogOut',
      name: 'AppHasLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get Confirm {
    return Intl.message(
      'Confirm',
      name: 'Confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
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
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}