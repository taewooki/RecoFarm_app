/* 
    Description : SQlite의 Model 
    Author 		: Lcy
    Date 			: 2024.04.19
*/

class Area {
  // seq
  int? seq;
  // 관심 소재지 이름
  String name;
  // 관심 소재지 면적
  double area;
  // 위도
  double lat;
  // 경도
  double long;

  Area ({
    this.seq,
    required this.name,
    required this.area,
    required this.lat,
    required this.long,
  });

  Area.fromMap(Map<String, dynamic> res)
    : seq = res['seq'],
      name = res['name'],
      area = res['name'],
      lat = res['lat'],
      long = res['long'];
}