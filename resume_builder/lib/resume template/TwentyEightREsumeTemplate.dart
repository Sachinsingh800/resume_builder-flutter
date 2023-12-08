import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../controller/global_controller.dart';
import '../widget/pannel_widget.dart';

class TwentytwoResumeTemplate extends StatefulWidget {
  const TwentytwoResumeTemplate({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TwentytwoResumeTemplateState createState() =>
      _TwentytwoResumeTemplateState();
}

class _TwentytwoResumeTemplateState extends State<TwentytwoResumeTemplate> {
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
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                              child: Text(
                                'Christian Hybrid',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 0, 0),
                              child: Text(
                                'IT Manager',
                                style: TextStyle(
                                  color: Colors.black,
                                  //fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: const Color(0xff1a8bc3),
                                    width: MediaQuery.sizeOf(context).width * 0.4,
                                    height: 30,
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.fromLTRB(6, 5, 0, 5),
                                              child: Text(
                                                'ABOUT ME',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  //letterSpacing: 1.0
                                                  //fontWeight: FontWeight.w700
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                            const Padding(
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
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: const Color(0xff1a8bc3),
                                    width: MediaQuery.sizeOf(context).width * 0.4,
                                    height: 30,
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.person, color: Colors.white),
                                          Padding(
                                              padding:
                                                  EdgeInsets.fromLTRB(6, 5, 0, 5),
                                              child: Text(
                                                'PERSONAL',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  //letterSpacing: 1.0
                                                  //fontWeight: FontWeight.w700
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '\u2022 Store Opening and Closing and also helped other members witht heir work',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                  Text(
                                    '\u2022 Store Opening and Closing',
                                    style: TextStyle(
                                        color: Color(0xff363c48), fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: const Color(0xff1a8bc3),
                                    width: MediaQuery.sizeOf(context).width * 0.4,
                                    height: 30,
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.language, color: Colors.white),
                                          Padding(
                                              padding:
                                                  EdgeInsets.fromLTRB(6, 5, 0, 5),
                                              child: Text(
                                                'Languages',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  //letterSpacing: 1.0
                                                  //fontWeight: FontWeight.w700
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 10, 8, 0),
                              child: Text(
                                'English',
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
                                      Color(0xffcccccc),
                                      Color(0xffcccccc),
                                      Color(0xff1a8bc3),
                                      Color(0xff1a8bc3),
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
                              height: 15,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 0),
                              child: Text(
                                'Spanish',
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
                                      Color(0xffcccccc),
                                      Color(0xffcccccc),
                                      Color(0xff1a8bc3),
                                      Color(0xff1a8bc3),
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
                          ],
                        )),
                    Container(
                        height: MediaQuery.sizeOf(context).height * 1.0,
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                                padding: EdgeInsets.fromLTRB(6, 10, 0, 5),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.phone,
                                              color: Colors.lightBlue),
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
                                      Row(
                                        children: [
                                          Icon(Icons.language,
                                              color: Colors.lightBlue),
                                          SizedBox(width: 5),
                                          Text(
                                            'www.shubhamsingh.com',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              //letterSpacing: 1.0
                                              //fontWeight: FontWeight.w700
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.mail,
                                              color: Colors.lightBlue),
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
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              color: Colors.lightBlue),
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
                                    ])),
                            const SizedBox(height: 4),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: const Color(0xff1a8bc3),
                                    width: MediaQuery.sizeOf(context).width * 0.6,
                                    height: 30,
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.school, color: Colors.white),
                                          Padding(
                                              padding:
                                                  EdgeInsets.fromLTRB(6, 5, 0, 5),
                                              child: Text(
                                                'EDUCATION',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  //letterSpacing: 1.0
                                                  //fontWeight: FontWeight.w700
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
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
                                    'Lorem Ipsum is simply passages, and  Aldus PageMaker including versions of Lorem Ipsum.',
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
                           const SizedBox(height: 10),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: const Color(0xff1a8bc3),
                                    width: MediaQuery.sizeOf(context).width * 0.6,
                                    height: 30,
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.work, color: Colors.white),
                                          Padding(
                                              padding:
                                                  EdgeInsets.fromLTRB(6, 5, 0, 5),
                                              child: Text(
                                                'EXPERIENCE',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  //letterSpacing: 1.0
                                                  //fontWeight: FontWeight.w700
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
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
                                    'Lorem Ipsum is simply  and  Aldus PageMaker including versions of Lorem Ipsum.',
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
                                    'Lorem Ipsum is simply dummy Aldus PageMaker including versions of Lorem Ipsum.',
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
                            const SizedBox(height: 10),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: const Color(0xff1a8bc3),
                                    width: MediaQuery.sizeOf(context).width * 0.6,
                                    height: 30,
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.mail, color: Colors.white),
                                          Padding(
                                              padding:
                                                  EdgeInsets.fromLTRB(6, 5, 0, 5),
                                              child: Text(
                                                'REFERENCES',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  //letterSpacing: 1.0
                                                  //fontWeight: FontWeight.w700
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
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
                          ],
                        )),
                  ]),
            )));
  }
}
