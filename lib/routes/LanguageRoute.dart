import 'package:flutter/material.dart';
import 'package:github_client_app/common/ProfileChangeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:github_client_app/generated/l10n.dart';

class LanguageRoute extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var gm = S.of(context);

    return Scaffold(

      appBar: AppBar(
        title: Text(gm.app_language),
      ),
      body: ListView(

        children: <Widget>[
          _buildLanguageItem('中文简体', 'zh_Hans_CN', context),
          _buildLanguageItem('Englist', 'en_US', context),
          _buildLanguageItem(gm.app_auto, null, context),
        ],
      ),
    );
  }

  Widget  _buildLanguageItem(String lan , value , BuildContext context){

    var color = Theme.of(context).primaryColor;
    var localeModel = Provider.of<LocaleModel>(context);
    var gm = S.of(context);

    return ListTile(
      title: Text(
        lan ,

        // 对app当前语言进行高亮显示
        style: TextStyle(
          color: localeModel.locale == value ? color : null
        ),
      ),

      trailing: localeModel.locale == value ? Icon(Icons.done , color: color,): null,

      onTap: () {

        // 更新locale后MaterialApp会重新build
        localeModel.locale = value;
      },
    );
  }


}