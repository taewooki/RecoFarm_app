import 'package:get/state_manager.dart';
/*
 
  Description :  Get X Controller : json data update
  Date        : 2024.04.17 Tue
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 
	  2024.04.17 Wed
		  - State 관리를 위한 Get X view model 
  Detail      : 

*/
class VmGetX extends GetxController{

  // Properties
  List data =[];

  int num1 =0;
  int num2 =0;
  int addResult = 0;

  calcuation(){
    addition();
    update();
  }
  addition (){
    addResult =num1+num2;
  }

}