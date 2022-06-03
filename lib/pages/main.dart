import 'package:flutter/material.dart';
import 'package:kelimeezberleme/pages/lists.dart';
import 'package:kelimeezberleme/sipsak_method.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../global_widget/app_bar.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}
//Enum değerlerin en büyük avantajı okunulabilir olmayan veya aynı çeşitte sabit değerlerle ifade edilen static değerlerin daha basit yapılara çevrilmesidir.
enum Lang { eng, tr }

class _MainPageState extends State<MainPage> {
  Lang? _chooseLang = Lang.eng;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //buton çekmecesi için
  PackageInfo ?packageInfo = null;
  //versiyon bilgileri ekleme
  String version= "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    packageInfoInit();
  }

  void packageInfoInit() async
  {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo!.version;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width*0.5,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset("assets/images/WS1.png", height: 80,),
                  Text("WORD SPACE", style: TextStyle(fontFamily: "RobotoMedium", fontSize: 22),),
                  Text("İstediğini Öğren !", style: TextStyle(fontFamily: "RobotoLight", fontSize: 16),),
                  SizedBox(width: MediaQuery.of(context).size.width*0.35, child: Divider(color: Colors.black,)),
                  Container(margin:EdgeInsets.only(top:25, right: 8), child: Text("Dilediğiniz yerde ve zamanda kendi listelerinizle keyifli şekilde kelime öğrenin.", style: TextStyle(fontFamily: "RobotoLight", fontSize: 14), textAlign: TextAlign.center)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("v"+version+"\nserenaygztk@gmail.com", style: TextStyle(fontFamily: "RobotoLight", fontSize: 14, color: Color(SipsakMetod.HexaColorConverter("#570861"))), textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
      appBar: appBar(context,
          left: const FaIcon(FontAwesomeIcons.bars, color: Colors.black, size: 20,),
          center: Text(
    "       WORD SPACE",
    style: TextStyle(fontFamily: "Marborn", fontSize: 25, color: Colors.black),),
          leftWidgetOnClick: ()=>{_scaffoldKey.currentState!.openDrawer()} ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              children: [
                langRadioButton(
                    text: "İngilizce - Türkçe",
                    group: _chooseLang,
                    value: Lang.tr),
                langRadioButton(
                    text: "Türkçe - İngilizce",
                    group: _chooseLang,
                    value: Lang.eng),
                SizedBox(height: 25,),
                InkWell(
                onTap: (){
                  //pushla yazıldığında o sayfaya gidip geri dönüldüğünde sayfa silinmez
                  //bir değişne tanımladığımızda sonra deişmeyeceksek const kullanırız
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const ListsPage()));
                },
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    margin: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      //yazı çerçevemizin kenarlarının ovalleşmesi için veririz
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        // 10% of the width, so there are ten blinds.
                        colors: <Color>[
                          Color(SipsakMetod.HexaColorConverter("#db6ec9")),
                          Color(SipsakMetod.HexaColorConverter("#b06ba5")),
                        ],

                        tileMode: TileMode
                            .repeated, // repeats the gradient over the canvas
                      ),
                    ),
                    child: Text(
                      "Listelerim",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ),
                ),
                //seçmeli radio butonu
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      card(context,
                          startColor: "#92b1e0",
                          endColor: "#4a62e8",
                          title: "Kelime Kartları"),
                      card(context,
                          startColor: "#e3b276",
                          endColor: "#e08c24",
                          title: "Çoktan Seçmeli"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container card(
    BuildContext context, {
    @required String? startColor,
    @required String? endColor,
    @required String? title,
  }) {
    //required ile bir değişken tanımladığımızda bu objeyi çağırdığımız yerlerde bu değişkene bir değer atamamız gerekir. Girdinin  null olmamasını sağlar.
    return Container(
      alignment: Alignment.center,
      height: 200,
      width: MediaQuery.of(context).size.width * 0.37,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        //yazı çerçevemizin kenarlarının ovalleşmesi için veririz
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // 10% of the width, so there are ten blinds.
          colors: <Color>[
            Color(SipsakMetod.HexaColorConverter(startColor!)),
            //genel card methoduna aldığımızdan renkleri direkt vermek yerine bu şekilde yukarda kolayca yazarız
            Color(SipsakMetod.HexaColorConverter(endColor!)),
          ],

          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title!,
            style: TextStyle(fontSize: 28, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Icon(
            Icons.file_copy,
            size: 32,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  SizedBox langRadioButton({
    @required String? text,
    @required Lang? value,
    @required Lang? group,
  }) {
    return SizedBox(
      width: 250,
      height: 30,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text(text!, style: TextStyle( fontSize: 15,),),
        leading: Radio<Lang>(
          value: Lang.tr,
          groupValue: _chooseLang, //sadece birini seçmek için
          onChanged: (Lang? value) {
            setState(() {
              _chooseLang = value;
            });
          },
        ),
      ),
    );
  }
}
