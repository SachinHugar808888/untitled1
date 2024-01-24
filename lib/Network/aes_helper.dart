import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class AESHelper {
  static const String SECRET_KEY = "int123\$%^1234567";

  static encrypt.Encrypted encryptMsg(String message) {
    final key = encrypt.Key.fromUtf8(SECRET_KEY);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(message, iv: iv);
    return encrypted;
  }

  static String decryptMsg(encrypt.Encrypted encrypted) {
    final key = encrypt.Key.fromUtf8(SECRET_KEY);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}
