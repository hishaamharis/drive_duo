import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/fav.dart';
import 'details.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff201f30),
      body: Consumer<FavouriteProvider>(
        builder: (context, favouriteProvider, child) {
          final favouriteCars = favouriteProvider.favouriteCars;

          if (favouriteCars.isEmpty) {
            return const Center(
              child: Text(
                'No Favourite Cars Yet!',
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: favouriteCars.length,
            itemBuilder: (context, index) {
              final car = favouriteCars[index];

              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(car: car),
                  ),
                ),
                child: Card(
                  color: Color(0xff3B3B4F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.asset(
                            car.image,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // Aligns name and delete icon on opposite sides
                          children: [
                            Text(
                              car.name,
                              style: const TextStyle(
                                color: Color(0xffa39b9b),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 12.5,),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite_sharp,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                favouriteProvider.removeCarFromFavourites(car);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
