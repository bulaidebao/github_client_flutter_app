import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_client_app/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CacheObject.dart';
import 'Git.dart';

const _themes = <MaterialColor>[

  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global{

  // 如果为true，则本次请求不使用缓存，但新的请求结果依然会被缓存
  static String refreshFlagStr = 'refresh';

  // 本次请求禁用缓存，请求结果也不会被缓存。
  static String noCacheFlagStr = 'noCache';
  static String cacheKeyFlagStr = 'cacheKey';

  static  SharedPreferences _prefs;
  static  Profile profile = Profile();

  // 网络缓存对象：并非第三方库，来自编者自建dart
  static NetCache netCache = NetCache();

  // 可选的主体列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release 版
  static bool get isRelease => bool.fromEnvironment('dart.vm.product');

  // 初始化全局信息，会在app启动时执行
  static Future init() async{
      _prefs = await SharedPreferences.getInstance();

      var _profile = _prefs.getString('profile');
      if( _profile != null ){

        try {

          profile = Profile.fromJson(jsonDecode(_profile));
        }catch (e){
          print(e);
        }
      }

      // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    // 初始化网络请求相关配置
    Git.init();
  }

  // 持久化Profile信息
 static saveProfile() => _prefs.setString('profile', jsonEncode(profile.toJson()));

}






























































































