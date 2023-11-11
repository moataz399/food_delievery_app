import 'package:flutter/material.dart';
import 'package:food_delievery_app/base/custom_button.dart';
import 'package:food_delievery_app/controllers/location_controller.dart';
import 'package:food_delievery_app/presentation/widgets/search_location_dialogue_page.dart';
import 'package:food_delievery_app/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../app_router.dart';
import '../../../utils/colors.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromAddress;
  final bool fromSignUp;
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {Key? key,
      required this.fromAddress,
      required this.fromSignUp,
      this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late CameraPosition _cameraPosition;
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = const LatLng(45.417540, -122.814444);

      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 12);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(
                Get.find<LocationController>().getAddress['longitude']));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 12);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SizedBox(
                  width: double.maxFinite,
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: _initialPosition, zoom: 12),
                        zoomControlsEnabled: false,
                        onCameraMove: (CameraPosition position) {
                          _cameraPosition = position;
                        },
                        onCameraIdle: () {
                          Get.find<LocationController>()
                              .updatePosition(_cameraPosition, false);
                        },
                        onMapCreated: (GoogleMapController mapController) {
                          _mapController = mapController;
                        },
                      ),
                      Center(
                          child: !locationController.isLoading
                              ? Image.asset(
                                  'assets/images/marker.png',
                                  height: 50,
                                  width: 50,
                                )
                              : const CircularProgressIndicator()),
                      Positioned(
                        top: Dimensions.height45,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        child: InkWell(
                          onTap: () {
                            Get.dialog(LocationDialogue(
                                mapController: _mapController));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width10),
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius20 / 2),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 25,
                                  color: AppColors.yellowColor,
                                ),
                                Expanded(
                                  child: Text(
                                      locationController.pickPlaceMark.name ??
                                          "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Dimensions.iconsSize16),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                Icon(
                                  Icons.search,
                                  color: AppColors.yellowColor,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        child: locationController.serviceLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomButton(
                                buttonText: locationController.inZone
                                    ? widget.fromAddress
                                        ? 'pick address'
                                        : "pick location"
                                    : 'service is not available in your area ',
                                onPressed: (locationController.buttonDisabled ||
                                        locationController.isLoading)
                                    ? null
                                    : () {
                                        if (locationController
                                                    .pickPosition.latitude !=
                                                0 &&
                                            locationController
                                                    .pickPlaceMark.name !=
                                                null) {
                                          if (widget.fromAddress) {
                                            if (widget.googleMapController !=
                                                null) {
                                              print('now u can click this');

                                              widget.googleMapController!.moveCamera(
                                                  CameraUpdate.newCameraPosition(
                                                      CameraPosition(
                                                          target: LatLng(
                                                              locationController
                                                                  .pickPosition
                                                                  .latitude,
                                                              locationController
                                                                  .pickPosition
                                                                  .longitude))));
                                              locationController
                                                  .setAddAddressData();
                                            }
                                            Get.back();
                                            //   Get.toNamed(AppRouter.getAddressPage());
                                          }
                                        }
                                      },
                              ),
                      )
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }
}
