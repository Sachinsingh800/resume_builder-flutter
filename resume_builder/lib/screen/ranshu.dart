import 'package:flutter/material.dart';
import 'package:resume_builder/screen/UserInformation/UserEducation.dart';
import 'package:resume_builder/screen/homepage.dart';
class UserWorkExper extends StatefulWidget {
  UserWorkExper({Key? key}) : super(key: key);

  @override
  State<UserWorkExper> createState() => _UserWorkExperState();
}

class _UserWorkExperState extends State<UserWorkExper> {
  final _formKey = GlobalKey<FormState>();
 TextEditingController positionTtileController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController workSummaryController = TextEditingController();

  String positionTitle = '';

  String companyName = '';

  String workSummary = '';

  DateTime? endDate;
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStartDate ? endDate ?? DateTime.now() : endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
          endDate = picked;
        
      });
      final formattedDate = "${picked.day}/${picked.month}/${picked.year}";

      _enddateController.text = formattedDate;
    }
  }

  final TextEditingController _enddateController = TextEditingController();
  @override
  void dispose() {
    _enddateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: InkWell(
                      onTap: () {
                              Navigator.pop(context);
                            },
                      child: Image.asset("assets/icon/Group 208.png")),
                  ),
                ],
              ),
              //profile part
              Text(
                "Create",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                "Your Resume Professional",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 33),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Work Experience",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              CustomTextFormField(title: "Position Title:", controller: positionTtileController,validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your position title';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        positionTitle = value!;
                                      },),
                              SizedBox(
                                width: 10,
                              ),
                              CustomTextFormField(title: "Company Name:", controller: companyNameController,validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your company name';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                         companyName = value!;
                                        },)
                            ],
                          ),
                          Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "End Date:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 25,
                                    width: 150,
                                    child: TextFormField(
                                      controller: _enddateController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: "dd/mm/yyyy",
                                        labelStyle: TextStyle(fontSize: 10),
                                        suffixIcon: InkWell(
                                          onTap: () =>
                                              _selectDate(context, true),
                                          child: Icon(
                                            Icons.calendar_month,
                                            size: 13,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a date';
                                        }
                                        return null;
                                      },
                                      // No need for onSaved here
                                    ),
                                  ),
                                
                                ],
                              ),
                              
                              SizedBox(height: 20,),
                              Padding(
                padding: const EdgeInsets.only(right: 20,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                      "Work Summary:",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                    TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your work summary';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      workSummary = value!;
                    },
                    ),
                  ],
                ),
              ),
              
                          SizedBox(height: 20),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     if (_formKey.currentState!.validate()) {
                          //       _formKey.currentState!.save();

                          //       // Do something with the form data (e.g., send it to an API)
                          //       print('Bio: $bio');
                          //       print('Job Title: $jobTitle');
                          //       print('First Name: $firstName');
                          //       print('Last Name: $lastName');
                          //       print('Email: $email');
                          //       print('City: $city');
                          //       print('State: $state');
                          //       print('Country: $country');
                          //       print('Postcode: $postcode');
                          //       print('Address: $address');
                          //       print('Phone: $phone');
                          //     }
                          //   },
                          //   child: Text('Save'),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                          //   Navigator.push(context, MaterialPageRoute(
                          //   builder: (context) {
                          //     return UserEducation();
                          //   },
                          // ));
                          },
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xff6AC9CF),
                                    Color(0xffE9F7F8)
                                  ]),
                                  borderRadius: BorderRadius.circular(18)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 38, vertical: 8),
                              child: Text("Previous"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            },
                          ));
                            },
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0)),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xff6AC9CF),
                                      Color(0xffE9F7F8)
                                    ]),
                                    borderRadius: BorderRadius.circular(18)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 8),
                                child: Text("Next"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
           
            ])),
      ),
    )));
  }
}
