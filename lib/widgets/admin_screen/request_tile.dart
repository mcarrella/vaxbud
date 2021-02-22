import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';

class RequestTile extends StatefulWidget {
	String clientId;
	RequestTile(this.clientId);
	@override
	_RequestTileState createState() => _RequestTileState();
}


class _RequestTileState extends State<RequestTile> {

	CollectionReference requestsRef = Firestore.instance.collection("appointmentRequests");
	CollectionReference confirmedRef = Firestore.instance.collection("confirmedAppointments");

	
	deleteRequest(String clientId) {
		requestsRef.document(sharedPrefs.uid)
									.collection("clientRequests")
									.document(clientId)
									.delete();
								}
	
	confirmRequest(String clientId) {
						
						deleteRequest(clientId);
						confirmedRef.document(sharedPrefs.uid)
									.collection("clients")
									.document(clientId)
									.setData({});
							}
					
		
		@override
		Widget build(BuildContext context) {
			return ListTile(
								title: Text("client name"),
								subtitle: <Widget>[
														RaisedButton(
																		child: Text("confirm"),
																		onPressed: () {
																					confirmRequest(widget.clientId);
																					},
																	),
														RaisedButton(
																		child: Text("deny"),
																		onPressed: () {
																					deleteRequestRequest(widget.clientId);
																					},
																			),
															],
														);
												}
}
														
														


}