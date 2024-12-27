import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddListingScreen extends StatefulWidget {
  @override
  _AddListingScreenState createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _phoneController = TextEditingController();  // Phone Number Controller
  final _emailController = TextEditingController();  // Email Controller
  final _socialMediaController = TextEditingController(); // Optional: Social Media Link Controller
  File? _image;

  // Function to pick an image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to save the listing
  void _saveListing() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final price = double.tryParse(_priceController.text);
    final phone = _phoneController.text;
    final email = _emailController.text;

    // Validate all fields
    if (title.isEmpty || description.isEmpty || price == null || _image == null || phone.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields and select an image')),
      );
      return;
    }

    // Create a new property object (this can be saved to a database or list)
    final newListing = {
      'title': title,
      'description': description,
      'price': price,
      'image': _image,
      'phone': phone,
      'email': email,
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Listing added successfully!')),
    );

    // Navigate back to the HomeScreen (or wherever you want to go)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property Listing'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Title Field
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Property Title'),
            ),
            SizedBox(height: 10),
            // Description Field
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            // Price Field
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            // Phone Number Field
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            // Email Field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email Address'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            // Optional: Social Media Link Field (e.g., WhatsApp, Instagram)
            TextField(
              controller: _socialMediaController,
              decoration: InputDecoration(labelText: 'Social Media Link (Optional)'),
            ),
            SizedBox(height: 10),
            // Image Picker Button
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                color: Colors.blueAccent,
                child: _image == null
                    ? Text(
                  'Tap to Select Image',
                  style: TextStyle(color: Colors.white),
                )
                    : Image.file(
                  _image!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Save Button
            ElevatedButton(
              onPressed: _saveListing,
              child: Text('Save Listing'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
