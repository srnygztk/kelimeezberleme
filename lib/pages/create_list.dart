import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kelimeezberleme/db/db/db.dart';
import 'package:kelimeezberleme/db/models/lists.dart';
import 'package:kelimeezberleme/global_widget/toast.dart';
import 'package:kelimeezberleme/sipsak_method.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../db/models/words.dart';
import '../global_widget/app_bar.dart';

class CreateList extends StatefulWidget {
  const CreateList({Key? key}) : super(key: key);

  @override
  State<CreateList> createState() => _CreateListState();
}

class _CreateListState extends State<CreateList> {
  final _listName = TextEditingController();

  List<TextEditingController> wordTextEditingList = [];
  List<Row> wordListField = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i=0; i<10; ++i)
      wordTextEditingList.add(TextEditingController());

    for(int i=0; i<5; ++i){
      debugPrint("====>" +(2*i).toString() + "     " +(2*i+1).toString());
      wordListField.add(
        Row(
          children: [
            Expanded(child: textFieldBuilder(textEditingController: wordTextEditingList[2*i])),
            Expanded(child: textFieldBuilder(textEditingController: wordTextEditingList[2*i+1])),
          ],
        )
      );
    }
  }



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
        leftWidgetOnClick: ()=>Navigator.pop(context)
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              textFieldBuilder(icon: const Icon(Icons.list,size: 18), hintText: "Liste Adı", textEditingController: _listName, textAlign: TextAlign.left),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("İngilizce", style: TextStyle(fontSize: 18, fontFamily: "RobotoRegular"),),
                    Text("Türkçe", style: TextStyle(fontSize: 18, fontFamily: "RobotoRegular"),)
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView( //her + ya bastığımızda yeni satırlar ekleneceği için
                  child: Column(
                    children: wordListField,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  actionBtn(addRow, Icons.add),
                  actionBtn(save, Icons.save),
                  actionBtn(deleteRow, Icons.remove),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell actionBtn(Function() click,IconData icon) {
    return InkWell(
                  onTap: ()=>click(),
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 10, top: 10), //alttan boşluk veriyoruz.
                    child: Icon(icon,size: 28,),
                    decoration: BoxDecoration(
                      color: Color(SipsakMetod.HexaColorConverter("#cf8fc4")),
                      shape:  BoxShape.circle
                    ),
                  ),
                );
  }
  //setState yöntemi bir nesnenin iç durumunun değiştiğini çerçeveye bildirir.
  //wordlistfieldi değiştirmek için 
  void addRow()
  {
    wordTextEditingList.add(TextEditingController());
    wordTextEditingList.add(TextEditingController());

    wordListField.add(
      Row(
        children: [
          Expanded(child: textFieldBuilder(textEditingController: wordTextEditingList[wordTextEditingList.length -2])), //wordlistfieldin sondan bir önceki elemanı buraya gelir
          Expanded(child: textFieldBuilder(textEditingController: wordTextEditingList[wordTextEditingList.length -1])), //son elemanı buraya gelir
        ],
      )
    );

    setState(()=>wordListField);

  }
  void save() async
  {
    if(!_listName.text.isEmpty)
      {
        int counter = 0;
        bool notEmptyPair = false;

        for(int i= 0; i<wordTextEditingList.length/2; i++) {
          String eng = wordTextEditingList[2 * i].text;
          String tr = wordTextEditingList[2 * i + 1].text;
//boşsa true döner, boş değilse ekrana yazdırmak için başına ünlem ekleriz.
          if (!eng.isEmpty && !tr.isEmpty)
          {
            counter++;
          } else
          {
            notEmptyPair = true;
          }
        }

        if(counter>=4)
        {
          if(!notEmptyPair)
          {
            Lists addedList = await DB.instance.insertList(Lists(name: _listName.text));

            for(int i= 0; i<wordTextEditingList.length/2; i++) {
              String eng = wordTextEditingList[2 * i].text;
              String tr = wordTextEditingList[2 * i + 1].text;
//boşsa true döner, boş değilse ekrana yazdırmak için başına ünlem ekleriz.

              Word word = await DB.instance.insertWord(Word(list_id: addedList.id,word_eng: eng, word_tr: tr, status: false));
              debugPrint(word.id.toString() + " " + word.list_id.toString() + " " + word.word_eng.toString() + " " + word.word_tr.toString() + " " + word.status.toString());
            }
            toastMessage("Liste Oluşturuldu");
            _listName.clear();
            wordTextEditingList.forEach((element) {
              element.clear();
            });

          }
          else
          {
            toastMessage("Boş alanları doldurun veya silin.");
          }
        }
        else
        {
          toastMessage("Minimum 4 çift dolu olmalıdır.");

        }
      }
    else
    {
      toastMessage("Lütfen liste adını girin.");
    }



  }
  void deleteRow()
  {
    if(wordListField.length != 4)
      {
        wordTextEditingList.removeAt(wordTextEditingList.length -1);
        wordTextEditingList.removeAt(wordTextEditingList.length -1);

        wordListField.removeAt(wordListField.length -1);
        setState(()=>wordListField);

      }
    else
      {
        toastMessage("Minimum 4 çift gereklidir.");
      }
  }

  Container textFieldBuilder({ int height=40, @required TextEditingController ?textEditingController, Icon ?icon, String ?hintText, TextAlign textAlign = TextAlign.center}) {
    return Container(
              height: double.parse(height.toString()),
              padding: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4)
              ),
              margin: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4) ,
              child: TextField(
                keyboardType: TextInputType.name,
                maxLines: 1,
                textAlign: textAlign,
                controller: textEditingController,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "RobotoMedium",
                  decoration: TextDecoration.none,
                  fontSize: 18
                ),
                decoration: InputDecoration(
                  icon: icon,
                  border: InputBorder.none,
                  hintText: hintText,
                  fillColor: Colors.transparent


                ),
              ),
            );
  }
}
