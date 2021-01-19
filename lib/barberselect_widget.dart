import 'package:flutter/material.dart';
import 'package:knipmobile/avatar_widget.dart';
import 'home_widget.dart';
import 'main.dart';

class BarberSelectWidget extends StatefulWidget {
  BarberSelectWidget({Key key}) : super(key: key);

  @override
  _BarberSelectWidgetState createState() => _BarberSelectWidgetState();
}

class _BarberSelectWidgetState extends State<BarberSelectWidget> {
  final String title = 'Stap 2: kies een kapper.';
  int selectBarber = -1;

  final List<String> barbers = ['Finn','Wesley','Floris','Max'];
  final List<int> barber_id = [8,3,5,4];

  List<Color> color = [Colors.black,Colors.black,Colors.black,Colors.black];

  @override
  Widget build(BuildContext context) {
    // this.avatarwidget.id == selectBarber ?
    // Remove all other effects of other selves
    // Add select effect to self

    var size = MediaQuery.of(context).size;

    // 24 is for notification bar on Android
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 5.0,
          backgroundColor: KnipApp.colorpallete[0],
          title: Row(
            children: <Widget>[
              new IconButton(
                  icon: const Icon(Icons.arrow_back_sharp),
                  onPressed: () {
                    setState(() {
                      Home.of(context).currentIndex = 0;
                    });
                  }),
              Text(title)
            ],
          ),
        ),
        body: Center(
          child: GridView.count(
              childAspectRatio: (itemWidth / itemHeight),
              primary: false,
              shrinkWrap: true,
              padding: const EdgeInsets.all(25),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: List.generate(
                  4,
                  (index) => AvatarWidget(
                      imageUrl: 'assets/barber'+ index.toString() + '.png',
                      barberName: barbers[index],
                      id: barber_id[index],
                      color: color[index],
                      onTap: (){
                        setState(() {
                          if(color[index] == Colors.green){ // already selected?
                            color[index] = Colors.black;
                            selectBarber = -1;
                            return;
                          }
                          selectBarber = barber_id[index];
                          color = [Colors.black,Colors.black,Colors.black,Colors.black];
                          bool selected = selectBarber == barber_id[index];
                          color[index] = selected ? Colors.green : Colors.black;
                        });
                      })
              )),
        ),
        floatingActionButton: Visibility(
          visible: userSelected(),
          child: FloatingActionButton(
            onPressed: () {
              Home.of(context).reservation.kappers_id = selectBarber;
              Home.of(context).currentIndex = 2;
            },
            child: Icon(Icons.arrow_forward_rounded),
            backgroundColor: KnipApp.colorpallete[0],
          ),
        ),
      ),
    );
  }

  userSelected() {
    for(Color c in color){
      if(c == Colors.green){
        return true;
      }
    }
    return false;
  }

}
