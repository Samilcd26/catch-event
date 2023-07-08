import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threego/Data/Models/gaddress_model.dart';
import 'package:threego/business/services/ILocationService.dart';

import '../../business/services/IAccountService.dart';
import '../../business/services/IOrganizerService.dart';
import '../Models/filter_organizer_model.dart';
import '../Models/organizer_model.dart';
import '../Models/user_model.dart';

class AccountCubit extends Cubit<AccountState> {
  final IAccountService accoundService;
  final IOrganizerService organizerService;
  final ILocationService locationService;
  AccountCubit({required this.accoundService, required this.organizerService, required this.locationService}) : super(AccountInitial());
  //? Variable /////////////////////////////////////////
  bool isLoading = true;
  int userId = 1;
  UserModel? currentUser = UserModel();
  OrganizerModel? currentOrganizer = OrganizerModel();
  bool isUserLogin = false;
  late final SharedPreferences prefs;
  List<OrganizerModel> organizerData = [];
  List<Event>? events = [];
  LatLng? currentLocation;
  Address? currentAddress = Address();
  List<OrganizerModel>? followOrganizerList = [];
  bool changeState = true;
  FilterOrganizerModel filterModel =
      FilterOrganizerModel("Türkiye", "Eskişehir", 1, null, null, null, null, null, null, null, null, null, null, null, null);
//? //////////////////////////////////////////////////////////////////

  //* First Login
  Future<bool> loginUser(String email, String password) async {
    currentUser = await accoundService.loginUser(email, password);
    if (currentUser?.id != null || currentUser != null) {
      prefs.setString("userEmail", email);
      prefs.setString("userPassword", password);
      prefs.setString("token", currentUser!.accessToken!);
      return true;
    } else {
      return false;
    }
  }

//* Logout
  Future<bool> logoutUser() async {
    try {
      await prefs.remove("userEmail");
      await prefs.remove("userPassword");
      await prefs.remove("token");
      return true;
    } catch (e) {
      log('logout: $e');
      return false;
    }
  }

//* user organizer data
  Future<void> _getCurrentOrganizerById() async {
    if (currentUser!.organizer == true) {
      //final data = await accoundService.getCurretnOrganizer(currentUser!.byOrganized!.id!);
      currentOrganizer = currentUser!.byOrganized;
    }

    // emit(SuccesOrganizerData(data));
  }

  //?Sharedpreference open function
  Future<bool> checkLoginUser() async {
    if (!isUserLogin) {
      await checkSharedPreferences();
      String? user_email = prefs.getString("userEmail");
      String? user_Password = prefs.getString("userPassword");
      if (user_email.isNotNullOrNoEmpty && user_Password.isNotNullOrNoEmpty) {
        isUserLogin = await loginUser(user_email!, user_Password!);
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  //?Initialization
  Future<void> initializ() async {
    _changeLoadingStatus();
    await checkSharedPreferences();
    await checkLoginUser();
    if (isUserLogin) {
      await _getCurrentLocation();
      await _getCurrentOrganizerById();
      await getAllOrganizerByFilter();
      await _getFollowOrganizers();
      await _getAllEvent();
      _changeLoadingStatus();
    }
  }

  Future<void> checkSharedPreferences() async {
    try {
      prefs == null ? "" : "";
    } catch (e) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  Future<void> getAllOrganizerByFilter() async {
    final data = await organizerService.getOrganizerByFilter(filterModel);
    organizerData = data!;
  }

  Future<void> _getAllEvent() async {
    events!.clear();
    Future.wait(organizerData.expand((org) => org.event!.map((ev) async => events!.add(ev))));
  }

  Future<void> changeCurrentLocation(LatLng newLocation, Address newAddres) async {
    _changeStateStatus();
    currentLocation = newLocation;
    currentAddress = newAddres;
    filterModel.country = newAddres.country;
    filterModel.city = newAddres.city;
    emit(state);
    initializ();
    _changeStateStatus();
  }

  void _changeLoadingStatus() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }

  void _changeStateStatus() {
    changeState = changeState ? false : true;
    emit(LoginLoadingState(isLoading));
  }

  void toBeOrganizer(int userId) async {
    await accoundService.toBeOrganizer(userId);
  }

  Future<void> _getFollowOrganizers() async {
    if (currentUser!.followOrganizer.isNotNullOrEmpty) {
      final data = await accoundService.getFollowOrganizers(currentUser!.followOrganizer!);
      followOrganizerList = [];
      followOrganizerList = data;
    }
  }

  Future<void> _getCurrentLocation() async {
    final data;
    if (currentLocation == null) {
      data = await organizerService.getCurrentLocation();

      currentLocation = LatLng(data.latitude, data.longitude);
      Results? _data = await locationService.getLocationByCoordinate(currentLocation!);
      var _addressComponent = _data!.addressComponents;
      _addressComponent!.forEach((element) {
        if (element.types!.contains("country")) {
          //!County
          currentAddress!.country = element.longName ?? "";
        } else if (element.types!.contains("postal_code")) {
          //!Postal Code
          currentAddress!.postalCode = element.longName ?? "";
        } else if (element.types!.contains("administrative_area_level_1")) {
          //!City
          currentAddress!.city = element.longName ?? "";
        } else if (element.types!.contains("administrative_area_level_2")) {
          //!District
          currentAddress!.district = element.longName ?? "";
        } else if (element.types!.contains("administrative_area_level_4")) {
          //!District
          currentAddress!.address1 = element.longName ?? "";
        } else if (element.types!.contains("route")) {
          //!District
          currentAddress!.address2 = element.longName ?? "";
        }
      });

      currentAddress!.address1 = _data.formattedAddress;
      currentAddress!.coordinate = Coordinate(latitude: _data.geometry!.location!.lat, longitude: _data.geometry!.location!.lat);

      filterModel.country = currentAddress!.country;
      filterModel.city = currentAddress!.city;
    }
  }
}

abstract class AccountState {}

class AccountInitial extends AccountState {}

class LoginLoadingState extends AccountState {
  bool isLoading;

  LoginLoadingState(this.isLoading);
}
