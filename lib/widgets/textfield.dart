import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:spring_edge_assignment/constraints/const.dart';

class CustomAutoCompleteField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final List<String> suggestions;

  const CustomAutoCompleteField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Image.asset('assets/location.png'),
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: border)),
          hintStyle: gray_16,
        ),
      ),
      suggestionsCallback: (pattern) {
        return suggestions.where(
          (item) => item.toLowerCase().contains(pattern.toLowerCase()),
        );
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion, style: const TextStyle(color: Colors.grey)),
        );
      },
      onSuggestionSelected: (suggestion) {
        controller.text = suggestion;
      },
    );
  }
}
