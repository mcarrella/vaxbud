import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';

class ResultTile extends StatefulWidget {
	final siteId;
	final siteName;
	ResultTile(this.siteId, this.siteName);
	@override
	_ResultTileState createState() => _ResultTileState();
}

class _ResultTileState extends State<ResultTile> {
	
	CollectionReference requestsRef = Firestore.instance.collection("appointmentRequests");
	bool requestSent = false;
	
	requestAppointment(String siteId) {
						requestsRef.document(siteId)
									.collection("clientRequests")
									.document(sharedPrefs.uid)
									.setData({});
						setState(() {
										requestSent = true;
									});
							}
	
	@override
	Widget build(BuildContext context) {
		return ListTile(
						title: Text(widget.siteName),
						subtitle: (requestSent==false) ? RaisedButton(
														child: Text("request appointment"),
														onPressed: () {
														
																	requestAppointment(widget.siteId);
														},
													) : Text("request sent!"),
								);
					}
}
										
										