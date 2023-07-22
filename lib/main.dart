import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_test/controller.dart';
import 'package:sql_test/sql_functions.dart';
import 'package:sql_test/widgets/custom_textformfield.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ControllerBinding().dependencies();
  await Get.find<SqlFunctions>().initializeDatabase();
  await Get.find<SqlFunctions>().getAllData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SqlTest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // initialBinding: ControllerBinding(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = Get.find<DetailsController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          'SQL Test',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: GetBuilder(
            init: detailsController,
            builder: (controller) {
              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: 235,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextFormField(
                            textEditingController: controller.nameController,
                            textInputType: TextInputType.emailAddress,
                            text: 'Name'),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                            textEditingController: controller.ageController,
                            textInputType: TextInputType.number,
                            text: 'Age'),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await controller.saveDetails(
                                name: controller.nameController.text,
                                age: controller.ageController.text);
                            controller.ageController.clear();
                            controller.nameController.clear();
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 580,
                    // color: Colors.red,
                    child: ListView.separated(
                        // physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding:
                                EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            tileColor: Color.fromARGB(217, 255, 240, 109),
                            title: Text(controller.detailsList[index].name),
                            subtitle: Text(controller.detailsList[index].age),
                            trailing: Container(
                              width: 100,
                              // color: Colors.red,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        // controller.editDetails(controller.detailsList[index]);
                                        controller.editingAgeController.text =
                                            controller.detailsList[index].age;
                                        controller.editingNameController.text =
                                            controller.detailsList[index].name;
                                        Get.dialog(AlertDialog(
                                          title: const Center(child: Text('Editing Screen')),
                                          content: Container(
                                            height: 200,
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                CustomTextFormField(
                                                    textEditingController:
                                                        controller.editingNameController,
                                                    textInputType: TextInputType.emailAddress,
                                                    text: 'Name'),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                CustomTextFormField(
                                                    textEditingController:
                                                        controller.editingAgeController,
                                                    textInputType: TextInputType.number,
                                                    text: 'Age'),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          log(controller.detailsList[index].id
                                                              .toString());

                                                          Get.back();
                                                        },
                                                        child: const Text('Cancel')),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          await Get.find<DetailsController>()
                                                              .editDetails(
                                                                  controller
                                                                      .editingNameController.text,
                                                                  controller
                                                                      .editingAgeController.text,
                                                                  controller
                                                                      .detailsList[index].id!);

                                                          Get.back();
                                                        },
                                                        child: const Text('Save'))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        controller.deleteDetails(controller.detailsList[index]);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: controller.detailsList.length),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
