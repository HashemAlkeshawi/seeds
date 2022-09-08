import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seeds/app_router.dart';
import 'package:seeds/data/Seeds_api/dio_helper.dart';
import 'package:seeds/modules/category.dart';
import 'package:seeds/modules/customer.dart';
import 'package:seeds/modules/meal.dart';
import 'package:seeds/modules/reservation.dart';
import 'package:seeds/screens/auth/verficationCode.dart';
import 'package:seeds/screens/home.dart';
import 'package:seeds/widgets/error_face.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeedsProvider extends ChangeNotifier {
  Customer? theCustomer;
  SeedsProvider() {
    setSharedPreferences();
    checkUserStatus();
    getAllCategories();
    getPopularMeals();
  }
  refreshAll() async {
    await checkUserStatus();
    await getAllCategories();
    await getPopularMeals();
  }

  SharedPreferences? sharedPreferences;
  setSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();

    notifyListeners();
  }

  bool isLoggedIn = false;
  checkUser() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences!.getBool('logedin') ?? true) {
      log('before getUser in checkUser');
      await getUser();
      isLoggedIn = true;
      notifyListeners();
      log('user login status is: ${sharedPreferences!.getBool('logedin')!}');
      return true;
    } else {
      log('in else => logedin = false');
      userStatus = 0;
      isLoggedIn = false;
      notifyListeners();
      return false;
    }
    // }
  }

  getCustomer(String? phoneNumber) async {
    log('in getCustomer before dio');
    await DioHelper.dioHelper.getCustomer(phoneNumber!);

    log('in getCustomer after  dio');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('phoneNumber', phoneNumber);
    await sharedPreferences.setBool('logedin', true);
  }

  getUser() async {
    String phoneNumber = sharedPreferences!.getString('phoneNumber') ?? '';
    await DioHelper.dioHelper.getCustomer(phoneNumber);
    theCustomer =
        Customer.fromMap(jsonDecode(sharedPreferences!.getString('customer')!));
    notifyListeners();
    log('the customer name is: ${theCustomer!.fullName}');
  }

  int? userStatus;
  int? userReservationStatus;
  FloatingActionButtonLocation flal = FloatingActionButtonLocation.centerFloat;

  checkUserStatus() async {
    if (await checkUser()) {
      userStatus = theCustomer!.status;
      userReservationStatus = theCustomer!.isReserved;
      userReservationStatus! == 1
          ? flal = FloatingActionButtonLocation.centerDocked
          : flal = FloatingActionButtonLocation.centerFloat;
      await getReservationDetials();
    }
    log('User status is False');
  }

  List<Category> categories = [];
  List<Meal> meals = [];
  List<Meal> popularMeals = [];

  getAllCategories() async {
    categories = await DioHelper.dioHelper.getAllCategories();
    notifyListeners();
  }

  getMeals(int categoryId) async {
    meals = await DioHelper.dioHelper.getMeals(categoryId);
    notifyListeners();
  }

  getPopularMeals() async {
    popularMeals = await DioHelper.dioHelper.getPopularMeals();
    notifyListeners();
  }

  File? profileImage;

  TextEditingController nameCreation = TextEditingController();
  String? phoneNumber;
  selectImage(ImageSource source) async {
    XFile? image;
    image = await ImagePicker().pickImage(source: source);
    profileImage = File(image!.path);
    notifyListeners();
  }

  addUser() async {
    log('add User');
    User user = FirebaseAuth.instance.currentUser!;
    String imageUrl =
        await DioHelper.dioHelper.uploadImage(profileImage ?? File(''));
    Customer customer = Customer(
      id: user.uid,
      fullName: nameCreation.text,
      imageUrl: imageUrl,
      phone: user.phoneNumber!,
      status: 0,
    );
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('phoneNumber', customer.phone);
    await sharedPreferences.setBool('logedin', true);
    await DioHelper.dioHelper.addCustomer(customer);

    await sharedPreferences.setString('customer', jsonEncode(customer.toMap()));
  }

  verifyPhoneNumberCreation(String phoneNumberr,
      {int? forceResendingToken}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      forceResendingToken: forceResendingToken,
      phoneNumber: phoneNumberr,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        log('create account');
        await addUser();

        AppRouter.navigateWithReplacemtnToWidget(Home());
        checkUserStatus();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('timout');
      },
      codeSent: (String verificationId, int? forceResendingToken) async {
        AppRouter.navigateWithReplacemtnToWidget(
            verficationCode(verificationId, forceResendingToken, phoneNumberr));
      },
      verificationFailed: (FirebaseAuthException error) {
        AppRouter.navigateWithReplacemtnToWidget(errorFace());

        log(error.toString());
      },
    );
  }

  upDateCustomer() async {
    Customer newCustomer = theCustomer!;
    newCustomer.status = 1;
    await DioHelper.dioHelper.upDateCustomer(newCustomer);
    await checkUserStatus();
    notifyListeners();
  }

  checkCustomer() async {
    bool check = await DioHelper.dioHelper.checkCustomer(phoneNumber!);
    if (check) {
      logIn(phoneNumber!);
    }
    phoneNumber = '';
    return check;
  }

  logIn(String phoneNumber, {int? forceResendingToken}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      forceResendingToken: forceResendingToken,
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString('phoneNumber', phoneNumber);
        await sharedPreferences.setBool('logedin', true);
        log('in the verification completed');
        await checkUserStatus();
        AppRouter.navigateWithReplacemtnToWidget(Home());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('timout');
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        AppRouter.navigateWithReplacemtnToWidget(verficationCode(
          verificationId,
          forceResendingToken,
          phoneNumber,
        ));
      },
      verificationFailed: (FirebaseAuthException error) {
        AppRouter.navigateWithReplacemtnToWidget(errorFace());

        log(error.toString());
      },
    );
  }

  signOut() async {
    sharedPreferences!.setBool('logedin', false);
    checkUserStatus();
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

//// Reservation corner/////
  ///
  ///

  int numberOfGuests = 1;
  addGuest() {
    numberOfGuests = numberOfGuests + 1;
    notifyListeners();
  }

  deleteGuest() {
    numberOfGuests = numberOfGuests == 1 ? 1 : numberOfGuests - 1;
    notifyListeners();
  }

  DateTime? reservationDate;

  setReservationDate(DateTime? date) {
    reservationDate = date!;
    notifyListeners();
    getReservedTables(date);
  }

  List<int> reservedTables = [];
  getReservedTables(DateTime date) async {
    reservedTables = await DioHelper.dioHelper.getReservedTables(date);
    notifyListeners();
  }

  isReserved(int table) {
    return reservedTables.contains(table);
  }

  int? selectedTable;
  selectTable(int tableNo) {
    selectedTable = tableNo;
    notifyListeners();
  }

  resetReservationState() {
    selectedTable = null;
    reservationDate = null;
    numberOfGuests = 1;
  }

  Reservation createReservation() {
    Reservation reservation = Reservation(
        customerId: theCustomer!.id,
        tableId: selectedTable.toString(),
        guest: numberOfGuests,
        reservedDate: reservationDate!);
    return reservation;
  }

  submitReservationRequist() async {
    Reservation reservation = createReservation();
    Customer newCustomer = theCustomer!;
    newCustomer.isReserved = 1;
    await DioHelper.dioHelper
        .submitReservationRequist(reservation, newCustomer);
    await checkUserStatus();
  }

  Reservation? reservation;
  getReservationDetials() async {
    reservation =
        await DioHelper.dioHelper.getReservationDetails(theCustomer!.id);
    notifyListeners();
  }

  deleteReservation(String reservationId) async {
    await DioHelper.dioHelper.deleteReservation(reservationId);
    await checkUserStatus();
  }
}
