
import 'config/table.dart';

/// # User
/// The user table.
/// 
/// @author SaiZawMyint
class User extends Table {
  /// The user id
  int? id;
  /// The user name
  String? name;
  /// The user age
  int? age;
  /// The user address
  String? address;

  /// ## Constructor
  /// The user constructor with all arguments
  ///
  /// [Parameters]:
  ///  - id       [int]
  ///  - name     [String]
  ///  - age      [int]
  ///  - address  [String]
  User(this.id, this.name, this.age, this.address) : super();

  /// ## Constructor
  /// The named constructor for user
  User.empty();

  
  /// fromJson
  /// 
  /// the class factory method to convert json object to class member object
  /// 
  /// Parameters:
  /// - json [Map<String, dynamic>]
  /// 
  /// @return [User]
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['name'], json['age'], json['address']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'age': this.age,
      'address': this.address
    };
  }

  @override
  String getClassName() {
    return "user";
  }

  @override
  String createQuery() {
    return '''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY,
      name VARCHAR(100),
      age INT(10),
      address VARCHAR(100)
    )
    ''';
  }

  @override
  String toString() {
    return '${this.toJson()}';
  }
}
