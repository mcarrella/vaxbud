import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';

import 'package:vaxbud/widgets/admin_screen/site_location_widget.dart';
import 'package:vaxbud/widgets/admin_screen/site_info_widget.dart';


class RegisterSiteWidget extends StatefulWidget {
	
	@override
	_RegisterSiteWidgetState createState() => _RegisterSiteWidgetState();
}


class _RegisterSiteWidgetState extends State<RegisterSiteWidget {
	FirebaseAuth _auth = FirebaseAuth.instance;
	
	CollectionReference sitesRef = Firestore.instance.collection("sitesRef");
	CollectionReference requestsRef = Firestore.instance.collection("appointmentRequests");
	
	int _currentStep = 0;
	LatLng siteCoords;
	
	
	
	
	var mapData = HashMap<String, dynamic>();
	mapData["site_name"] = SiteInfoState.controllerSiteName.text;
	mapData["site_phone"] = SiteInfoState.controllerSitePhone.text;
	mapData["site_location"] = SiteLocationState.selectedPoint;


	Future<String> createSiteId() {
		return await _auth.signInAnonymously();
	}

	submitSiteData() {
		createSiteId().then((siteId) {
						
							sitesRef.document(siteId).setData(map);
							requestsRef.document(siteId).setData({});
							sharedPrefs.uid = siteId;
							});
					}
			
				
		
	Widet submitWidget() =>  Container(
											child: Center(
															child: RaisedButton(
																				onPressed: () {
																									submitSiteData();
																								},
																				child: Text("submit"),
																				),
																		),
															);
																								
						
	
	List<Step> steps = [
							Step(
										title: Text("Site info"),
										content: SiteInfo(),
										state: currentStep == 0 ? StepState.editing : StepState.indexed,
										isActive: true,
										),
							Step(
										title: Text("Site location"),
										content: SiteLocation() 
										state: currentStep == 1 ? StepState.editing : StepState.indexed,
										isActive: true,
										),
							Step(
										title: Text("Register"),
										content: submitWidget(),
										state: StepState.complete,
										isActive: true,
										),
								];
								
	@override
	Widget build(BuildContext context) {
		return Scaffold(
						body: Container(
											child: Stepper(
																currentStep: this._currentStep,
																steps: steps,
																type: StepperType.horizontal,
																onStepTapped: (step) {
																	setState(() {
																						currentStep = step;
																						});
																		},
																onStepContinue: () {
																	setState(() {
																			if (_currentStep < steps.length - 1) {
																				_currentStep = _currentStep + 1;
																				} else {
																					_currentStep = 0;
																				});
																		});
																	},
																onStepCancel: () {
																	setState(() {
																			if (_currentStep > 0) {
																				_currentStep = _currentStep - 1;
																				} else {
																					_currentStep = 0;
																				}});
																		},
																	),
																);
														}
										}
