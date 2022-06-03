import 'package:flutter/material.dart';
import 'package:kelimeezberleme/pages/main.dart';

class TemproryPage extends StatefulWidget {
  const TemproryPage({Key? key}) : super(key: key);

  @override
  State<TemproryPage> createState() => _TemproryPageState();
}

class _TemproryPageState extends State<TemproryPage> {

  @override
  void initState() { //uygulama çalıştığında sayfaların durumlarını belirler (hangisi açılsın, ne kadar kalsın açılsın mı vs.)
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage())); //pushPemplated bir önceki sayfayı geçiş yaptıktan sonra kaldırmaya göstermemeye yarar
    }); //giriş sayfası 2 sn görünür //builder içinde nereye yönlendirileceği girilir
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
       child: Container(
          color: Colors.deepPurpleAccent,
          child: Center( //logo hizalama gerekliliği
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            //logoyu ortalar
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text("WORD", style: TextStyle(color: Colors.black, fontFamily: "Marborn", fontSize: 40)),
              ),
              Image.asset("assets/images/WS1.png"),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text("SPACE", style: TextStyle(color: Colors.black, fontFamily: "Marborn", fontSize: 35)),
              ),





            ],
          ),
        ),
       ),
      )
    );
  }
}
