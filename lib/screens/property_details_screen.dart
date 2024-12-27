import 'package:flutter/material.dart';
import '../models/property.dart';
import '../utils/shared_preferences_helper.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final String propertyId; // Fetch data by property ID

  PropertyDetailsScreen({required this.propertyId});

  @override
  _PropertyDetailsScreenState createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  bool isFavorite = false;
  Property? property; // Holds the fetched property details

  @override
  void initState() {
    super.initState();
    fetchPropertyDetails();
    checkIfFavorite();
  }

  // Fetch property details from the list of properties in property.dart
  void fetchPropertyDetails() {
    // Find the property based on the propertyId
    final properties = Property.getProperties();
    setState(() {
      property = properties.firstWhere(
            (prop) => prop.id == widget.propertyId,
        orElse: () => Property(
          id: '0',
          title: 'Property Not Found',
          description: 'No details available for this property.',
          price: 'N/A',
          imageUrl: 'https://via.placeholder.com/300x200',
        ),
      );
    });
  }

  // Check if the property is already in favorites
  void checkIfFavorite() async {
    final favorites = await SharedPreferencesHelper.loadFavorites();
    setState(() {
      isFavorite = favorites.contains(widget.propertyId);
    });
  }

  // Add or remove property from favorites
  void toggleFavorite() async {
    final favorites = await SharedPreferencesHelper.loadFavorites();

    if (isFavorite) {
      favorites.remove(widget.propertyId);
    } else {
      favorites.add(widget.propertyId);
    }

    await SharedPreferencesHelper.saveFavorites(favorites);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Background color for the screen
      appBar: AppBar(
        title: Text(property?.title ?? 'Loading...'),
        centerTitle: true,
        backgroundColor: Colors.blue, // AppBar color
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: toggleFavorite,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isFavorite ? Colors.red : Colors.grey, // Red when favorite, gray when not
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey, // Red when favorite, gray when not
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 8), // Space between icon and text
                  Text(
                    'Favorite',
                    style: TextStyle(
                      color: isFavorite ? Colors.red : Colors.grey, // Red when favorite, gray when not
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: property == null
          ? Center(child: CircularProgressIndicator()) // Show spinner while loading
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  property?.imageUrl ?? 'https://via.placeholder.com/150', // Fallback image URL
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),

              // Property Title
              Text(
                property?.title ?? 'Loading...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),

              // Property Price
              Text(
                '\$${property?.price ?? '0.00'}',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),

              // Property Description
              Text(
                property?.description ?? 'No description available.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
