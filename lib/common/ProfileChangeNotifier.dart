import 'package:flutter/material.dart';
import 'package:github_client_app/models/index.dart';
import 'Global.dart';

class ProfileChangeNotifier extends ChangeNotifier{

  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners

    // 保存Profile变更
    Global.saveProfile();
    super.notifyListeners();
  }
}

// 用户状态
class UserModel extends ProfileChangeNotifier{
  User get user => _profile.user;

  // app是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  // 用户信息发生变化，更新用户信息并通知依赖他的子孙Widgets更改
 set user(User user){
   if( user ?.login != _profile.user ?.login ){
     _profile.lastLogin = _profile.user?.login;
     _profile.user = user;
     notifyListeners();
   }
 }
}

// app 主题状态
class ThemeModel extends ProfileChangeNotifier{
  
  // 获取当前主题，如果为设置主题，则默认使用蓝色主题
  ColorSwatch get theme => Global.themes
      .firstWhere((element) => element.value == _profile.theme, orElse:()=>Colors.blue );

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(ColorSwatch color){
    if(  color != theme){
      _profile.theme = color[500].value;
      notifyListeners();
    }
  }
}

// app 语言状态
/*
* 当APP语言选为跟随系统（Auto）时，在系通语言改变时，APP语言会更新；
* 当用户在APP中选定了具体语言时（美国英语或中文简体），则APP便会一直使用用
* 户选定的语言，不会再随系统语言而变
* */
class LocaleModel extends ProfileChangeNotifier{

  //获取当前用户的app语言配置locale类，如果为null,则语言跟随系统语言
 Locale getLocale(){
   if( _profile.locale == null ) return null;
   var t = _profile.locale.split('_');
   return Locale(t[0] , t[1]);
 }

 // 获取当前Locale的字符串表示
 String get locale => _profile.locale;

 // 用户改变app语言后，通知依赖项更新，新语言会立即生效
 set locale(String locale){
   if( locale != _profile.locale ){
     _profile.locale = locale;
     notifyListeners();
   }
 }
}



























































