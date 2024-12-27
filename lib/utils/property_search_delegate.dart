import 'package:flutter/material.dart';
import 'package:rea_estate_app/models/property.dart'; // Import the Property class
import 'package:rea_estate_app/screens/property_details_screen.dart'; // Import the PropertyDetailsScreen

class PropertySearchDelegate extends SearchDelegate<String> {
  // Fetch properties directly from the Property class
  final List<Property> properties = Property.getProperties();

  // Perform search by filtering properties based on query
  List<Property> _searchProperties(String query) {
    return properties
        .where((property) => property.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      // Clear button to clear the search query
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clears the search query when the 'clear' button is pressed
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Back button to close the search screen
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Close the search screen when the back button is pressed
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Perform search when results are displayed
    final results = _searchProperties(query); // Search with the entered query

    if (results.isEmpty) {
      return Center(child: Text('No properties found.'));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final property = results[index];
        return ListTile(
          title: Text(property.title),
          subtitle: Text('${property.price}'),
          leading: Image.network(
            property.imageUrl ?? 'https://via.placeholder.com/50', // Fallback image
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          onTap: () {
            close(context, query); // Close the search screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PropertyDetailsScreen(propertyId: property.id), // Pass propertyId
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types the query
    final suggestions = _searchProperties(query); // Fetch properties based on query

    if (suggestions.isEmpty) {
      return Center(child: Text('No suggestions available.'));
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final property = suggestions[index];
        return ListTile(
          title: Text(property.title),
          subtitle: Text('${property.price}'),
          leading: Image.network(
            property.imageUrl ?? 'https://via.placeholder.com/50', // Fallback image
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          onTap: () {
            query = property.title; // Set the query to the selected property title
            showResults(context); // Show the results when a suggestion is tapped
          },
        );
      },
    );
  }
}
