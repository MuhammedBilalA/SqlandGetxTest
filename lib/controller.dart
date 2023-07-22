import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_test/model.dart';
import 'package:sql_test/sql_functions.dart';

class DetailsController extends GetxController {
  String? name;
  String? age;
  List<DetailsModel> detailsList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController editingNameController = TextEditingController();
  TextEditingController editingAgeController = TextEditingController();

  saveDetails({required String name, required String age}) async {
    DetailsModel detailsModel = DetailsModel(age: age, name: name);
    // detailsList.add(detailsModel);
    await Get.find<SqlFunctions>().addDetails(detailsModel);
    update();
  }

  editDetails(String name, String age, int id) async {
    await Get.find<SqlFunctions>().editStudent(name, age, id);
    update();
  }

  deleteDetails(DetailsModel data) async {
    await Get.find<SqlFunctions>().deleteDetails(data.id!);
    update();
  }
}

class ControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(() => DetailsController());
    Get.lazyPut<SqlFunctions>(() => SqlFunctions());

    // Get.put(DetailsController());
    // Get.put(SqlFunctions());
  }
}
