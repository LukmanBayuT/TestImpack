import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testimpack/services/api_services.dart';
import 'package:testimpack/views/homepages.dart';

class AddPages extends StatefulWidget {
  AddPages({Key? key}) : super(key: key);

  @override
  State<AddPages> createState() => _AddPagesState();
}

class _AddPagesState extends State<AddPages> {
  TextEditingController notesCont = TextEditingController();
  TextEditingController userCont = TextEditingController();
  TextEditingController whyCont = TextEditingController();

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String dropdownvalue = 'Meeting';

  var items = [
    'Meeting',
    'Phone Call',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Add Activity'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTitle('What Do You Want to Do?'),
              SizedBox(
                width: Get.width / 1,
                height: Get.height / 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    alignment: AlignmentDirectional.topCenter,
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
              ),
              buildTitle('Who Do You Want to Meet / Call?'),
              buildCard(userCont),
              buildTitle('When Do You Want to Meet or Call?'),
              SizedBox(
                height: Get.height / 10,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${date.year}/${date.month}/${date.day}'),
                          Text(
                              '${time.hour} : ${time.minute} ${time.period.name}'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2099),
                                );
                                if (newDate == null) return;
                                setState(() => date = newDate);
                              },
                              child: Text('Pick Date')),
                          ElevatedButton(
                              onPressed: () async {
                                TimeOfDay? newTime = await showTimePicker(
                                  context: context,
                                  initialTime: time,
                                );
                                if (newTime == null) return;
                                setState(() => time = newTime);
                              },
                              child: Text('Pick Time')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              buildTitle('Why Do You Want to Meet or Call?'),
              buildCard(whyCont),
              buildTitle('Could You Decribe More Details?'),
              buildCard(notesCont),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: Get.width / 1.1,
                    height: Get.height / 15,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          if (userCont.text.isEmpty ||
                              notesCont.text.isEmpty ||
                              whyCont.text.isEmpty) {
                            Get.snackbar(
                                'Failed!', "Please Put Valid Information");
                          } else {
                            ApiServices().postActivities(
                              dropdownvalue,
                              userCont.text,
                              whyCont.text,
                              notesCont.text,
                              date.toString(),
                            );
                          }
                        },
                        child: const Text('Submit')),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ));
  }

  Widget buildTitle(String title) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }

  Widget buildCard(TextEditingController cont) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: Get.width / 1,
        height: Get.height / 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: cont,
            maxLines: 10,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration.collapsed(
              hintText: 'press here',
            ),
          ),
        ),
      ),
    );
  }
}
