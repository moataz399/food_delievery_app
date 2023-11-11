import 'package:food_delievery_app/constants/strings.dart';
import 'package:food_delievery_app/data/api/api_client.dart';
import 'package:food_delievery_app/models/signup_model.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/address_model.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressFromGeoCode(LatLng latLng) async {
    return await apiClient.getData('${AppStrings.geoCode_Uri}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  getUserAddress() {
    return sharedPreferences.getString(AppStrings.userAddress) ?? "";
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(
        AppStrings.addUserAddress, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppStrings.AddressListUri);
  }

  Future<bool> saveUserAddress(String address) async {
    apiClient.updateHeader(sharedPreferences.getString(AppStrings.TOKEN)!);
    return await sharedPreferences.setString(AppStrings.userAddress, address);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData("${AppStrings.zone_uri}?lat=$lat&lng=$lng");
  }

  Future<Response> searchLocation(String text)async{
    
    return await apiClient.getData('${AppStrings.search_location_uri}?search_text=$text');
  }


  Future<Response> setLocation(String placeId)async{

    return await apiClient.getData('${AppStrings.place_details_uri}?placeid=$placeId');
  }
}
