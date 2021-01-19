import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knipmobile/home_widget.dart';
import 'package:knipmobile/main.dart';

class TreatmentSelectWidget extends StatefulWidget {

  @override
  _TreatmentSelectWidgetState createState() => _TreatmentSelectWidgetState();

  TreatmentSelectWidget({Key key}) : super(key: key);
}

class _TreatmentSelectWidgetState extends State<TreatmentSelectWidget> {

  List<ListItem> items;
  final treatments = [
    Treatment(0, "Knippen", 0, 0), // HEADER
    Treatment(3, "Knippen", 15, 30),
    Treatment(4, "Wassen, knippen en föhnen", 27, 45),
    Treatment(5, "Wassen, knippen, en tangen", 27, 45),
    Treatment(6, "Pony knippen", 5, 15),
    Treatment(0, "Verven", 0, 0), // HEADER
    Treatment(7, "Verven", 12, 20),
    Treatment(8, "Kleuren", 15, 20),
    Treatment(0, "Verzorgen", 0, 0), // HEADER
    Treatment(9, "Epileren", 10, 10),
    Treatment(10, "Ontharen", 8, 10),
    Treatment(11, "Baard scheren", 8, 5),
    Treatment(12, "Baard trimmen", 12, 10),
    Treatment(13, "Tangen", 25, 15),
    Treatment(14, "Vlechten", 10, 30),
    Treatment(15, "Opsteken", 29, 20),
    Treatment(16, "Watergolven", 30, 30)
  ];
  final Set<int> _ids = new Set<int>();

  @override
  void initState() {
    items = List<ListItem>.generate(
        treatments.length,
        (i) => treatments[i].id == 0
            ? HeadingItem(treatments[i].name)
            : BodyItem(treatments[i]));
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Stap 1: kies een behandeling.';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          titleSpacing: 20.0,
          title: Text(title),
          backgroundColor: KnipApp.colorpallete[0],
          actions: <Widget>[
              new IconButton(icon: const Icon(Icons.delete_forever_sharp), onPressed: (){
                setState(() {
                _ids.clear();
                });
              }),
            ]
        ),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];
            const headers = [0, 5, 8];
            final bool alreadySaved = _ids.contains(item.getID());

            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildSubtitle(context),
              trailing: headers.contains(index) ? null : new Icon(
                  alreadySaved ? Icons.check : Icons.add, //Icons.add,
                color: alreadySaved ? Colors.green : Colors.grey[600],
              ),
              onTap: (){
                if(item.getID() == null){return;} // Header wil je niet meerekenen als product.
                setState(() {
                  if (alreadySaved){
                    _ids.remove(item.getID());
                  } else {
                    _ids.add(item.getID());
                  }
                });
              },
            );
          },
        ),
        floatingActionButton: Visibility(
          visible: _ids.isNotEmpty,
          child: FloatingActionButton(
            onPressed: () {
              Home.of(context).reservation.is_one_hour = isReservationOneHour();
              Home.of(context).currentIndex = 1;
            },
            child: Icon(Icons.arrow_forward_rounded),
            backgroundColor: KnipApp.colorpallete[0],
          ),
        ),
      ),
    );
  }

  bool isReservationOneHour() {
    int time = 0;
    for(var i=0; i < _ids.length; i++){
      var element = _ids.elementAt(i);
      Treatment treatment = getTreatmentByID(element);
      time += treatment.timePeriod;
    }
    if(time > 30){
      return true;
    } else {
      return false;
    }
  }

  Treatment getTreatmentByID(int element) {
    for(Treatment t in treatments){
      if(t.id == element){
        return t;
      }
    }
    return null;
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildTitle(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildSubtitle(BuildContext context);

  int getID();
}

/// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);

  Widget buildTitle(BuildContext context) {
    return Container(
        child: Text(
          heading,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black))));
  }

  Widget buildSubtitle(BuildContext context) => null;

  int getID() => null;
}

/// A ListItem that contains data to display a message.
class BodyItem implements ListItem {
  final Treatment treatment;

  BodyItem(this.treatment);

  Widget buildTitle(BuildContext context) => Container(
      child: Text(treatment.name, style: TextStyle(fontSize: 17)),
      padding: EdgeInsets.only(bottom: 3.0));

  Widget buildSubtitle(BuildContext context) => Container(
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: "Tijdsduur: ",
                style: TextStyle(color: Colors.black.withOpacity(1.0)),
              ),
              TextSpan(
                text: treatment.timePeriod.toString() + " minuten\n",
                style: TextStyle(
                    color: Colors.black.withOpacity(1.0),
                    decoration: TextDecoration.underline),
              ),
              TextSpan(
                text: "Prijs: ",
                style: TextStyle(color: Colors.black.withOpacity(1.0)),
              ),
              TextSpan(
                text: "\u{20AC} " + treatment.price.toString(),
                style: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        padding: EdgeInsets.only(bottom: 5.0),
      );

  @override
  int getID() {
      return treatment.id;
  }
}

class Treatment {
  int id;
  String name;
  int price;
  int timePeriod;

  Treatment(this.id, this.name, this.price, this.timePeriod);
}
