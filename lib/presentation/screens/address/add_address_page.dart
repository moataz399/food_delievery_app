import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/app_router.dart';
import 'package:food_delievery_app/controllers/auth_controller.dart';
import 'package:food_delievery_app/controllers/location_controller.dart';
import 'package:food_delievery_app/controllers/user_controller.dart';
import 'package:food_delievery_app/models/address_model.dart';
import 'package:food_delievery_app/presentation/screens/address/pick_address_map.dart';
import 'package:food_delievery_app/presentation/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../widgets/text_field.dart';

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
      CameraPosition(target: LatLng(45.417540, -122.814444), zoom: 17);

  late LatLng _initialPosition = LatLng(45.417540, -122.814444);

  @override
  void initState() {
    super.initState();

    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }

      Get.find<LocationController>().getUserAddress();

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
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (_contactpersonName.text.isEmpty) {
            _contactpersonName.text = userController.userModel.name;
            _contactpersonNumber.text = userController.userModel.phone;
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }

          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  "${locationController.placeMark.name ?? ''}"
                  "${locationController.placeMark.locality ?? ''}"
                  "${locationController.placeMark.postalCode ?? ''}"
                  "${locationController.placeMark.country ?? ''}";
              print('address in my view is ${_addressController.text}');
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      margin: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: AppColors.mainColor,
                          )),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 12),
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onTap: (latlng) {
                              Get.toNamed(AppRouter.getPickAddressPage(),
                                  arguments: PickAddressMap(
                                      fromAddress: true,
                                      fromSignUp: false,
                                      googleMapController:
                                          locationController.mapController));
                            },
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition = position),
                            onMapCreated: (GoogleMapController mapController) {
                              locationController
                                  .setMapController(mapController);
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                locationController.addressTypeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    locationController
                                        .setAddressTypeIndex(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width20,
                                        vertical: Dimensions.height10),
                                    margin: EdgeInsets.only(
                                        right: Dimensions.width10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20 / 4),
                                        color: Theme.of(context).cardColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey[200]!,
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                          ),
                                        ]),
                                    child: Row(
                                      children: [
                                        Icon(
                                            index == 0
                                                ? Icons.home_filled
                                                : index == 1
                                                    ? Icons.work
                                                    : Icons.location_on,
                                            color: locationController
                                                        .addressTypeIndex ==
                                                    index
                                                ? AppColors.mainColor
                                                : Theme.of(context)
                                                    .disabledColor),
                                      ],
                                    ),
                                  ));
                            }),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: 'Delivery Address '),
                    ),
                    SizedBox(height: Dimensions.height20),
                    AppTextField(
                      textEditingController: _addressController,
                      icon: Icons.map,
                      hintText: "Your address",
                      obSecure: false,
                    ),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: 'Contact Name '),
                    ),
                    SizedBox(height: Dimensions.height10),
                    AppTextField(
                      textEditingController: _contactpersonName,
                      icon: Icons.person,
                      hintText: "Your name ",
                      obSecure: false,
                    ),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: ' Your number '),
                    ),
                    SizedBox(height: Dimensions.height10),
                    AppTextField(
                      textEditingController: _contactpersonNumber,
                      icon: Icons.phone,
                      hintText: "Your phone ",
                      obSecure: false,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20)),
                  color: AppColors.buttonBackgroundColor,
                ),
                height: Dimensions.height20 * 6,
                padding: EdgeInsets.only(
                    top: Dimensions.height30,
                    bottom: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          AddressModel addressModel = AddressModel(
                            addressType: locationController.addressTypeList[
                                locationController.addressTypeIndex],
                            address: _addressController.text,
                            contactPersonName: _contactpersonName.text,
                            contactPersonNumber: _contactpersonNumber.text,
                            latitude:
                                locationController.position.latitude.toString(),
                            longitude: locationController.position.longitude
                                .toString(),
                            id: Get.find<UserController>().userModel.id,
                          );

                          locationController
                              .addAddress(addressModel)
                              .then((response) {
                            if (response.isSuccess) {
                              Get.toNamed(AppRouter.getInitial());
                              Get.snackbar('address', 'added successfully');

                              print('address saved ');
                            } else {
                              Get.snackbar('address', 'failed to save address');
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              top: Dimensions.height20,
                              bottom: Dimensions.height20),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: BigText(
                            text: ' save address ',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
