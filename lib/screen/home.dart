import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/carModel.dart';
import '../providers/fav.dart';
import 'details.dart';
import 'favourites_page.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Car> cars = all();
  late List<Car> filteredCars;
  TextEditingController searchController = TextEditingController();
  int _currentIndex = 0;
  PageController _pageController = PageController();

  final List<Widget> _pages = [
    // Home page
    HomeScreenContent(),
    // Favourites page
    FavouritesPage(),
    // Profile page
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    filteredCars = cars;
    searchController.addListener(() {
      filterCars();
    });
  }

  void filterCars() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredCars = cars.where((car) {
        return car.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff201f30),
      appBar: AppBar(
        backgroundColor: const Color(0xff8282a6),
        centerTitle: true,
        title: const Text(
          'D R I V E   D U O',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: _pages,
        physics: const BouncingScrollPhysics(), // Optional: for a bouncy scrolling effect
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: BottomNavigationBar(
              key: ValueKey<int>(_currentIndex), // Helps animate the switch
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut, // Smooth animation effect
                );
              },
              backgroundColor: const Color(0xff8282a6),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favourites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Separated the main content of HomeScreen into its own widget to prevent infinite recursion
class HomeScreenContent extends StatelessWidget {
  final List<Car> cars = all();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search cars...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              final favProvider = Provider.of<FavouriteProvider>(context);

              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(car: car),
                  ),
                ),
                child: Card(
                  color: const Color(0xff3B3B4F),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.asset(
                            car.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              car.name,
                              style: const TextStyle(
                                color: Color(0xffa39b9b),
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                  favProvider.isFavourite(car)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.black
                              ),
                              onPressed: () {
                                if (favProvider.isFavourite(car)) {
                                  favProvider.removeCarFromFavourites(car);
                                } else {
                                  favProvider.addCarToFavourites(car);
                                }
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
          ),
        ),
      ],
    );
  }
}
