import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';
import 'package:vaxbud/models/vax_site.dart';
import 'package:vaxbud/widgets/common/search_place_widget.dart';
import 'package:vaxbud/widgets/client_screen/results_page/result_tile.dart';


class ResultsPage extends StatefulWidget {
	@override
	_ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
	
	CollectionReference requestsRef = Firestore.instance.collection("appointmentRequests");
	CollectionReference sitesRef = Firestore.instance.collection("vaxSites");
	Geoflutterfire geo = Geoflutterfire();
	
	BehaviorSubject<double> radius = BehaviorSubject.seeded(100.0);
	BehaviorSubject<LatLng> locationQuery = BehaviorSubject.seeded(LatLng(0.0, 0.0));
	BehaviorSubject<DateTime> dateQuery = BehaviorSubject.seeded(DateTime.now());
	final StreamController<List<VaxSite>> _queryResultsStreamCtrl = StreamController<List<VaxSite>>.broadcast();
	Stream<List<VaxSite>> get onResultsChanged => _queryResultsStreamCtrl.stream;
	void updateQueryResults(List<VaxSite> results) => _queryResultsStreamCtrl.sink.add(results);

	StreamSubscription subscription;
	

	
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
	

	_updateQueryResults(List<DocumentSnapshot> docSnaps) {
			List<VaxSite> sites = docSnaps.map((item) => VaxSite.fromMap(item.data(), item.documentID)).toList();
			updateQueryResults(sites);
		}
	_startQuery() async {
			subscription = radius.switchMap((rad) {
				print('RAD');
				print(rad.toString());
				LatLng coords = locationQuery.value;
				print(coords.latitude.toString());
				print("LATITUDE");
				return geo.collection(collectionRef: sitesRef)
											.within(
													center: geo.point(latitude: locationQuery.value.latitude,
																		longitude: locationQuery.value.longitude),
													radius: rad,
													field: 'position',
													strictMode: true
													);
												}).listen(_updateQueryResults);
											}

	@override
	initState() {
		super.initState();
		_startQuery();
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
													stream: onResultsChanged,
													builder: (context, snapshot) => SliverList(
																	delegate: (snapshot.hasData && snapshot.data.length > 0) ? SliverChildBuilderDelegate(
																									(context, index) {
																											
																											return ResultTile(vaxSite: snapshot.data[index]);
																															},
																									childCount: snapshot.data.length,
																									) : SliverChildBuilderDelegate(
																																(context, index) => ListTile(title: Text("No Results")),
																																childCount: 1,
																													),
																																	
																								),
																							),
										
												
													])

										);
				}
	}	