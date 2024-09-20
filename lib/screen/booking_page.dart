import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:volt_way/screen/paymnt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingPage extends StatefulWidget {
  final double amount; // Price per day

  BookingPage({required this.amount});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? startDate;
  DateTime? endDate;
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Function to select date
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != (isStartDate ? startDate : endDate)) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  // Function to calculate total days and total price
  int _calculateDays() {
    if (startDate != null && endDate != null) {
      return endDate!.difference(startDate!).inDays + 1; // Inclusive of both start and end dates
    }
    return 0;
  }

  // Function to validate address
  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address cannot be empty';
    }
    if (value.length < 5) {
      return 'Address should be at least 5 characters long';
    }
    if (!value.contains(RegExp(r'\d'))) {
      return 'Address should include a number (e.g., house or apartment number)';
    }
    return null;
  }

  // Function to store booking details in Firestore
  Future<void> _storeBookingInFirestore(DateTime startDate, DateTime endDate, String address, double totalPrice) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('bookings').add({
        'startDate': startDate,
        'endDate': endDate,
        'address': address,
        'totalPrice': totalPrice,
        'timestamp': FieldValue.serverTimestamp(), // To keep track of booking time
      });
    } catch (e) {
      print("Error storing booking details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalDays = _calculateDays();
    double totalPrice = totalDays * widget.amount;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Booking',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: const Color(0xff8282a6),
      ),
      backgroundColor: const Color(0xff2C2B42),
      body: Container(
        width: double.infinity,
        height: 460,
        decoration: BoxDecoration(
          color: Color(0xff3B3B4F),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Trip Dates:',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: Container(
                        width: 178,
                        height: 70,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white60),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month, color: Colors.white70),
                            SizedBox(width: 15),
                            Text(
                              startDate != null
                                  ? DateFormat('yyyy-MM-dd').format(startDate!)
                                  : 'Trip Start',
                              style: TextStyle(color: Colors.white70, fontSize: 19.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => _selectDate(context, false),
                      child: Container(
                        width: 178,
                        height: 70,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white60),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_month, color: Colors.white70),
                            SizedBox(width: 15),
                            Text(
                              endDate != null
                                  ? DateFormat('yyyy-MM-dd').format(endDate!)
                                  : 'Trip End',
                              style: TextStyle(color: Colors.white70, fontSize: 19.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Enter Address',
                    labelStyle: TextStyle(color: Colors.white60),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: _validateAddress,
                ),
                SizedBox(height: 20),
                if (totalDays > 0) ...[
                  Text(
                    'Total Days: $totalDays',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  SizedBox(height: 30),
                ],
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (startDate != null && endDate != null) {
                          // Store the booking in Firestore
                          await _storeBookingInFirestore(startDate!, endDate!, _addressController.text, totalPrice);

                          // Navigate to payment page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(
                                amount: totalPrice,
                                startDate: startDate!,
                                endDate: endDate!,
                                address: _addressController.text,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select both dates')),
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Proceed to Payment',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white70),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
