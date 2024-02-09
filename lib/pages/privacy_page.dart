import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD2DCFF),
        title: const Text('Privacy Policy',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // This will navigate back when the back button is pressed
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          // Each item in the terms and conditions list
          Text(
            '1. Acceptance of Terms',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'By accessing or using the FishNetLK service, you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use the service.',
          ),
          SizedBox(height: 16),
          Text(
            '2. Description of Service',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'FishNetLK provides an online platform for users to connect with fishing-related information, resources, and services...',
          ),
          SizedBox(height: 16),
          Text(
            '3. User Responsibilities',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Users are responsible for maintaining the security of their accounts and are prohibited from sharing login credentials with others. Users must also comply with all applicable laws and regulations while using the service.',
          ),
          SizedBox(height: 16),
          Text(
            '4. Privacy Policy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'FishNetLK respects the privacy of its users and collects personal information only as necessary to provide the service. For more information, please refer to our Privacy Policy.',
          ),
          SizedBox(height: 16),
          Text(
            '5. Intellectual Property',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'All content provided through the FishNetLK service, including text, images, logos, and trademarks, is the property of FishNetLK or its licensors and is protected by copyright and other intellectual property laws.',
          ),
          SizedBox(height: 16),
          Text(
            '6. Prohibited Activities',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Posting illegal, harmful, or offensive content Impersonating others or misrepresenting their affiliation with FishNetLK Attempting to gain unauthorized access to the service or its systems',
          ),
          SizedBox(height: 16),
          Text(
            '7. Limitation of Liability',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'FishNetLK is provided on an "as is" and "as available" basis, and we make no warranties or representations regarding its accuracy, reliability, or availability. In no event shall FishNetLK be liable for any damages arising from the use of the service.',
          ),
          SizedBox(height: 16),
          Text(
            '8. Modification of Terms',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'FishNetLK reserves the right to modify or update these Terms and Conditions at any time. Users will be notified of any changes, and continued use of the service constitutes acceptance of the modified terms.',
          ),
          // Repeat the same pattern for other sections...
        ],
      ),
    );
  }
}
