import 'dart:convert';
import 'dart:typed_data';

const BLOCK_SIZE = 8; // DES block size is 8 bytes

class DES {
  static final _key = new Uint8List(8);
  static final _des = DESKey(_key);


  // Encrypts the message using DES in CBC mode
  static Uint8List encrypt(Uint8List message, Uint8List iv) {
    Uint8List result = new Uint8List(message.length);

    Uint8List block = new Uint8List(BLOCK_SIZE);
    Uint8List previousBlock = new Uint8List.fromList(iv);

    for (int i = 0; i < message.length; i += BLOCK_SIZE) {
      // XOR the message block with the previous cipher block
      for (int j = 0; j < BLOCK_SIZE; j++) {
        block[j] = message[i + j] ^ previousBlock[j];
      }

      // Encrypt the XORed block
      block = _des.encryptBlock(block);

      // Save the cipher block for the next iteration
      previousBlock = new Uint8List.fromList(block);

      // Append the cipher block to the result
      result.setRange(i, i + BLOCK_SIZE, block);
    }

    return result;
  }

  // Decrypts the message using DES in CBC mode
  static Uint8List decrypt(Uint8List message, Uint8List iv) {
    Uint8List result = new Uint8List(message.length);

    Uint8List block = new Uint8List(BLOCK_SIZE);
    Uint8List previousBlock = new Uint8List.fromList(iv);

    for (int i = 0; i < message.length; i += BLOCK_SIZE) {
      // Decrypt the cipher block
      block = _des.decryptBlock(message.sublist(i, i + BLOCK_SIZE));

      // XOR the decrypted block with the previous cipher block
      for (int j = 0; j < BLOCK_SIZE; j++) {
        result[i + j] = block[j] ^ previousBlock[j];
      }

      // Save the cipher block for the next iteration
      previousBlock = new Uint8List.fromList(message.sublist(i, i + BLOCK_SIZE));
    }

    return result;
  }
}

 class DESKey {
  DESKey(Uint8List key);
   decryptBlock(Uint8List sublist) {}
   encryptBlock(Uint8List block) {}
}

