import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testimpack/models/user_details_model.dart';
import 'package:testimpack/services/api_services.dart';
import 'package:testimpack/views/edit_activities.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({Key? key, required this.id}) : super(key: key);

  String? id;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController notesCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          'Activity Info',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<UserDetails>(
        future: ApiServices().getIdData(widget.id!),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var detailsData = snapshot.data;
          if (detailsData != null) {
            var date = DateFormat('yyyy - MM - dd').format(detailsData.when);
            var time = DateFormat('hh : mm aaa').format(detailsData.when!);

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: Get.width / 1.2,
                      height: Get.height / 4,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${detailsData.activityType} with ${detailsData.institution} at $date & $time',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: Get.width / 1.1,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Get.to(
                                          () => EditActivities(id: widget.id));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.amber,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    child: const Text(
                                      'Edit Activity',
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 1.2,
                      height: Get.height / 3,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'What is the result?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: SizedBox(
                                  width: Get.width / 1,
                                  height: Get.height / 8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: notesCont,
                                      maxLines: 10,
                                      keyboardType: TextInputType.multiline,
                                      decoration:
                                          const InputDecoration.collapsed(
                                        hintText: 'put your reason here',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: Get.width / 1.1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    ApiServices()
                                        .completeActivities(widget.id!);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.amber,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: const Text(
                                    'Complete Activity',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
