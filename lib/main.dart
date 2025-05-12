import 'package:flutter/material.dart';

void main() {
  runApp(MovieReviewApp());
}

class MovieReviewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieReviewForm(),
    );
  }
}

class MovieReviewForm extends StatefulWidget {
  @override
  _MovieReviewFormState createState() => _MovieReviewFormState();
}

class _MovieReviewFormState extends State<MovieReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  String _gender = '';
  double _rating = 0;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _gender.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review Submitted Successfully!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewDetails(
            name: _nameController.text,
            surname: _surnameController.text,
            dob: _dobController.text,
            address: _addressController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            gender: _gender,
            review: _reviewController.text,
            rating: _rating,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields before submitting.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Review')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) => value!.isEmpty ? 'Enter Name' : null,
                ),
                TextFormField(
                  controller: _surnameController,
                  decoration: InputDecoration(labelText: 'Surname'),
                  validator: (value) => value!.isEmpty ? 'Enter Surname' : null,
                ),
                TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                  validator: (value) => value!.isEmpty ? 'Enter DOB' : null,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) => value!.isEmpty ? 'Enter Address' : null,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) => value!.contains('@') ? null : 'Enter valid Email',
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.length == 10 ? null : 'Enter valid 10-digit Phone Number',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Gender: '),
                    Radio(
                      value: 'Male',
                      groupValue: _gender,
                      onChanged: (value) => setState(() => _gender = value.toString()),
                    ),
                    Text('Male'),
                    Radio(
                      value: 'Female',
                      groupValue: _gender,
                      onChanged: (value) => setState(() => _gender = value.toString()),
                    ),
                    Text('Female'),
                  ],
                ),
                TextFormField(
                  controller: _reviewController,
                  decoration: InputDecoration(labelText: 'Review'),
                  validator: (value) => value!.isEmpty ? 'Enter Review' : null,
                ),
                Slider(
                  value: _rating,
                  min: 0,
                  max: 5,
                  divisions: 5,
                  label: _rating.toString(),
                  onChanged: (value) => setState(() => _rating = value),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit Review'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Fan Button'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewDetails extends StatelessWidget {
  final String name, surname, dob, address, email, phone, gender, review;
  final double rating;

  ReviewDetails({
    required this.name,
    required this.surname,
    required this.dob,
    required this.address,
    required this.email,
    required this.phone,
    required this.gender,
    required this.review,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review Details of Customers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          children: [
            Text('Name: $name'),
            Text('Surname: $surname'),
            Text('DOB: $dob'),
            Text('Address: $address'),
            Text('Email: $email'),
            Text('Phone: $phone'),
            Text('Gender: $gender'),
            Text('Review: $review'),
            Text('Rating: $rating Stars'),
          ],
        ),
      ),
    );
  }
}
