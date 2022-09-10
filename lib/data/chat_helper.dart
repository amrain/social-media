import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/data/auth_helper.dart';
import 'package:social_media/model/Firebase/chat_message.dart';

class ChatHelper {
  static ChatHelper chatHelper = ChatHelper();

  getChatId(String otherUserId) {
    String? myId = AuthHelper.authHelper.getCurrentUserId();
    int myHashCode = myId.hashCode;
    int otherHashCode = otherUserId.hashCode;
    String collectionId = myHashCode > otherHashCode
        ? myId! + otherUserId
        : otherUserId + myId!;
    return collectionId;
  }


  sendMessage(ChatMessage message, String otherUserId) {
    String collectionId = getChatId(otherUserId);
    FirebaseFirestore.instance
        .collection("chats")
        .doc(collectionId)
        .collection("messages")
        .add(message.toMap());
  }

  Stream<List<ChatMessage>> getAllMessage(String otherUserId) {
    String collectionId = getChatId(otherUserId);
    Stream<QuerySnapshot<Map<String, dynamic>>> stream = FirebaseFirestore.instance
        .collection("chats")
        .doc(collectionId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
    return stream.map((event) {
      List<ChatMessage> messages = event.docs.map((e) {
        return ChatMessage.fromeMap(e.data());
      }).toList();
      return messages;
    });
  }

  deletChat(String otherUserId){
    String collectionId = getChatId(otherUserId);
    FirebaseFirestore.instance
        .collection("chats")
        .doc(collectionId)
        .collection("messages")
        .doc("1lwwCk3iegCKzwgOuA1P")
        .delete();
  }

}