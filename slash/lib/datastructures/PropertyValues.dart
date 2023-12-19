class ProductPropertyAndValue {
  final String property; //color, or size, or material
  final String value;

  ProductPropertyAndValue(
      {required this.property,
      required this.value}); //if property is color, value may be: #008000(hex for Green)
  //if property is size, value may be: XL
  factory ProductPropertyAndValue.fromJson(Map<String, dynamic> json) {
    return ProductPropertyAndValue(
      property: json['property'] ?? '',
      value: json['value'] ?? '',
    );
  }
}
