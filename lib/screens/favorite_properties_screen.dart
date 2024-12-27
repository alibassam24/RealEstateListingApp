import 'package:flutter/material.dart';
import '../models/property.dart';
import '../utils/shared_preferences_helper.dart';
import 'property_details_screen.dart';

class FavoritePropertiesScreen extends StatefulWidget {
  @override
  _FavoritePropertiesScreenState createState() =>
      _FavoritePropertiesScreenState();
}

class _FavoritePropertiesScreenState extends State<FavoritePropertiesScreen> {
  List<Property> favoriteProperties = [];
  bool isLoading = false; // No need for loading spinner anymore

  @override
  void initState() {
    super.initState();
    loadFavoriteProperties();
  }

  // Load favorite properties from shared preferences and use hardcoded data
  Future<void> loadFavoriteProperties() async {
    final favorites = await SharedPreferencesHelper.loadFavorites(); // Assuming this returns a list of IDs
    final allProperties = Property.getProperties(); // Fetch all properties
    setState(() {
      favoriteProperties = allProperties
          .where((property) => favorites.contains(property.id))
          .toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Background color for the screen
      appBar: AppBar(
        title: Text('Favorite Properties'),
        centerTitle: true,
        backgroundColor: Colors.blue, // AppBar color
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner if necessary
          : favoriteProperties.isEmpty
          ? Center(
        child: Text(
          'No favorite properties yet!',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: favoriteProperties.length,
          itemBuilder: (context, index) {
            final property = favoriteProperties[index];
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
                  child: Image.network(
                    property.imageUrl ?? 'https://via.placeholder.com/150', // Fallback image URL
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  property.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${property.price} USD',
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Icon(Icons.arrow_forward, color: Colors.blue),
                onTap: () {
                  // Navigate to the Property Details Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PropertyDetailsScreen(
                        propertyId: property.id,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
