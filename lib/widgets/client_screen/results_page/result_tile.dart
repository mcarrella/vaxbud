import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';
import 'package:vaxbud/models/vax_site.dart';

class ResultTile extends StatefulWidget {
	final VaxSite vaxSite;
	const ResultTile({Key key, this.vaxSite}) : super(key: key);
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
						sharedPrefs.pendingRequest = siteId;
						setState(() {
										requestSent = true;
									});
							}
	
	@override
	Widget build(BuildContext context) {
		
		return ListTile(
						title: Text(widget.vaxSite.siteName),
						subtitle: (requestSent==false) ? RaisedButton(
															child: Text("request appointment"),
															onPressed: () {
														
																	requestAppointment(widget.vaxSite.id);
														},
													) : Text("request sent!"),
								);
					}
}