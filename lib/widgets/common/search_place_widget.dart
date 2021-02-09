import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart' hide Location;



class SearchPlaceWidget extends StatelessWidget {
	final void Function(LatLng coords) onSelect;
	SearchPlaceWidget({this.onSelect});
	String apiKey = "pk.eyJ1IjoibWNhcnJlbGxhIiwiYSI6ImNraTduYWN0czBtOGwyem85aTJlODRzcHIifQ.SLTfO5mti0vg2WHJij_6_A";
	
	
	Widget build(BuildContext context) {
		return SafeArea(
													bottom: false,
													child:  MapBoxPlaceSearchWidget(
								
											apiKey: apiKey,
										
											searchHint: 'search',
											onSelected: (place) {
											
																this.onSelect(LatLng(place.center[0],
																					place.center[1]));
																		
																	
																						
																						
																									
																				
																},
											context: context
													),
												);
								}
}