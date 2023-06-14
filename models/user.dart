
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
  /// - the user constructor with all arguments
  ///
  /// @param id       [int] <br>
  /// @param name     [String] <br>
  /// @param age      [int] <br>
  /// @param address  [String] <br>
  User(this.id, this.name, this.age, this.address) : super();

  /// ## Constructor
  /// - the named constructor for user
  User.empty();

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'age': this.age,
      'address': this.address
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['name'], json['age'], json['address']);
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
    return 'id: $id, name: $name, age: $age, address: $address';
  }
}
