// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../controller/global_controller.dart';
import '../widget/pannel_widget.dart';

class TwentyfourResumeTemplate extends StatefulWidget {
  const TwentyfourResumeTemplate({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TwentyfourResumeTemplateState createState() =>
      _TwentyfourResumeTemplateState();
}

class _TwentyfourResumeTemplateState extends State<TwentyfourResumeTemplate> {
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
            left: true,
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
              body:
              Wrap(
                  children: [
                    Column(
                      children: [
                      Container(
                          height: MediaQuery.sizeOf(context).height * 0.11,
                          width: MediaQuery.sizeOf(context).width,
                          child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 5, 40, 0),
                                    child: Text(
                                      'Shubham Singh',
                                      style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.0),
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: 10),
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
                                        child: Text(
                                          'Senior Flutter Developer',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            //fontWeight: FontWeight.w700
                                          ),
                                        )),
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  indent: 6,
                                  endIndent: 10,
                                  color: Color(0xff303845),
                                ),
                              ])),
                    ]),
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.85,
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(6, 10, 0, 0),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff2d2e30),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            5.0), // Add some space between the icon and text
                                    const Expanded(
                                      child: Text(
                                        'Washington Square, NY',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xff2d2e30),
                                          //fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(height: 5),
                                  Row(children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff2d2e30),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.phone_android_sharp,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            5.0), // Add some space between the icon and text
                                    const Expanded(
                                      child: Text(
                                        '09503942697',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xff2d2e30),
                                          //fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(height: 5),
                                  Row(children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff2d2e30),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.mail_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            5.0), // Add some space between the icon and text
                                    const Expanded(
                                      child: Text(
                                        'ss20010126@gmail.com',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xff2d2e30),
                                          //fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(height: 5),
                                  Row(children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff2d2e30),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.language_outlined,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                        width:
                                            5.0), // Add some space between the icon and text
                                    const Expanded(
                                      child: Text(
                                        'linkedin.com/en/5hubzzz',
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color(0xff2d2e30),
                                          //fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              thickness: 1,
                              indent: 6,
                              endIndent: 10,
                              color: Color(0xff303845),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 6),
                              child: Text(
                                'EXPERTISE',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                child: Text('Adobe Photoshop',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ))),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                child: Text('Adobe Photoshop',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ))),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                child: Text('Adobe Photoshop',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ))),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                child: Text('Adobe Photoshop',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ))),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                child: Text('Adobe Photoshop',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ))),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(8, 5, 0, 0),
                                child: Text('Adobe Photoshop',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ))),
                            const SizedBox(height: 10),
                            const Divider(
                              thickness: 1,
                              indent: 6,
                              endIndent: 10,
                              color: Color(0xff303845),
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 5, 6, 0),
                              child: Text(
                                'EDUCATION',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Software Engineer',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'ABC Company ',
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '2019.08 - Present',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Software Engineer',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'ABC Company ',
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '2019.08 - Present',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Software Engineer',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'ABC Company ',
                                    //textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '2019.08 - Present',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      width:1,
                      height: MediaQuery.sizeOf(context).height * 0.85,
                      color: Colors.black,),
                    Column(
                      children: [
                        Container(
                            height: MediaQuery.sizeOf(context).height * 0.85,
                            width: MediaQuery.sizeOf(context).width * 0.59,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 10, 6, 6),
                                  child: Text(
                                    'PROFILE',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 0, 6, 5),
                                    child: Text(
                                      'Lorem Ipsum is simply dummy text of   1960s with the release  dummy text of  scrambled  popularised in the 1960s with the release oofimply dummy text of  scrambled  popularised in the 1960s with the release o Letraset sheets containing Lorem Ipsum passages, and more .',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        //letterSpacing: 1.0
                                        //fontWeight: FontWeight.w700
                                      ),
                                    )),
                                Divider(
                                  thickness: 1,
                                  indent: 6,
                                  endIndent: 6,
                                  color: Color(0xff303845),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(6, 5, 6, 6),
                                  child: Text(
                                    'EXPERIENCE',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(6, 0, 6, 5),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Software Engineer',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            'ABC Company ',
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            'Location',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            '2019.08-Present',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
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
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            'ABC Company ',
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            'Location',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            '2019.08-Present',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
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
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            'ABC Company ',
                                            //textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            'Location',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            '2019.08-Present',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 0, 0, 0),
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
                                        ])),
                              ],
                            )),
                      ],
                    )
                  ]),
            )));
  }
}
