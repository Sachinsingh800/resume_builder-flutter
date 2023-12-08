import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../controller/global_controller.dart';
import '../widget/pannel_widget.dart';

class TwentythreeResumeTemplate extends StatefulWidget {
  const TwentythreeResumeTemplate({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TwentythreeResumeTemplateState createState() =>
      _TwentythreeResumeTemplateState();
}

class _TwentythreeResumeTemplateState extends State<TwentythreeResumeTemplate> {
  @override
  Widget build(BuildContext context) {

    GlobalController globalController = Get.find();
    void voidCallBack(){
      setState(() {

      });
    }

    return Scaffold(
        body: SafeArea(
            top: true,
            right: true,
            bottom: true,
            child: SlidingUpPanel(
              minHeight: MediaQuery.of(context).size.height * 0.02,
              maxHeight: MediaQuery.of(context).size.height * 0.3,
              parallaxEnabled: true,
              parallaxOffset: 0.5,
              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              panelBuilder: (controller)=> PanelWidget(
                controller: controller,
                globalController: globalController,
                callBack: (){
                  voidCallBack();
                },
              ),
              body: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        color: const Color(0xffe1e1e1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 25, 6, 0),
                              child: Row(
                                children: [
                                  Icon(Icons.phone, color: Color(0xff454545)),
                                  SizedBox(width: 5),
                                  Text(
                                    '+91 9503942697',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      //letterSpacing: 1.0
                                      //fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Row(
                                children: [
                                  Icon(Icons.mail, color: Color(0xff454545)),
                                  SizedBox(width: 5),
                                  Text(
                                    'ss20010126@gmail.com',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      //letterSpacing: 1.0
                                      //fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: Color(0xff454545)),
                                  SizedBox(width: 5),
                                  Text(
                                    'Vaco-da-gama, Goa',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      //letterSpacing: 1.0
                                      //fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 0.5,
                              color: Color(0xFF1C1B20),
                            ),
                            const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(6, 10, 0, 5),
                                      child: Text(
                                        'EDUCATION',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.w700),
                                      )),
                                ]),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'MS in Data Science, Distinction',
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '2019.08 - 2023.07',
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Oxford University ',
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Lorem Ipsum is simply , and  Aldus PageMaker including versions of Lorem Ipsum.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      //letterSpacing: 1.0
                                      //fontWeight: FontWeight.w700
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'MS in Data Science, Distinction',
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '2019.08 - 2023.07',
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Oxford University ',
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xff363c48),
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Lorem Ipsum is simply Aldus PageMaker including versions of Lorem Ipsum.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      //letterSpacing: 1.0
                                      //fontWeight: FontWeight.w700
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 0.5,
                              color: Color(0xFF1C1B20),
                            ),
                            const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(6, 10, 0, 5),
                                      child: Text(
                                        'SKILLS',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.w700),
                                      )),
                                ]),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Text(
                                'Dart',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Container(
                                height: 5,
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffffffff),
                                      Color(0xffffffff),
                                      Color(0xff454545),
                                      Color(0xff454545),
                                    ],
                                    stops: [
                                      0.7,
                                      0.0,
                                      0.0,
                                      1.0
                                    ], // Adjust the stop values to control the filling level
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Text(
                                'Flutter',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Container(
                                height: 5,
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffffffff),
                                      Color(0xffffffff),
                                      Color(0xff454545),
                                      Color(0xff454545),
                                    ],
                                    stops: [
                                      0.7,
                                      0.0,
                                      0.0,
                                      1.0
                                    ], // Adjust the stop values to control the filling level
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Text(
                                'Adobe Photoshop',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Container(
                                height: 5,
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffffffff),
                                      Color(0xffffffff),
                                      Color(0xff454545),
                                      Color(0xff454545),
                                    ],
                                    stops: [
                                      0.7,
                                      0.0,
                                      0.0,
                                      1.0
                                    ], // Adjust the stop values to control the filling level
                                  ),
                                ),
                              ),
                            ),  const SizedBox(
                              height: 10,
                            ),
                             const Divider(
                              thickness: 0.5,
                              color: Color(0xFF1C1B20),
                            ),

                            const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 0, 5),
                                      child: Text(
                                        'REFERENCES',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.w700
                                        ),
                                      )),
                                ]),
                            const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(6, 5, 6, 0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Lakers Bark',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'ABC Company ',
                                                //textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                'Address and contact number of the concerned person',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Lakers Bark',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'ABC Company ',
                                                //textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                'Address and contact number of the concerned person',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )))
                                ]),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        )),
                    Container(
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        width: MediaQuery.sizeOf(context).width * 0.55,
                        color: Colors.white,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.fromLTRB(6, 10, 6, 5),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                                        child: Text(
                                          'Jonathan Patterson',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                                        child: Text(
                                          'Graphic Designer',
                                          style: TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ])),
                            Divider(
                              thickness: 0.5,
                              color: Color(0xFF1C1B20),
                            ),
                            SizedBox(height: 4),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(6, 5, 0, 5),
                                      child: Text(
                                        'PROFILE',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.w700),
                                      )),
                                ]),
                            Padding(
                                padding: EdgeInsets.fromLTRB(6, 5, 0, 5),
                                child: Text(
                                  'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    //letterSpacing: 1.0
                                    //fontWeight: FontWeight.w700
                                  ),
                                )),
                            SizedBox(height: 10),
                              Divider(
                              thickness: 0.5,
                              color: Color(0xFF1C1B20),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(6, 5, 0, 5),
                                      child: Text(
                                        'EXPERIENCE',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.w700
                                        ),
                                      )),
                                ]),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                                'Software Engineer',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'ABC Company ',
                                                //textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                '2019.08 - Present',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Software Engineer',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'ABC Company ',
                                                //textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                '2019.08 - Present',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                                'Software Engineer',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'ABC Company ',
                                                //textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                '2019.08 - Present',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Software Engineer',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                'ABC Company ',
                                                //textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                '2019.08 - Present',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Lorem Ipsum is simply dummy text of  Lorem Ipsum passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
                                                style: TextStyle(
                                                  color: Color(0xff363c48),
                                                  fontSize: 12,
                                                ),
                                              ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        )),
                  ]),
            )));
  }
}
