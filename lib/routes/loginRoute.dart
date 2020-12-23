import 'package:flutter/material.dart';
import 'package:github_client_app/common/Git.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/common/ProfileChangeNotifier.dart';
import 'package:github_client_app/generated/l10n.dart';
import 'package:github_client_app/models/index.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';

class LoginRoute extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _LoginRouteState();
  }
}

class _LoginRouteState extends State<LoginRoute>{

  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false;

  ///Form继承自StatefulWidget对象，它对应的状态类为FormState
  GlobalKey _formKey = GlobalKey<FormState>();

  bool _nameAutoFocus = true;

  @override
  void initState() {

    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text =Global.profile.lastLogin;
    if( _unameController.text != null ) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var gm = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.app_login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child:Column(
              children: <Widget>[
                TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _unameController,
                  decoration: InputDecoration(
                    labelText: gm.userName,
                    hintText: gm.userNameOrEmail,
                    prefixIcon: Icon(Icons.person),
                  ),

                  // 校验用户名(不能为空)
                  validator: (v){
                    return v.trim().isNotEmpty? null : gm.userNameRequired;
                  },
                ),

                TextFormField(
                  controller: _pwdController,

                  autofocus: _nameAutoFocus,
                  decoration: InputDecoration(

                    prefix: Icon(Icons.lock),
                    labelText: gm.password,
                    hintText: gm.password,
                    suffixIcon: IconButton(
                      icon: Icon(
                        pwdShow ? Icons.visibility_off : Icons.visibility
                      ),
                      onPressed: (){
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                    ),
                  ),

                  obscureText: !pwdShow,

                  // 校验密码(不能为空)
                  validator: (v){

                    return v.trim().isNotEmpty ? null : gm.passwordRequired;
                  },
                ),

                Padding(
                    padding: const EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55.0),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: _onLogin,
                      textColor: Colors.white,
                      child: Text(gm.app_login),
                    ),

                  ),
                ),


              ],



            ),


        ),

      ),


    );

  }

  void _onLogin() async {

    // 提交前，先验证各个表单字段是否合法
    if( (_formKey.currentState as FormState).validate() ){
      showLoading(context);
      User user;
      try{
        
        user = await Git(context).login(_unameController.text, _pwdController.text);
        // 因为登录页返回后，首页会build,所以我们传false,更新user后不触发更新
        Provider.of<UserModel>(context , listen: false).user = user;

      }catch (e){
        // 登录失败则提示
        if(e.response?.statusCode == 401){
          showToast(S.of(context).userNameOrPasswordWrong);
        }else{
          showToast(e.toString());
        }
        
      }finally{

        // 隐藏loading 框
        Navigator.of(context).pop();
      }

      if(  user != null){
        Navigator.of(context).pop();
      }
    }

  }

}

void showLoading(context, [String text]) {
  text = text ?? "Loading...";
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}




























































































