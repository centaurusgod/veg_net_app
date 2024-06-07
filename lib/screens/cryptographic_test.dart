// import 'dart:typed_data';

// import 'package:cryptology/cryptology.dart';

// class EncryptionTest {
//   Future<String> _encrypt_password() async {
//     final DataEncryption dataEncryption = DataEncryption.initial(
//         secretKey: 'veg_net@#QWkljhsda', mode: AESMode.cbc, iv: '12k!*VzX,s]');

//     final plainText = "plain text data";
//     final Uint8List dataAsBytes = plainText.toBytes();

//     final encryptedData = await dataEncryption.encrypt(dataAsBytes);
//     String encrypted_password = String.fromCharCodes(encryptedData);
//     return encrypted_password;

//     // print(text1);
//     // final decryptedData = await dataEncryption.decrypt(encryptedData);
//     // Output: "plain text data"
//   }
// }
