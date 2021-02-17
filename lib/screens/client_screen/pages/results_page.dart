import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';

import 'package:vaxbud/widgets/common/search_place_widget.dart';
import 'packge:vaxbud/widgets/client_screen/rsults_page/result_tile.dart';


class ResultsPage extends StatefulWidget {
	@override
	_ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
	
	CollectionReference requestsRef = Firestore.instance.collection("appointmentRequests");
	CollectionReference sitesRef = Firestore.instance.collection("vaxSites");
	BehaviorSubject<double> radius = BehaviorSubject.seeded(100.0);
	BehaviorSubject<LatLng> locationQuery = BehaviorSubject.seeded(LatLng(0.0, 0.0));
	BehaviorSubject<DateTime> dateQuery = BehaviorSubject.seeded(DateTime.now());
	
	
	requestAppointmentCallback(String siteId) {
		requestsRef.document(siteId)
					.collection("requests")
					.document(sharedPrefs.uid)
					.setData({});
				}
			
	

	queryChangedCallback(LatLng coords) {
		locationQuery.add(coords);
	}
	
	
			
	_selectDate(BuildContext context) async {
		final DateTime picked = await showDatePicker(
												context: context,
												initialDate: dateQuery.value,
												firstDate: DateTime(2000),
												lastDate: DateTime(2025),
												);
		dateQuery.add(picked);
	}
	

	@override
	Widget build(BuildContext context) {
		return Scaffold(
					body: CustomScrollView(
										slivers: <Widget>[
												SliverList(
														delegate: SliverChildListDelegate([
																SearchPlaceWidget(onSelect: queryChangedCallback),
																Slider(
																		min: 100.0,
																		max: 500.0,
																		divisions: 4,
																		value: radius.value,
																		label: 'Radius ${radius.value}km',
																		activeColor: Colors.green,
																		inactiveColor: Colors.green.withOpacity(0.2),
																		onChanged: (value) {
													
																				print('NEEW VAL');
																				setState(() {
																				radius.add(value);
																				});
																		
																		},
																	),
																RaisedButton(
																	onPressed: () => _selectDate(context),
																	child: Text('select date',
																					style: TextStyle(
																						color: Colors.black,
																						fontWeight: FontWeight.bold,
																						),
																					),
																	color: Colors.greenAccent,
																
																	),
																]),
													),
												StreamBuilder(
													stream: sitesRef.snapshots(),
													builder: (context, snapshot) => SliverList(
																	delegate: (snapshot.hasData && snapshot.data.documents.length > 0) ? SliverChildBuilderDelegate(
																									(context, index) => ResultTile(snapshot.data.documents[index]['siteName'],
																																snapshot.data.documents[index].documentID),
																									childCount: snapshot.data.documents.length,
																									) : SliverChildBuilderDelegate(
																									(context, index) => ListTile(title: Text("No Results")),
																									childCount: 1,
																									)
																																	
																								)
																							),
										
												
													])

										);
				}
	}	