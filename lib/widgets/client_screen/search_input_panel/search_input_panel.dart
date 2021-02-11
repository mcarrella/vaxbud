import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:vaxbub/widgets/common/search_place_widget.dart';

import './radius_slider.dart';


class SearchInputPanel extends StatelessWidget {
	
	double radius;
	LatLng location;
	DateTime date;
	final void Function(double value) onRadiusChanged;
	final void Function(LatLng coords) onLocationChanged;
	final void Function(DateTime date) onDateChanged;
	

	
	
	_selectDate(BuildContext context) async {
		final DateTime picked = await showDatePicker(
												context: context,
												initialDate: date,
												firstDate: DateTime(2000),
												lastDate: DateTime(2025),
												);
		onDateChanged(picked);
	}
										
		
	
	
	@override
	Widget build(BuildContext context) {
		return Container(
							child: Column(
									children: <Widget>[
												
													
													RadiusSlider(radius: radius,
																	onChangedCallback: onRadiusChanged),
													
													SearchPlaceWidget(onSelect: onLocationChanged),
													RaisedButton(
																	onPressed: () => _selectDate(context),
																	child: 'select date',
																	style: TextStyle(
																						color: Colors.black,
																						fontWeight: FontWeight.bold,
																						),
																	color: Colors.greenAccent,
																	),
												
													],
										),
									);
							}
}
													
													
												
													
