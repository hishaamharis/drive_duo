import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_way/screen/booking_page.dart';
import '../model/carModel.dart';
import '../providers/fav.dart';

class DetailsPage extends StatelessWidget {
  final Car car;

  DetailsPage({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2C2B42),
      appBar: AppBar(
        backgroundColor: const Color(0xff8282a6),
        title: Text(
          car.name,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  car.image,
                  height: 210,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      car.name,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Provider.of<FavouriteProvider>(context).isFavourite(car)
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      if (Provider.of<FavouriteProvider>(context, listen: false)
                          .isFavourite(car)) {
                        Provider.of<FavouriteProvider>(context, listen: false)
                            .removeCarFromFavourites(car);
                      } else {
                        Provider.of<FavouriteProvider>(context, listen: false)
                            .addCarToFavourites(car);
                      }
                    },
                    color: Colors.white70,
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                car.description,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Price: \$${car.pricePerDay}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Owner: ${car.ownername}',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Contact: ${car.ownerphone}',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Category: ${car.category}',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Rating: ${car.rate}',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BookingPage(amount: car.pricePerDay,)));
                  },
                  child: Text(
                    'Book',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
