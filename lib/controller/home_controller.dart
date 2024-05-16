import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fishnetlk/model/chat_details/chatdetails.dart';
import 'package:fishnetlk/model/product/product.dart';
import 'package:fishnetlk/model/product_category/product_category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/message/message.dart';
import '../model/logdetails/logdetails.dart';
import '../model/post_details/postdetails.dart';
import '../model/seller_message/seller_message.dart';
import '../model/users/users.dart';

// Here we defined the class to access the database and handle the data query in documents
class HomeController extends GetxController{

  String test = 'test string';

  // defined the variables as FirebaseFirestore store data as key value and FirebaseStorage store data as files
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  //Defined the Collections variables of database
  late CollectionReference usersCollection;
  late CollectionReference logdetailsCollection;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;
  late CollectionReference chatlogCollection;
  late CollectionReference postdetailsCollection;
  late CollectionReference messageCollection;
  late CollectionReference cartCollection;
  late CollectionReference sellermessageCollection;
  // Text controllers from Add product page
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImgCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();
  // Text controllers from Add logs page
  TextEditingController fishNameCtrl = TextEditingController();
  TextEditingController fishQuantityCtrl = TextEditingController();
  TextEditingController fishLocationCtrl = TextEditingController();
  TextEditingController fishingMethodCtrl = TextEditingController();
  // Text controller from FB account create page
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  // Text controller from Post Caption page
  TextEditingController challengeDescriptionCtrl = TextEditingController();
  TextEditingController challengeTitleCtrl = TextEditingController();
  TextEditingController challengeEmailCtrl = TextEditingController();
  // Text controller from message page
  TextEditingController messageController = TextEditingController();
  // Text controller from seller message page
  TextEditingController sellerMessageController = TextEditingController();
  //Define the type of value
  DateTime birthday = DateTime.now();
  DateTime? logday;
  String? lat,long;
  String category = 'Category';
  String brand = 'Fish Category';
  String from = 'From';
  bool offer = false;
  File? selectedImage;
  File? postImage;
  String gender = 'male';

  //List of Products Add and Show
  List<Product> products = [];
  List<Product> productShowInUi = [];
  //List of Products Cart and Show
  List<Product> cart = [];
  List<Product> cartShowInUi = [];
  //List of Products categories
  List<ProductCategory> productCategories = [];
  //List of Loging details and Show
  List<LogDetails> logdetails = [];
  List<LogDetails> logShowUi = [];
  List<Users> usersShow = [];
  //List of Chat details and Show
  List<ChatDetails> chatdetails = [];
  List<ChatDetails> makePostUi = [];
  //List of Post create and Show
  List<PostDetails> postdetails = [];
  List<PostDetails> postShowUi = [];
  //List of Message send and Show
  List<Message> message = [];
  List<Message> messageUi = [];
  //List of Seller Message send and Show
  List<SellerMessage> sellermessage = [];
  List<SellerMessage> sellermessageUi = [];

  // Notify about loging details
  void handleDateSelection(DateTime selectedDate) {
    logday = selectedDate;
    update(); // Notify listeners about the change
  }

  // Initiate the database collections and Fetch the data
  @override
  void onInit() async {
    // TODO: implement onInit
    productCollection = firestore.collection('product');
    categoryCollection = firestore.collection('category');
    logdetailsCollection = firestore.collection('logdetails');
    chatlogCollection = firestore.collection('chatlogdetails');
    postdetailsCollection = firestore.collection('postdetails'); //postShowUi
    messageCollection = firestore.collection('message');
    cartCollection = firestore.collection('cart');
    usersCollection = firestore.collection('Users');
    sellermessageCollection = firestore.collection('sellermessage');
    await fetchCategory();
    await fetchProducts();
    await fetchPostDetails();
    await fetchPostsList();
    await fetchSellerMessage();
    await fetchUserDetails();
    super.onInit();
  }

  // Add chats into chatlogs
  addChat(File? selectedImage) async {
    try {
      if (selectedImage == null) {
        Get.snackbar('Error', 'Please select an image', colorText: Colors.red);
        return;
      }

      final imagePath = 'profpic/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference storageReference = storage.ref().child(imagePath);

      // Specify content type as 'image/jpeg'
      final metadata = SettableMetadata(contentType: 'image/jpeg');

      await storageReference.putFile(selectedImage, metadata);
      final String imageUrl = await storageReference.getDownloadURL();

      final DocumentReference doc = chatlogCollection.doc();
      final ChatDetails chatdetails = ChatDetails(
        id: doc.id,
        fullName: '${fNameController.text} ${lNameController.text}',
        birthDay: birthday,
        gender: gender,
        image: imageUrl, // Add this field to your ChatDetails model
      );

      final Map<String, dynamic> chatdetailsJson = chatdetails.toJson();
      await doc.set(chatdetailsJson);

      Get.snackbar('Success', 'Log added successfully', colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  // Add Post into postdetails collection
  DateTime now = DateTime.now();
  addPost(File? selectedImage, String filetype, String? useremail) async {

    try {
      if (selectedImage == null) {
        Get.snackbar('Error', 'Please select an image', colorText: Colors.red);
        return;
      }

      final imagePath = 'post/ashenfdbd${DateTime.now().millisecondsSinceEpoch}';
      final Reference storageReference = storage.ref().child(imagePath);

      // Specify content type as 'image/jpeg'
      final metadata = SettableMetadata(contentType: filetype);

      await storageReference.putFile(selectedImage, metadata);
      final String imageUrl = await storageReference.getDownloadURL();

      final DocumentReference doc = postdetailsCollection.doc();
      final PostDetails postdetails = PostDetails(
        id: doc.id,
        description: challengeDescriptionCtrl.text,
        filetype: filetype,
        image: imageUrl, // Add this field to your ChatDetails model
        from: from,
        title: challengeTitleCtrl.text,
        email: useremail,
        createDay: DateTime.now()
      );

      final Map<String, dynamic> postdetailsJson = postdetails.toJson();
      await doc.set(postdetailsJson);

      Get.snackbar('Success', 'Post added successfully', colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  // Add Seller messages into seller message collection
  addSellerMessage(){
    try {
      int pressingTime = DateTime.now().toUtc().millisecondsSinceEpoch;
      DocumentReference doc = sellermessageCollection.doc('$pressingTime');
      SellerMessage message = SellerMessage(
          id:doc.id,
          message:sellerMessageController.text,
          pressingTime: DateTime.now().toUtc().millisecondsSinceEpoch,
      );
      final messageJson = message.toJson();
      doc.set(messageJson);
      // Get.snackbar('Success', 'Message added successfully', colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  // Add messages into message collection
  addMessage( String uid){
    CollectionReference messageColl = FirebaseFirestore.instance.collection(uid);
    try {
      int pressingTime = DateTime.now().toUtc().millisecondsSinceEpoch;
      DocumentReference doc = messageColl.doc('$pressingTime');
      Message message = Message(
        id:doc.id,
        message:messageController.text,
        pressingTime: DateTime.now().toUtc().millisecondsSinceEpoch,
      );
      final messageJson = message.toJson();
      doc.set(messageJson);
      // Get.snackbar('Success', 'Message added successfully', colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  // Add log details into logdetails collection
  addLogDetails(String UID){
    CollectionReference logColl = FirebaseFirestore.instance.collection('logdetails${UID}');
    try {
      DocumentReference doc = logColl.doc();
      LogDetails logindetails = LogDetails(
        id:doc.id,
        name:fishNameCtrl.text,
        method: fishingMethodCtrl.text,
        lat: lat,
        long: long,
        quantity: fishQuantityCtrl.text,
        date: logday
      );
      final logindetailsJson = logindetails.toJson();
      doc.set(logindetailsJson);
      Get.snackbar('Success', 'Log added successfully', colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  // Add cart details into cart collection
  addCart(int index){
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference cartColl = FirebaseFirestore.instance.collection('cart${user?.uid}');
    try {
      DocumentReference doc = cartColl.doc();
      Product product = Product(
        id:doc.id,
        name:productShowInUi[index].name,
        category: category,
        description: productDescriptionCtrl.text,
        price: double.tryParse(productShowInUi[index].price.toString()),
        brand: brand,
        image: productShowInUi[index].image,
        offer: offer,
      );
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', 'Cart added successfully', colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  // Add product details into product collection
  addProduct(File? selectedImage, String filetype)async{
    try {
      if (selectedImage == null) {
        Get.snackbar('Error', 'Please select an image', colorText: Colors.red);
        return;
      }
      final imagePath = 'product/product${DateTime.now().millisecondsSinceEpoch}';
      final Reference storageReference = storage.ref().child(imagePath);

      // Specify content type as 'image/jpeg'
      final metadata = SettableMetadata(contentType: filetype);

      await storageReference.putFile(selectedImage, metadata);
      final String imageUrl = await storageReference.getDownloadURL();
      DocumentReference doc = productCollection.doc();
      Product product = Product(
            id:doc.id,
            name:productNameCtrl.text,
            category: category,
            description: productDescriptionCtrl.text,
            price: double.tryParse(productPriceCtrl.text),
            brand: brand,
            image: imageUrl,
            offer: offer,
          );
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', 'Product added successfully', colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  // Set the values to default values
  setValuesDefault(){
    productNameCtrl.clear();
    productPriceCtrl.clear();
    productDescriptionCtrl.clear();
    productImgCtrl.clear();
    category = 'Category';
    brand = 'Fish Category';
    offer = false;
    update();
  }

  // Fetch the cart details from cart details collection
  fetchCartDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference cartColl = FirebaseFirestore.instance.collection('cart${user?.uid}');
    try {
      QuerySnapshot cartdetailsSnapshot = await cartColl.get();
      final List<Product> retrievedLog = cartdetailsSnapshot.docs.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>)).toList();
      cart.clear();
      cart.assignAll(retrievedLog);
      cartShowInUi.assignAll(cart);
      Get.snackbar('Success', 'CartDetails fetch successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally{
      update();
    }
  }

  // Fetch the log details from log details collection
  fetchLogDetails(String UID) async {
    CollectionReference logColl = FirebaseFirestore.instance.collection('logdetails${UID}');
    try {
      QuerySnapshot logdetailsSnapshot = await logColl.get();
      final List<LogDetails> retrievedLog = logdetailsSnapshot.docs.map((doc) => LogDetails.fromJson(doc.data() as Map<String, dynamic>)).toList();
      logdetails.clear();
      logdetails.assignAll(retrievedLog);
      logShowUi.assignAll(logdetails);
      Get.snackbar('Success', 'LogDetails fetch successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally{
      update();
    }
  }

  fetchUserDetails() async {
    try {
      QuerySnapshot usertailsSnapshot = await usersCollection.get();
      final List<Users> retrievedUsers = usertailsSnapshot.docs.map((doc) => Users.fromJson(doc.data() as Map<String, dynamic>)).toList();
      usersShow.assignAll(retrievedUsers);
      Get.snackbar('Success', 'Users fetch successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally{
      update();
    }
  }

  // Fetch the seller messages from seller messages collection
  fetchSellerMessage() async {
    try {
      QuerySnapshot messageSnapshot = await sellermessageCollection.get();
      final List<SellerMessage> retrievedMessage = messageSnapshot.docs.map((doc) => SellerMessage.fromJson(doc.data() as Map<String, dynamic>)).toList();
      sellermessage.clear();
      sellermessage.assignAll(retrievedMessage);
      sellermessageUi.assignAll(sellermessage);
      // Get.snackbar('Success', 'Message fetch successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally{
      update();
    }
  }

  // Fetch the messages from message collection
  fetchMessage(String uid) async {
    CollectionReference messageColl = FirebaseFirestore.instance.collection(uid);
    try {
      QuerySnapshot messageSnapshot = await messageColl.get();
      final List<Message> retrievedMessage = messageSnapshot.docs.map((doc) => Message.fromJson(doc.data() as Map<String, dynamic>)).toList();
      message.clear();
      message.assignAll(retrievedMessage);
      messageUi.assignAll(message);
      // Get.snackbar('Success', 'Message fetch successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally{
      update();
    }
  }

  // Fetch the post details from post details collection
  fetchPostDetails() async {
    try {
      QuerySnapshot chatSnapshot = await chatlogCollection.get();
      final List<ChatDetails> retrievedChats = chatSnapshot.docs.map((doc) => ChatDetails.fromJson(doc.data() as Map<String, dynamic>)).toList();
      chatdetails.clear();
      chatdetails.assignAll(retrievedChats);
      makePostUi.assignAll(chatdetails);
      Get.snackbar('Success', 'Post details fetch successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally{
      update();
    }
  }

  // Fetch the products details from the product details collection
  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>)).toList();
      products.clear();
      products.assignAll(retrievedProducts);
      productShowInUi.assignAll(products);
      Get.snackbar('Success', 'Product fetch successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally{
      update();
    }
  }

  // Fetch the post details from the post details collection
  fetchPostsList() async{
    try {
      QuerySnapshot postSnapshot = await postdetailsCollection.get();
      final List<PostDetails> retrievedPost = postSnapshot.docs.map((doc) => PostDetails.fromJson(doc.data() as Map<String, dynamic>)).toList();
      postdetails.clear();
      postdetails.assignAll(retrievedPost);
      postShowUi.assignAll(postdetails);
      Get.snackbar('Success', 'Post fetch successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally{
      update();
    }
  }

  // Fetch item categories
  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<ProductCategory> retrievedCategories = categorySnapshot.docs.map((doc) =>
          ProductCategory.fromJson(doc.data() as Map<String, dynamic>)).toList();
      productCategories.clear();
      productCategories.assignAll(retrievedCategories);
      Get.snackbar('Success', 'Category fetch successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally{
      update();
    }
  }

  // Category filters
  filterByCategory(String category){
    productShowInUi.clear();
    productShowInUi = products.where((product) => product.category == category).toList();
    update();
  }

  // Brand category
  filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      productShowInUi = products.toList(); // Convert the iterable to a list
    } else {
      List<String> lowerCaseBrands = brands.map((brand) => brand.toLowerCase()).toList();
      productShowInUi = products.where((product) => lowerCaseBrands.contains(product.brand?.toLowerCase() ?? '')).toList();
    }
    update();
  }

  // Sort by price
  sortByPrice({required bool ascending}){
    List<Product> sortedProducts = List<Product>.from(productShowInUi);
    sortedProducts.sort((a,b) => ascending ? a.price!.compareTo(b.price!) : b.price!.compareTo(a.price!));
    productShowInUi = sortedProducts;
    update();
  }

  // Delete the products from database
  deleteProduct(String id) async {
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  deleteLog(String id, String UID) async {
    CollectionReference logColl = FirebaseFirestore.instance.collection('logdetails${UID}');
    try {
      await logColl.doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  testMethod(){
  }
}