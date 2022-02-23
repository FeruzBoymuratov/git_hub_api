
import 'dart:convert';

import 'package:http/http.dart';

import '../models/profile_model.dart';

class HTTPService{
  final String profile = "https://api.github.com/users/FeruzBoymuratov";

  Future <List<ProfileModel>> getProfile() async {
    Response res = await get(Uri.parse(profile));

    if(res.statusCode == 200){
      List<dynamic> body = jsonDecode(res.body);

      List<ProfileModel> infos = body.map((dynamic item) => ProfileModel.fromJson(item),
      ).toList();
      return infos;
    }else{
      throw "Infos ni chiqarib bo'lmadi!";
    }
  }
}