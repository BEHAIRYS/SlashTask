class AvailableProperties {
  final String property; // color, size, material, etc.
  final List<String> values;

  AvailableProperties({
    required this.property,
    required this.values,
  });

  factory AvailableProperties.fromJson(Map<String, dynamic> json) {
    // Extract the "values" list from the JSON
    List<dynamic>? jsonValues = json['values'];

    // Use map() to extract the "value" field from each element in the list
    List<String> parsedValues = jsonValues
            ?.map((value) => value['value'].toString())
            .whereType<String>()
            .toList() ??
        [];

    return AvailableProperties(
      property: json['property'] ?? '',
      values: parsedValues,
    );
  }
}
