import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "John Doe";
  String userEmail = "johndoe@example.com";
  String userPhone = "123-456-7890";
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = userName;
    _emailController.text = userEmail;
    _phoneController.text = userPhone;
  }

  // Function to save the profile data
  void _saveProfile() {
    setState(() {
      userName = _nameController.text;
      userEmail = _emailController.text;
      userPhone = _phoneController.text;
    });
    // You can add code to save the profile data permanently (e.g., using SharedPreferences, Firebase, etc.)
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Updated')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blue, // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Name Section
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Email Section
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Phone Section
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                title: Text(
                  'Phone',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Save Button
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text('Save Profile'),
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
