import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:volt_way/screen/privacy&policy.dart';
import 'package:volt_way/screen/terms_page.dart';

import 'address_page.dart';
import 'favourites_page.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  String? _profilePhotoUrl;
  String? _displayName;
  String? _address; // To store the user's address
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _profilePhotoUrl = _auth.currentUser?.photoURL;
    _fetchUserName(); // Fetch the user's name when the page loads
    _fetchUserAddress(); // Fetch the user's address when the page loads
  }

  // Fetch the user's name from Firestore
  Future<void> _fetchUserName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _displayName = userDoc['name'];
      });
    }
  }

  // Fetch the user's address from Firestore
  Future<void> _fetchUserAddress() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _address = userDoc['address'];
      });
    }
  }

  // Update profile photo function
  Future<void> _updateProfilePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      setState(() {
        isLoading = true;
      });
      try {
        String fileName =
            'profile_photos/${_auth.currentUser!.uid}/${DateTime.now().millisecondsSinceEpoch}';
        TaskSnapshot snapshot = await _storage.ref(fileName).putFile(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();

        User? user = _auth.currentUser;
        if (user != null) {
          await user.updatePhotoURL(downloadUrl);
          await user.reload();
          User? updatedUser = _auth.currentUser;
          setState(() {
            _profilePhotoUrl = updatedUser?.photoURL;
          });
        }
      } catch (e) {
        print("Error updating profile photo: $e");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Navigate to the AddAddressPage and update the address
  Future<void> _navigateToAddAddressPage() async {
    final String? newAddress = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAddressPage(currentAddress: _address ?? ''),
      ),
    );

    // If the address was updated, set the new address
    if (newAddress != null) {
      setState(() {
        _address = newAddress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff2b2b40),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),

                  // Profile Photo
                  GestureDetector(
                    onTap: _updateProfilePhoto,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: _profilePhotoUrl != null
                              ? NetworkImage(_profilePhotoUrl!)
                              : const AssetImage(
                                      "assets/images/default_user.png")
                                  as ImageProvider,
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                )
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            radius: 20,
                            child: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // User's name
                  Text(
                    _displayName ?? "No Name",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // User's email
                  Text(
                    user?.email ?? "No Email",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white60,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Log out button
                  Padding(
                    padding: const EdgeInsets.only(left: 80, right: 80),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff8282a6),
                        minimumSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: const [
                          SizedBox(width: 15),
                          Icon(Icons.logout, color: Colors.black, size: 22),
                          SizedBox(width: 10),
                          Text(
                            'Log Out',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Favourite Cars
          _buildOptionItem(
            context,
            icon: Icons.favorite,
            title: "Favourite Cars",
            subtitle: "Checkout your favourite cars",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavouritesPage()),
              );
            },
          ),

          const SizedBox(height: 30),

          // Address
          _buildOptionItem(
            context,
            icon: CupertinoIcons.location,
            title: "Address",
            subtitle: _address ?? "Change address",
            // Display the address or "Change address"
            onTap: _navigateToAddAddressPage,
          ),

          const SizedBox(height: 30),

          // Terms and Conditions
          _buildOptionItem(
            context,
            icon: Icons.description,
            title: "Terms and Conditions",
            subtitle: "Read our terms",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsPage()),
              );
            },
          ),

          const SizedBox(height: 30),

          // Privacy Policy
          _buildOptionItem(
            context,
            icon: Icons.privacy_tip,
            title: "Privacy Policy",
            subtitle: "View our privacy policy",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xff201f30),
    );
  }

  // Reusable option item builder
  Widget _buildOptionItem(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xff2b2b40),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundColor: Colors.black26,
              child: Icon(icon, color: Colors.white70),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
