import 'package:flutter/material.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';
import 'package:latlong/latlong.dart';
import 'package:vaxbud/widgets/common/search_place_widget.dart';
import './site_info_widget.dart';

class RegisterSiteWidget extends StatefulWidget {
	
	@override
	_RegisterSiteWidgetState createState() => _RegisterSiteWidgetState();
}


class _RegisterSiteWidgetState extends State<RegisterSiteWidget {
	int _currentStep = 0;
	LatLng siteCoords;
	
	
	var mapData = HashMap<String, dynamic>();
	mapData["site_name"] = SiteInfoState.controllerSiteName.text;
	mapData["site_phone"] = SiteInfoState.controllerSitePhone.text;
	mapData["site_location"] = SiteLocationState.point;

	
	
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
										content: Upload(mapData),
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
