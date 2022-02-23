import 'dart:convert';


  List<ProfileModel> profileFromJson(String str) => List<ProfileModel>.from(json.decode(str).map((e) => ProfileModel.fromJson(e)));
  String profileToJson(List<ProfileModel> data) => json.encode(List<dynamic>.from(data.map((e) => e.toJson())));
class ProfileModel{
  late String login;            late int id;
  late String url;              late Map followers_url;
  late Map following_url;       late Map repos_url;
  late Map events_url;          late String type;
  late String name;             late String company;
  late String blog;             late String location;
  late bool hireable;           late String bio;
  late int public_repos;        late int following;
  var created_at;               var updated_at;

  ProfileModel({required this.login, required this.id, required this.url, required this.followers_url, required this.following_url, required this.repos_url, required this.events_url, required this.type, required this.name,
                    required this.company, required this.blog, required this.location, required this.hireable, required this.bio, required this.public_repos, required this.following, this.created_at,
                        this.updated_at});
  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    login: json["login"],                                         id: json["id"],
    url: json["url"],                                             followers_url: json["followers_url"],
    following_url: json["following_url"],                         repos_url: json["repos_url"],
    events_url: json["events_url"],                               type: json["type"],
    name: json["name"],                                           company: json["company"],
    blog: json["blog"],                                           location: json["location"],
    hireable: json["hireable"],                                   bio: json["bio"],
    public_repos: json["public_repos"],                           following: json["following"],
    created_at: json["created_at"],                               updated_at: json["updated_at"],
  );
  Map<String, dynamic> toJson() => {
    "login":login,                                         "id":id,
    "url":url,                                             "followers_url":followers_url,
    "following_url":following_url,                         "repos_url":repos_url,
    "events_url":events_url,                               "type":type,
    "name":name,                                           "company":company,
    "blog":blog,                                           "location":location,
    "hireable":hireable,                                   "bio":bio,
    "public_repos":public_repos,                           "following":following,
    "created_at":created_at,                               "updated_at":updated_at,
  };
}