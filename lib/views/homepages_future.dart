import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testimpack/models/user_list_model.dart';
import 'package:testimpack/services/api_services.dart';
import 'package:testimpack/views/details_page.dart';

class FutureHomepages extends StatefulWidget {
  const FutureHomepages({Key? key}) : super(key: key);

  @override
  State<FutureHomepages> createState() => _FutureHomepagesState();
}

class _FutureHomepagesState extends State<FutureHomepages> {
  var isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 120,
                color: Colors.amber,
                child: Column(
                  children: [
                    const Text(
                      'Ativities',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isOpen = true;
                            });
                          },
                          child: SizedBox(
                            width: Get.width / 3,
                            height: Get.height / 15,
                            child: Card(
                              color:
                                  (isOpen) ? Colors.orangeAccent : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                'Open',
                                style: TextStyle(
                                  color:
                                      (!isOpen) ? Colors.black : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isOpen = false;
                            });
                          },
                          child: SizedBox(
                            width: Get.width / 3,
                            height: Get.height / 15,
                            child: Card(
                              color: (!isOpen)
                                  ? Colors.orangeAccent
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                'Completed',
                                style: TextStyle(
                                  color:
                                      (!isOpen) ? Colors.white : Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              (isOpen)
                  ? SizedBox(
                      height: Get.height / 1.2,
                      child: FutureBuilder<List<UserList>>(
                          future: ApiServices().getListData(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            var data = snapshot.data;
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (data[index].complete == "0") {
                                    return Container();
                                  } else {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 200,
                                          height: 100,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(() => DetailsPage(
                                                  id: data[index].id));
                                            },
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    DateFormat('yyyy - MM - dd')
                                                        .format(
                                                            data[index].when!),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
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
                                                        DateFormat(
                                                                'hh : mm aaa')
                                                            .format(data[index]
                                                                .when!),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 30,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width / 3,
                                                        child: Text(
                                                          '${data[index].activityType!} with ${data[index].institution!}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                                  }
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    )
                  : SizedBox(
                      height: Get.height / 1.2,
                      child: FutureBuilder<List<UserList>>(
                          future: ApiServices().getListData(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            var data = snapshot.data;
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (data[index].complete != "0") {
                                    return Container();
                                  } else {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 200,
                                          height: 100,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(() => DetailsPage(
                                                  id: data[index].id));
                                            },
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    DateFormat('yyyy - MM - dd')
                                                        .format(
                                                            data[index].when!),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
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
                                                        DateFormat(
                                                                'hh : mm aaa')
                                                            .format(data[index]
                                                                .when!),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 30,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width / 3,
                                                        child: Text(
                                                          '${data[index].activityType!} with ${data[index].institution!}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ));
                                  }
                                },
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ));
  }
}
