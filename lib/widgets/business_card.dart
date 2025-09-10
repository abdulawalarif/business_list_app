import 'package:flutter/material.dart';

class BusinessCard<T> extends StatelessWidget {
  // This widget is generic and can accept any model 'T'
  // The caller must provide a function to extract the relevant data from 'T'
  final T item;
  final Widget Function(BuildContext context, T item) builder;

  const BusinessCard({Key? key, required this.item, required this.builder})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // Delegate the rendering of the inner content to the builder function
        child: builder(context, item),
      ),
    );
  }
}
