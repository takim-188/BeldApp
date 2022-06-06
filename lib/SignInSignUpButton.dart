import 'package:flutter/material.dart';

class SingInSingUpButton extends StatelessWidget {
  BuildContext context;
  bool isLogin;
  Function onTap;
  double boyut;

  SingInSingUpButton({
    required this.boyut,
    required this.context,
    required this.isLogin,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      elevation: 20,
      child: Container(
        width: MediaQuery.of(context).size.width * boyut,
        height: 35,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: ElevatedButton(
          onPressed: (){
            onTap();
          },
          child: Text(
            isLogin ? 'Giriş ' : 'Kaydol',
            style: const TextStyle(
             fontWeight: FontWeight.bold, fontSize: 14
            ),
          ),
          style: ButtonStyle(
              // backgroundColor: MaterialStateProperty.resolveWith((states){
              //   if(states.contains(MaterialState.pressed)){
              //     return Colors.black26;
              //   }
              //   return Colors.white;
              // }),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              )
          ),
        ),

      ),
    );
  }
}
