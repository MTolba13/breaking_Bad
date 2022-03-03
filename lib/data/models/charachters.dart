// ignore_for_file: unnecessary_null_comparison

class Character {
  late int charId;
  late String name;
  late String birthday;
  late List<dynamic> jobs;
  late String img;
  late String status;
  late String nickname;
  late List<dynamic> appearance;
  late String portrayed;
  late String category;
  late List<dynamic> betterCallSaulAppearance;

  Character(
      {required this.charId,
      required this.name,
      required this.birthday,
      required this.jobs,
      required this.img,
      required this.status,
      required this.nickname,
      required this.appearance,
      required this.portrayed,
      required this.category,
      required this.betterCallSaulAppearance});

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    jobs = json['occupation'];
    img = json['img'];
    status = json['status'];
    nickname = json['nickname'];
    appearance = json['appearance'];
    portrayed = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }
}
  

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['char_id'] = charId;
  //   data['name'] = name;
  //   data['birthday'] = birthday;
  //   data['occupation'] = occupation;
  //   data['img'] = img;
  //   data['status'] = status;
  //   data['nickname'] = nickname;
  //   data['appearance'] = appearance;
  //   data['portrayed'] = portrayed;
  //   data['category'] = category;
  //   if (betterCallSaulAppearance != null) {
  //     data['better_call_saul_appearance'] =
  //         betterCallSaulAppearance.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }

