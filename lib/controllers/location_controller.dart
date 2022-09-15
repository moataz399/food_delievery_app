import 'dart:convert';
import 'dart:core';

import 'package:food_delievery_app/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../data/repository/location_repo.dart';
import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  late Position _position;
  late Position _pickPosition;

  Placemark _placeMark = Placemark();

  Placemark _pickPlaceMark = Placemark();

  Placemark get placeMark => _placeMark;

  Placemark get pickPlaceMark => _pickPlaceMark;

  List<AddressModel> _addressList = [];

  List<AddressModel> get addressList => _addressList;

  late List<AddressModel> _allAddressList;

  List<AddressModel> get allAddressList => _allAddressList;

  List<String> _addressTypeList = ['home', 'office', 'others'];

  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;

  int get addressTypeIndex => _addressTypeIndex;
  bool _updateAddressData = true;

  bool _changeAddress = true;

  bool _serviceLoading = false;

  bool _inZone = false;

  bool _buttonDisabled = true;

  bool get serviceLoading => _serviceLoading;

  bool get inZone => _inZone;

  bool get buttonDisabled => _buttonDisabled;

  late GoogleMapController _mapController;

  GoogleMapController get mapController => _mapController;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Position get position => _position;

  Position get pickPosition => _pickPosition;

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _isLoading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        }
        ResponseModel _responseModel = await getZone(
            position.target.latitude.toString(),
            position.target.longitude.toString(),
            false);
        _buttonDisabled = !_responseModel.isSuccess;
        if (_changeAddress) {
          String _address = await getAddressFromGeoCode(
              LatLng(position.target.latitude, position.target.longitude));

          fromAddress
              ? _placeMark = Placemark(name: _address)
              : _pickPlaceMark = Placemark(name: _address);
        }
      } catch (e) {
        print(e.toString());
      }
      _isLoading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  Future<String> getAddressFromGeoCode(LatLng latLng) async {
    String address = 'unknown Location  found';
    Response response = await locationRepo.getAddressFromGeoCode(latLng);
    if (response.body['status'] == "OK") {
      print(response.statusCode);
      address = response.body['results'][0]['formatted_address'].toString();
    } else {
      print('error getting google api ');
      print(response.statusCode);
    }
    update();
    return address;
  }

  late Map<String, dynamic> _getAddress;

  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());

    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e.toString());
    }
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _isLoading = true;

    update();
    Response response = await locationRepo.addAddress(addressModel);

    ResponseModel responseModel;
    if (response.statusCode == 200) {
      getAddressList();
      String msg = response.body['message'];
      responseModel = ResponseModel(true, msg);

      await saveUserAddress(addressModel);
    } else {
      print('failed to save user address' + response.statusText!);

      responseModel = ResponseModel(true, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];

      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());

    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _placeMark = _pickPlaceMark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _isLoading = true;
    } else {
      _serviceLoading = true;
    }
    update();

    Response response = await locationRepo.getZone(lat, lng);
    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel = ResponseModel(true, response.body['zone_id'].toString());
    } else {
      _inZone = false;

      _responseModel = ResponseModel(true, response.statusText!);
    }

    if (markerLoad) {
      _isLoading = false;
    } else {
      _serviceLoading = false;
    }
    print('zone response code is '+ response.statusCode.toString());
    update();
    return _responseModel;
  }
}
