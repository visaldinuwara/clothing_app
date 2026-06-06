import 'package:clothing_app/product.dart';

class OutFit {
  final String id;
  final DateTime wearDate;
  final List<Product> prpductItems;

  OutFit({
    required this.id,
    required this.wearDate,
    required this.prpductItems,
  });
}
