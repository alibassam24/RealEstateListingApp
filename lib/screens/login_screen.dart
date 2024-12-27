import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errorMessage = '';

  // Hardcoded login credentials
  final String validEmail = 'user';
  final String validPassword = '123';

  // Login function
  void login() {
    if (_emailController.text == validEmail && _passwordController.text == validPassword) {
      // Navigate to HomeScreen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      setState(() {
        errorMessage = 'Invalid email or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,  // Background color
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blue,  // AppBar color
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo or App Name
                Text(
                  'Real Estate App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),

                // Email TextField with custom styling
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                ),
                SizedBox(height: 20),

                // Password TextField with custom styling
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                ),
                SizedBox(height: 20),

                // Display error message if any
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                SizedBox(height: 20),

                // Login Button with custom styling
                ElevatedButton(
                  onPressed: login,
                  child: Text('Login', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,  // Button color
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

                // Additional space
                SizedBox(height: 30),

                // Optional: Add a sign up link or button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Signup screen
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        '',
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
