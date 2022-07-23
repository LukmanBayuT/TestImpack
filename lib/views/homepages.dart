import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testimpack/controller/data_controller.dart';
import 'package:intl/intl.dart';
import 'package:testimpack/views/add_pages.dart';
import 'package:testimpack/views/details_page.dart';

class HomePages extends StatelessWidget {
  HomePages({Key? key}) : super(key: key);

  var dataListController = Get.put(DataController());
  var detailsCont = Get.put(DetailsController());
  var isOpenCont = Get.put(IsOpenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddPages());
          },
          backgroundColor: Colors.amber,
          child: const Icon(Icons.add),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height / 10,
                ),
                const SizedBox(
                  child: Text(
                    'Activities',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          isOpenCont.isOpen(true);
                        },
                        child: SizedBox(
                          width: Get.width / 2.5,
                          height: Get.height / 15,
                          child: Card(
                            color: isOpenCont.isOpen.value == true
                                ? Colors.orangeAccent
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'Open',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isOpenCont.isOpen.value == true
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          isOpenCont.isOpen(false);
                        },
                        child: SizedBox(
                          width: Get.width / 2.5,
                          height: Get.height / 15,
                          child: Card(
                            color: isOpenCont.isOpen.value == false
                                ? Colors.orangeAccent
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                'Complete',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isOpenCont.isOpen.value == false
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Obx(() {
            if (isOpenCont.isOpen.value == true) {
              return SizedBox(
                height: Get.height / 1.4,
                child: Obx(() {
                  if (dataListController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: dataListController.userData.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = dataListController.userData[index];
                      return SizedBox(
                        width: Get.width / 1.1,
                        height: Get.height / 8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8, left: 8, right: 8),
                          child: GestureDetector(
                            child: GestureDetector(
                              onTap: () {
                                detailsCont.id.value = data.id!;
                                Get.to(() => DetailsPage(
                                      id: data.id,
                                    ));
                              },
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        const Text(
                                          'Tanggal : ',
                                        ),
                                        Text(
                                          DateFormat('yyyy - MM - dd')
                                              .format(data.when!),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          DateFormat('hh : mm aaa')
                                              .format(data.when!),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                            '${data.activityType!} with ${data.institution!}'),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              );
            } else {
              return Container(color: Colors.amber);
            }
          })
        ],
      ),
    );
  }
}
