import 'package:flutter/material.dart';
import '../models/business.dart';
import 'business_card.dart';

class BusinessListTile extends StatelessWidget {
  final Business business;
  const BusinessListTile({Key? key, required this.business}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the generic BusinessCard, telling it we are using a 'Business' model
    // and providing a function to build the UI for a Business item.
    return BusinessCard<Business>(
      item: business,
      builder:
          (context, business) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                business.name,
                //style: Theme.of(context).textTheme.headline6
              ),
              const SizedBox(height: 4),
              Text('Location: ${business.location}'),
              Text('Contact: ${business.contactNumber}'),
            ],
          ),
    );
  }
}
