import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kelimeezberleme/pages/create_list.dart';
import 'package:kelimeezberleme/sipsak_method.dart';

import '../global_widget/app_bar.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({Key? key}) : super(key: key);

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        left: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 22,),
        center: Text(
          "       LİSTELERİM",
          style: TextStyle(fontFamily: "Marborn", fontSize: 25, color: Colors.black),
        ),
        leftWidgetOnClick: ()=>{
          Navigator.pop(context)
        }
      ),
      //fAB basıldığında ne yapılması gerektiği kısımlarını içerir
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreateList()));
        },
        child: const Icon(Icons.add) ,
        backgroundColor: Color(SipsakMetod.HexaColorConverter("#b06ba5")),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                child: Card(
                  color: Color(SipsakMetod.HexaColorConverter("#d4b0cd")),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 15, top: 5),
                          child: Text("Liste Adı" ,style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: "RobotoMedium"),)),
                      Container(
                          margin: EdgeInsets.only(left: 25),
                          child: Text("300 terim" ,style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: "RobotoRegular"),)),
                      Container(
                          margin: EdgeInsets.only(left: 25),
                          child: Text("10 öğrenildi" ,style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: "RobotoRegular"),)),
                      Container(
                          margin: EdgeInsets.only(left: 25, bottom: 8),
                          child: Text("290 öğrenilmedi" ,style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: "RobotoRegular"),))
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
