import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Initialize Firebase services
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

// Collection references
final CollectionReference usersRef = firestore.collection('users');
final CollectionReference productRef = firestore.collection('products');
final CollectionReference chatRef = firestore.collection("chats");
final CollectionReference postRef = firestore.collection('posts');
final CollectionReference storyRef = firestore.collection('posts');
final CollectionReference flashRef = firestore.collection('flashes');
final CollectionReference eventRef = firestore.collection('events');
final CollectionReference commentRef = firestore.collection('comments');
final CollectionReference notificationRef = firestore.collection('notifications');
final CollectionReference followersRef = firestore.collection('followers');
final CollectionReference followingRef = firestore.collection('following');
final CollectionReference likesRef = firestore.collection('likes');
final CollectionReference favUsersRef = firestore.collection('favoriteUsers');
final CollectionReference chatIdRef = firestore.collection('chatIds');
final CollectionReference statusRef = firestore.collection('status');

// Storage references
final Reference profilePic = storage.ref().child('profilePic');
final Reference flashes = storage.ref().child('flashes');
final Reference posts = storage.ref().child('posts');
final Reference statuses = storage.ref().child('status');
