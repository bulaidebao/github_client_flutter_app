import 'package:flutter/material.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/common/ProfileChangeNotifier.dart';
import 'package:github_client_app/generated/l10n.dart';
import 'package:provider/provider.dart';

class ThemeChangeRoute extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_theme),
      ),
      body: ListView(

        children: Global.themes.map((e) {

          return GestureDetector(

            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5 , horizontal: 16),
              child: Container(
                color: e,
                height: 40,
              ),
            ),

            onTap: (){
              // 主题更新后，MaterialApp会重新build
              Provider.of<ThemeModel>(context).theme = e;
            },
          );
        }).toList(),
      ),
    );
  }






}










































































































































