import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_recofarm_app/model/year_api_chart_model.dart';
import 'package:xml/xml.dart' as xml;

class NapaCabbageAPI extends GetxController {

  List<Map<String,String>> apiModel = [];
  List<Map<String,String>> yearModel = [];


  //
  late List<YearChart> chartData2 = [
      YearChart(year: 2020, price: 4000),
      YearChart(year: 2021, price: 3000),
      YearChart(year: 2022, price: 2000),
      YearChart(year: 2023, price: 1000),
    ];

  
  bool loopStatus = false;

  Future<void> fetchXmlData() async {
    final url = Uri.parse('http://211.237.50.150:7080/openapi/b2c4c81d3e3b685b913bd27e183618c306a179d340cb05593d06ace9746b6270/xml/Grid_20220817000000000620_1/1/10?DATES=20231102&MCLASSNAME=배추');
    final response = await http.get(url);

    if (response.statusCode == 200) {

      apiModel.clear();

      final document = xml.XmlDocument.parse(response.body);

      final rootElement = document.rootElement;
      final items = rootElement.findAllElements('row');

      if(items.isEmpty) {
        return;
      }

      for (final item in items) {
        final date = item.findElements('DATES').single.innerText;
        final sClassName = item.findElements('SCLASSNAME').single.innerText;
        final price = item.findElements('AVGPRICE').single.innerText;
        final marketName = item.findElements('MARKETNAME').single.innerText;
        final weight = item.findElements('UNITNAME').single.innerText;

        // print('날짜 : $date, 품종 : $sClassName, 가격 : $price, 마켓이름 : $marketName, 무게 : $weight');
        
        apiModel.add(
          {
            'date' : date,
            'sClassName' : sClassName,
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

  Future<void> yearlySalesList() async {
    final url = Uri.parse('https://www.kamis.or.kr/service/price/xml.do?action=yearlySalesList&p_yyyy=2024&p_period=3&p_itemcategorycode=200&p_itemcode=211&p_kindcode=01&p_graderank=2&p_countycode=1101&p_convert_kg_yn=N&p_cert_key=996165d6-29e7-4d50-9078-8e1439ad545f&p_cert_id=4276&p_returntype=xml');
    final response = await http.get(url);

    if (response.statusCode == 200) {

      final document = xml.XmlDocument.parse(response.body);
      final items = document.findAllElements('price').expand((price) => price.findElements('item'));
      
      if(items.isEmpty) {
        return;
      }

      chartData2.clear();

      for (final item in items.take(4)) {

        final year = item.findElements('div').single.innerText;
        final avgData = item.findElements('avg_data').single.innerText;
        final maxData = item.findElements('max_data').single.innerText;
        final minData = item.findElements('min_data').single.innerText;
        final stddevData = item.findElements('stddev_data').single.innerText;
        final cvData = item.findElements('cv_data').single.innerText;
        final afData = item.findElements('af_data').single.innerText;

        // print('연도 : $year, 평균가 : $avgData, 최대가 : $maxData, 최소가 : $minData, 표준편차 : $stddevData, 변동계수 : $cvData, 진폭계수 : $afData');

        chartData2.add(
          YearChart(year: int.parse(year), price: int.parse(avgData.replaceAll(',', '')))
        );
      }

      chartData2.sort((a, b) => a.year.compareTo(b.year));
      
    }else {
      print('Failed to fetch XML data: ${response.statusCode}');
    }
 
    update();
  }




}