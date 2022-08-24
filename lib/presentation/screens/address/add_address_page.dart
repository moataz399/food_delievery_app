import 'package:flutter/material.dart';
import 'package:food_delievery_app/controllers/auth_controller.dart';
import 'package:food_delievery_app/controllers/location_controller.dart';
import 'package:food_delievery_app/controllers/user_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/colors.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactpersonName = TextEditingController();
  TextEditingController _contactpersonNumber = TextEditingController();

  late bool _isLogged;
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(45.51563, -122.677), zoom: 17);

  late LatLng _initialPosition = LatLng(45.51563, -122.677);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      ));

      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address page'),
        backgroundColor: AppColors.mainColor,
      ),
      body: Column(
        children: [
          Container(
            height: 140,
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                )),
            child: Stack(
              children: [
              GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 17)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
