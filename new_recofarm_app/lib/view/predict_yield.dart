import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_recofarm_app/vm/vmpredict_yield.dart';

class PredictYield extends StatelessWidget {
  PredictYield({super.key});

  TextEditingController areaController = TextEditingController();
  final VMpredict vmPredictController = Get.put(VMpredict());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('수확량 예측하기'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: areaController,
                decoration: const InputDecoration(
                  // labelText: '단위 : 미터제곱',
                  hintText: '면적을 입력해주세요!',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  )
                ),
                onChanged: (value) {
                  // areaController.text = '${areaController.text} m^2';
                },
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => placeSelecteActionSheet(context),
              icon: Icon(Icons.search),
              label: const Text('지역')
            )
          ],
        ),
      ),
    );
  }

  placeSelecteActionSheet(context) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoActionSheet(
        // title: const Text('Title'),
        // message: const Text('Message'),
        actions: [
          SizedBox(
            height: 200,
            child: CupertinoPicker(
              itemExtent: 50,
              scrollController: FixedExtentScrollController(initialItem: 0),
              onSelectedItemChanged: (value) {

              },
              children: List.generate(10, (index) => Center(
                child: Text(
                  '${vmPredictController.placeList[index]}',
                  style: TextStyle(
                    fontSize: 28
                  ),
                )
              ),
             )
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Get.back(),
            child: const Text('확인')
          ),
      ) // CupertinoActionSheet
    ); // ModalPopup
  }


}