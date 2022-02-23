import 'package:flutter/material.dart';
import 'package:git_hub_api/models/profile_model.dart';
import 'package:git_hub_api/services/http_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}
GlobalKey key = GlobalKey();

RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
Offset position = box.localToGlobal(Offset.zero); //this is global position
double y = position.dy;

class _ProfilePageState extends State<ProfilePage> {

  FutureBuilder<List<ProfileModel>> _buildBody(BuildContext context) {
    final HTTPService httpService = HTTPService();
    return FutureBuilder<List<ProfileModel>>(
      future: httpService.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final List<ProfileModel> infos = snapshot.data ?? [];
            print(snapshot.data);
            return _buildInfos(context, infos);
          }
        }
    );
  }

  ListView _buildInfos(BuildContext context, List<ProfileModel> infos) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: infos.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index){
          return Card(
            elevation: 4,
            child: ListTile(
              title: Text(
                infos[index].name,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(infos[index].bio.toString(), style: const TextStyle(color: Colors.white),),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/3),
            color: Colors.indigo.shade900,
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
            padding: EdgeInsets.only(top: 150),
            color: Colors.black,
            child: _buildBody(context),
          ),

          Container(
            margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height/5)-12.5, left: (MediaQuery.of(context).size.width/4)-12.5),
            height: 225,
            width: 225,
            decoration: BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/5, left: MediaQuery.of(context).size.width/4),
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage('https://avatars.githubusercontent.com/u/94620453?v=4'), fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
