import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ResultsPage extends StatefulWidget {
	@override
	_ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
	

	BehaviorSubject<double> radius = BehaviorSubject.seeded(100.0);
	BehaviorSubject<LatLng> locationQuery = BehaviorSubject.seeded(LatLng(0.0, 0.0));
	BehaviorSubject<DateTime> dateQuery = BehaviorSubject.seeded(DateTime.now());
	
	
	
	radiusChangedCallback(double value) {
				radius.add(value);
		}
		
	queryChangedCallback(LatLng coords) {
			query.add(coords);
	}
	
	dateChangedCallback(DateTime date) {
			dateQuery.add(date);
			}
	
	dateR
	
	@override
	Widget build(BuildContext context) {
		return Column(
						children: <Widget>[
							SearchInputPanel(
										radiusChanged: radiusChangedCallback,
										queryChanged: queryChangedCallback,
										dateChanged: dateChangedCallback,
										),
							StreamBuilder(
									stream: Firestore.instance.collection("geoPosts"),
									builder: (context, snapshot) {
													if (snapshot.hasData) {
																return ListView.builder(
																		itemCount: snapshot.data.documents.length,
																		itemBuilder: (BuildContext context, int index) {
																						return Card(
																									child: ListTile(
																										leading: Icon(Icons.list),
																										trailing: Tex("GFG",
																															style: TextStyle(
																																		color: Colors.green,
																																		fontSize: 15),
																															),
																										title: Text("List item $index"),
																										trailing: Icon(Icons.list),
																											),
																										);
																											
																								});
																				}
																										
													else if (snapshot.hasError) {
																return Text(snapshot.error.toString());
															}
													return Center(child: CircularProgressIndicator());
											},
									),
								],
							);
				}
	}	