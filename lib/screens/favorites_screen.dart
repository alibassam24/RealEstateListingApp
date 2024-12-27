import 'package:flutter/material.dart';
import '../models/favorite_property.dart';
import '../utils/shared_preferences_helper.dart';  // Helper for storing favorites

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<FavoriteProperty> favoriteProperties = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final List<String> savedFavorites = await SharedPreferencesHelper.loadFavorites();
    setState(() {
      favoriteProperties = savedFavorites.map((id) {
        // Assuming you have a way to retrieve the property by its ID (using a mock list or API)
        return FavoriteProperty(
          id: id,
          title: "Sample Title", // Use the actual property title here
          imageUrl: "assets/images/sample_image.jpg", // Use the actual image URL here
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,  // Background color for the screen
      appBar: AppBar(
        title: Text('Favorites'),
        centerTitle: true,
        backgroundColor: Colors.blue,  // AppBar color
      ),
      body: favoriteProperties.isEmpty
          ? Center(child: Text('No Favorites Yet!', style: TextStyle(fontSize: 20, color: Colors.white)))
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: favoriteProperties.length,
          itemBuilder: (context, index) {
            final favorite = favoriteProperties[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    favorite.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  favorite.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward, color: Colors.blue),
                onTap: () {
                  // Navigate to the Property Details Screen
                  // Add logic for navigation here
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
