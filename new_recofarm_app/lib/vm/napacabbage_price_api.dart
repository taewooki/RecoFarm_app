import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class NapaCabbageAPI extends GetxController {

  List<Map<String,String>> apiModel = [];
  bool loopStatus = false;

  Future<void> fetchXmlData() async {
    final url = Uri.parse('http://211.237.50.150:7080/openapi/b2c4c81d3e3b685b913bd27e183618c306a179d340cb05593d06ace9746b6270/xml/Grid_20220817000000000620_1/1/5?DATES=20231120&MCLASSNAME=배추');
    final response = await http.get(url);

    if (response.statusCode == 200) {

      apiModel.clear();

      final document = xml.XmlDocument.parse(response.body);

      final rootElement = document.rootElement;
      final items = rootElement.findAllElements('row');

      for (final item in items) {
        final date = item.findElements('DATES').single.innerText;
        final mClassname = item.findElements('MCLASSNAME').single.innerText;
        final price = item.findElements('AVGPRICE').single.innerText;
        final marketName = item.findElements('MARKETNAME').single.innerText;
        final weight = item.findElements('UNITNAME').single.innerText;

        print('날짜 : $date, 품종 : $mClassname, 가격 : $price, 마켓이름 : $marketName, 무게 : $weight');
        
        apiModel.add(
          {
            'date' : date,
            'mClassname' : mClassname,
            'price' : price,
            'marketName' : marketName,
            'weight' : weight,
          }
        );
      }
      
    }else {
      print('Failed to fetch XML data: ${response.statusCode}');
    }
 
    loopStatus = true;
    update();
  }


}