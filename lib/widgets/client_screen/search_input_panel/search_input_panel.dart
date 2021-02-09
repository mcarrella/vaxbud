import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:vaxbub/widgets/common/search_place_widget.dart';

import './radius_slider.dart';


class SearchInputPanel extends StatelessWidget {
	
	double radius;
	final void Function(double value) onRadiusChanged;
	
	onSelectPlace(LatLng coords) {
				print('GOT COORDS');
		}
		
	dateTimeRangePicker() async {
		DateTimeRange picked = await showDateRangePicker(
													context,,
													firstDate: DateTime(DateTime.now().year - 5),
													lastDate: DateTime(DateTime.now().year + 5),
													initialDateRange: DateTimeRange(
																				end: DateTime(
																								DateTime.now().year,
																								DateTime.now().month,
																								DateTime.now().day + 13),
																				start: DateTime.now(),
																			),
																	);
														print(picked);
											}
	
	@override
	Widget build(BuildContext context) {
		return Container(
							child: Column(
									children: <Widget>[
												
													
													RadiusSlider(radius: radius,
																	onChangedCallback: onRadiusChanged),
													Text("from location"),
													SearchPlaceWidget(onSelect: onSelectPlace),
													RaisedButton(
																	child: Text("Date Range"),
																	onPressed: () {
																					dateTimeRangePicker();
																					},
																		),
													],
										),
									);
							}
}
													
													
												
													
