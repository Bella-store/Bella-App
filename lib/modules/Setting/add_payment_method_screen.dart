import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/app_string.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  const AddPaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController cardNumberController = TextEditingController();
    final TextEditingController cvvController = TextEditingController();
    final TextEditingController expiryDateController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.addPaymentMethod(context)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CreditCardDisplay(
                nameController: nameController,
                cardNumberController: cardNumberController,
                expiryDateController: expiryDateController,
              ),
              const SizedBox(height: 20),
              PaymentForm(
                nameController: nameController,
                cardNumberController: cardNumberController,
                cvvController: cvvController,
                expiryDateController: expiryDateController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  // Handle add new card action
                },
                child: Text(
                  AppString.addCard(context),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreditCardDisplay extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryDateController;

  const CreditCardDisplay({
    super.key,
    required this.nameController,
    required this.cardNumberController,
    required this.expiryDateController,
  });

  @override
  CreditCardDisplayState createState() => CreditCardDisplayState();
}

class CreditCardDisplayState extends State<CreditCardDisplay> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(AppString.masterCard, height: 30),
                  SvgPicture.asset(AppString.visa, height: 30),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.cardNumberController.text.isEmpty
                    ? '**** **** **** XXXX'
                    : '**** **** **** ${widget.cardNumberController.text.substring(widget.cardNumberController.text.length - 4)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: constraints.maxWidth < 600 ? 18 : 24,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.nameController.text.isEmpty
                        ? AppString.cardHolderName(context)
                        : widget.nameController.text,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: constraints.maxWidth < 600 ? 12 : 16,
                    ),
                  ),
                  Text(
                    widget.expiryDateController.text.isEmpty
                        ? AppString.expiryDate(context)
                        : widget.expiryDateController.text,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: constraints.maxWidth < 600 ? 12 : 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class PaymentForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController cardNumberController;
  final TextEditingController cvvController;
  final TextEditingController expiryDateController;

  const PaymentForm({
    super.key,
    required this.nameController,
    required this.cardNumberController,
    required this.cvvController,
    required this.expiryDateController,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: AppString.cardHolderName(context),
              hintText: 'Ex: Bruno Pham',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            onChanged: (value) {
              (context as Element).markNeedsBuild();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppString.pleaseEnterCardHolderName(context);
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: cardNumberController,
            decoration: InputDecoration(
              labelText: AppString.cardNumber(context),
              hintText: '**** **** **** 3456',
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              (context as Element).markNeedsBuild();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppString.pleaseEnterCardNumber(context);
              }
              if (value.length < 16) {
                return AppString.pleaseEnterValidCard(context);
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: cvvController,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    hintText: 'Ex: 123',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter CVV';
                    }
                    if (value.length != 3) {
                      return 'Please enter a valid CVV';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: expiryDateController,
                  decoration: InputDecoration(
                    labelText: AppString.exirationDate(context),
                    hintText: '03/22',
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) {
                    (context as Element).markNeedsBuild();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppString.pleaseEnterExpirationDate(context);
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
