import 'package:get/get.dart';
import 'package:mero_hostel/models/hostelModel.dart';
import 'package:mero_hostel/models/owner/BookingRequestModel.dart';
import 'package:mero_hostel/repo/owner/ownerHostel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerController extends GetxController {
  bool isDataLoaded = false;
  //RxBool isLoadedRX = false.obs;
  HostelModel? hostelData;
  BookingRequestModel? bookingRequestModel;
  Future<HostelModel?> getOwnerHostel(int userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('AccessToken');
    print(token);
    var response = await OwnerHostelApi().getOwnerHostel(userId, token!);
    isDataLoaded = true;
    hostelData = response;
    update();
    return response;
  }

  Future<BookingRequestModel?> getBookingReq(int userId) async {
    isDataLoaded = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('AccessToken');
    var response = await OwnerHostelApi().getBookingReq(userId, token!);
    bookingRequestModel = response;
    isDataLoaded = true;
    update();
    return response;
  }
}
