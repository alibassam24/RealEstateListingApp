import 'package:flutter/material.dart';
import '../models/property.dart';
import 'property_details_screen.dart';
import '../utils/property_search_delegate.dart';
import 'favorite_properties_screen.dart'; // Import FavoritePropertiesScreen
import 'login_screen.dart'; // Import LoginScreen
import 'user_profile_screen.dart'; // Import ProfileScreen (the new screen for profile management)
import 'add_listing_screen.dart'; // Import AddListingScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Property> _properties;

  @override
  void initState() {
    super.initState();
    // Fetch properties from property.dart using Property.getProperties()
    _properties = Property.getProperties(); // Fetch properties dynamically
  }

  // Logout function
  Future<void> logout(BuildContext context) async {
    // Here you would clear user session or handle logout logic
    // For now, just navigating to the LoginScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Background color for the screen
      appBar: AppBar(
        title: Text('Real Estate Listings'),
        centerTitle: true,
        backgroundColor: Colors.blue, // AppBar color
        actions: [
          // Search Button
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate: PropertySearchDelegate(),
              );
            },
          ),
          // Favorite Button to navigate to FavoritePropertiesScreen
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritePropertiesScreen()),
              );
            },
          ),
          // Profile Button to navigate to ProfileScreen
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()), // Navigate to Profile Screen
              );
            },
          ),
          // Add Listing Button to navigate to AddListingScreen
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddListingScreen()), // Navigate to Add Listing Screen
              );
            },
          ),
          // Logout Button
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context), // Logout functionality
          ),
        ],
      ),
      body: _properties.isEmpty
          ? Center(child: Text('No properties available.')) // Show message when no properties
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _properties.length,
          itemBuilder: (context, index) {
            final property = _properties[index];
            return Card(
              margin: EdgeInsets.all(10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    property.imageUrl,
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
                  '\$${property.price}', // Display price
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Icon(Icons.arrow_forward, color: Colors.blue),
                onTap: () {
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
