import 'package:flutter/material.dart';
import 'package:github_client_app/common/Git.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/common/ProfileChangeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:github_client_app/generated/l10n.dart';
import 'package:github_client_app/generated/l10n.dart' as Smodule;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flukit/flukit.dart';
import 'package:github_client_app/models/index.dart';
import 'package:github_client_app/widgets/RepoItem.dart';
import 'package:github_client_app/widgets/MyDrawer.dart';
import 'package:github_client_app/routes/loginRoute.dart';
import 'package:github_client_app/routes/LanguageRoute.dart';
import 'package:github_client_app/routes/ThemeRoute.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((value) => runApp(MyApp()));

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    /// 使用multiProvider，将ThemeModel，UserModel,LocaleModel三个模型暴露给所有页面，共享模型
    return MultiProvider(

      providers: [
  
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],

      /// 使用Consumer来监听全局刷新UI
      /// MaterialApp消费（依赖）了ThemeModel和LocaleModel，所以当APP主题或语言改变时MaterialApp会重新构建
      child: Consumer2<ThemeModel , LocaleModel>(

        builder: (BuildContext context , themeModel , localeModel , Widget child){

          return MaterialApp(

            theme: ThemeData(
              primarySwatch: themeModel.theme,
            ),

            onGenerateTitle: (context){
              return S.of(context).app_title;

            },
            home: HomeRoute(),

            /// 国际化支持 - 使用flutter_intl插件
            localizationsDelegates: const [
              S.delegate,
              Smodule.S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: localeModel.getLocale(),
            localeListResolutionCallback: (List<Locale> locales, Iterable<Locale> supportedLocales) {
              if(localeModel.getLocale() != null){
                //如果已选定语言,则不跟随系统
                return localeModel.getLocale();
              } else{
                Locale locale;
                Locale _locale = locales.first;
                if(supportedLocales.contains(_locale)){
                  locale = _locale;
                }else{
                  locale = Locale("en","US");
                }
                return locale;
              }
            },

            // 注册命名路由表
            routes: <String , WidgetBuilder>{
              'login':(context) => LoginRoute(),
              'themes':(context) => ThemeChangeRoute(),
              'language':(context) => LanguageRoute(),
            },

          );
        },

      ),

    );

  }

}

class HomeRoute extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(
        title: Text(S.of(context).app_title),
      ),

      body:_buildBody(context) ,

      // 抽屉菜单
      drawer: MyDrawer(),
    );

  }

}

Widget _buildBody(BuildContext context){
  
  UserModel userModel = Provider.of<UserModel>(context);
  if( !userModel.isLogin ){
    
    // 用户未登录，显示登录按钮
    return Center(
      child: RaisedButton(
        child: Text(S.of(context).app_login),
        onPressed: (){
          
          Navigator.of(context).pushNamed('login');
        },
      ),
    );
  }else{

    // 已登录，则展示项目列表
    return InfiniteListView<Repo>(

      onRetrieveData: (int page , List<Repo> items , bool refresh) async {

        var data = await Git(context).getRepos(

          refresh: refresh,
          queryParams: {
            'page': page,
            'page_size' : 20,
          },
        );
        // 把请求到的数据添加到items中
        items.addAll(data);

        // 如果接口返回的数量等于'page_size' , 则认为还有数据，反之则认为最后一页
        return data.length == 20;
      },

      itemBuilder: (List list , int index ,BuildContext ctx){
        // 项目信息列表项
        return RepoItem(list[index]);
      },

    );

  }
  
  
}


























































































































































































































































