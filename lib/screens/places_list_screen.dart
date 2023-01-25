import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';
import '../providers/great_places.dart';
import 'place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  // const PlaceListScreen({ Key? key }) : super(key: key);
  static const routeName = '/places_list_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Places',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AddPlaceScreen.routeName);
            },
            icon: Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  builder: (context, value, child) {
                    return value.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemCount: value.items.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(value.items[index].image),
                                ),
                                title: Text(value.items[index].title),
                                subtitle:
                                    Text(value.items[index].location.address),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    PlaceDetailScreen.routeName,
                                    arguments: value.items[index].id,
                                  );
                                },
                              );
                            },
                          );
                  },
                  child: Center(
                    child: Text(
                      'Got no places yet, start adding some!',
                    ),
                  ),
                );
        },
      ),
    );
  }
}


// Center(
//         child: CircularProgressIndicator(),
//       ),