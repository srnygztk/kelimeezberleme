
class SipsakMetod implements HexaColorConvertColor{
// sadece fonksiyonun bir üst sınıfta da tanımlandığına, ancak mevcut sınıfta başka bir şey yapmak için yeniden tanımlandığına işaret ediyor.
// Soyut bir yöntemin uygulanmasına açıklama eklemek için de kullanılır.
  @override
  //sürekli nesne üretmemek için static tanımlarız
  static int HexaColorConverter(String colorHex) {
    return int.parse(colorHex.replaceAll('#', '0xff'));
  }


}

class HexaColorConvertColor{

static int ?HexaColorConverter(String ?colorHex){}
}


