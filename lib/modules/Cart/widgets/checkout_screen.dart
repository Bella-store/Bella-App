import 'package:bella_app/shared/app_string.dart';
import 'package:flutter/material.dart';
import '../../../shared/app_color.dart';
import '../../Setting/myorder_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedOption = 'visa'; // Default selection

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppString.delivery(context),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDeliveryMethod(context, height),
              SizedBox(height: height * 0.02),
              _buildAddressDetails(context, height),
              SizedBox(height: height * 0.04),
              _buildProceedButton(context, width),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryMethod(BuildContext context, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.paymentMethod(context),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: height * 0.01),
        RadioListTile<String>(
          value: 'visa',
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value!;
            });
          },
          title: Text(
            'Visa',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text(
            AppString.payVisa(context),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          secondary: Icon(
            Icons.credit_card,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        RadioListTile<String>(
          value: 'pickup',
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value!;
            });
          },
          title: Text(
            'Pick Up',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text(
            'Pick up at the store',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          secondary: Icon(
            Icons.location_on,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressDetails(BuildContext context, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.userInfo(context),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        ListTile(
          leading: Icon(Icons.location_on, color: Theme.of(context).iconTheme.color),
          title: Text(
            '591 Hill',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text(
            'Florida, Miami',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color),
          onTap: () {
            _showChangeDialog(context, AppString.changeAddress(context), AppString.enterAddress(context));
          },
        ),
        ListTile(
          leading: Icon(Icons.phone, color: Theme.of(context).iconTheme.color),
          title: Text(
            '(620) 555-0273',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color),
          onTap: () {
           _showChangeDialog(context, AppString.changePhoneNumber(context), AppString.enterPhoneNumber(context));
          },
        ),
        ListTile(
          leading: Icon(Icons.email, color: Theme.of(context).iconTheme.color),
          title: Text(
            'joan.aubrey@gmail.com',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color),
          onTap: () {
           _showChangeDialog(context, AppString.changeEmail(context), AppString.enterEmail(context));
          },
        ),
      ],
    );
  }

  Widget _buildProceedButton(BuildContext context, double width) {
    return ElevatedButton(
      onPressed: () {
        if (_selectedOption == 'pickup') {
          // Navigate to My Order screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyOrderScreen()),
          );
        } else {
          // Proceed to payment stripe
          
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, 50),
        backgroundColor:  AppColor.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        AppString.continuePayment(context),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }

  void _showChangeDialog(BuildContext context, String title, String hint) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text(AppString.cancel(context), style: Theme.of(context).textTheme.labelLarge),
            ),
            TextButton(
              onPressed: () {
                // Implement your logic to save the updated information
                Navigator.of(context).pop(); 
              },
              child: Text(AppString.save(context), style: Theme.of(context).textTheme.labelLarge),
            ),
          ],
        );
      },
    );
  }
}
