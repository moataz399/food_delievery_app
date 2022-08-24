import 'dart:core';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

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
   List<AddressModel> _addressList=[];

  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;

  List<AddressModel> get allAddressList => _allAddressList;

  List<String> _addressTypeList = ['home', 'office', 'others'];

  int _addressTypeIndex = 0;

  late Map<String, dynamic> _getAddress;

  Map get getAddress => _getAddress;
}
