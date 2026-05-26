import 'package:isar_community/isar.dart';

// FIXED: Added the underscore to match 'collection_item.dart'
part 'collectionitem.g.dart';

@collection
class CollectionItem {
  Id id = Isar.autoIncrement;

  late String name;
  late String imageUrl;
  late String color;
  late String category;
}
