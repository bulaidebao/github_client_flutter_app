import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'Global.dart';
import '../models/index.dart';

class Git {

    BuildContext context;
    Options _options;
    static Dio dio = Dio(BaseOptions(baseUrl: 'https://api.github.com/' , headers:{ HttpHeaders.acceptHeader:'application/vnd.github.squirrel-girl-preview,' "application/vnd.github.symmetra-preview+json",}));

    // 在网络请求过程中，可能会需要使用当前的context信息，比如在请求你失败时打开一个
    // 新路由时，而打开新路由需要context信息
    Git( [this.context] ){

      _options = Options(extra: {'context' : context});
    }

    static void init(){

      // 添加缓存插件
      dio.interceptors.add(Global.netCache);

      // 设置用户token（可能为null,代表未登录）
      dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;


      // 在调试模式下需要抓包调试，所有我们使用代理，并禁用https证书校验
      if(!Global.isRelease){
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client){

          client.findProxy = (uri){
            return 'PROXY 172.16.44.165:8888';
          };

          // 我们禁用证书校验
          client.badCertificateCallback = (X509Certificate cert ,String host , int port) => true;
        };
      }

    }

    // 登录接口，登录成功后返回用户信息
    Future<User> login(String login, String pwd) async{

          String basic = 'Basic' + base64.encode(utf8.encode('$login:$pwd'));
          var r = await dio.get(
             '/users/$login' ,
             options: _options.merge(
                 headers: {
            HttpHeaders.authorizationHeader: basic
          },
                extra: {

            // 本接口禁用缓存
            Global.noCacheFlagStr: true,
          }
             ),
          );

          // 登录成功后更新公共头(authorization) , 此后的所有请求都会
          // 带上身份信息
         dio.options.headers[HttpHeaders.authorizationHeader] = basic;

        // 清空所有缓存
          Global.netCache.cache.clear();

        // 更新profile中的tokn信息
          Global.profile.token = basic;
          return User.fromJson(r.data);
    }

    // 获取用户项目列表
    Future<List<Repo>> getRepos( {Map<String , dynamic> queryParams , refresh = false} ) async {
      if (refresh) {
        // 列表下拉刷新，需要删除缓存
        _options.extra.addAll({Global.refreshFlagStr: true, 'list': true});
      }

      var r = await dio.get<List>(

        'user/repos',
        queryParameters: queryParams,
        options: _options,
      );

      return r.data.map((e) => Repo.fromJson(e)).toList();
    }
}