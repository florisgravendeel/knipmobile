import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {

  final String imageUrl;
  final String barberName;
  final int id;
  final GestureTapCallback onTap;
  final Color color;

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();

  AvatarWidget({Key key, this.imageUrl, this.barberName, this.id, this.onTap, this.color}) : super(key: key);


}

class _AvatarWidgetState extends State<AvatarWidget> {

  Color borderColor = Colors.black;
  set setBorderColor(Color value) => setState(() => borderColor = value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40),
          child: CircularProfileAvatar(
            null,
            child: Image(
              image: AssetImage(this.widget.imageUrl),
              fit: BoxFit.cover,
            ),
            borderColor: this.widget.color,
            backgroundColor: Colors.red,
            borderWidth: 4.2,
            elevation: 5,
            radius: 85,
            onTap: this.widget.onTap,
          ),
          ),
        Container(child: Text(widget.barberName, style: TextStyle(fontSize: 25)), padding: EdgeInsets.only(top: 12))
      ],
    );
  }

}
