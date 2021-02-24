import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:vaxbud/services/storage/shared_prefs.dart';


class AppointmentsPage extends StatelessWidget {
	
	CollectionReference sitesRef = Firestore.instance.collection("vaxSites");
	
	Future<bool> isConfirmed(String siteId) async {
				var res = await sitesRef.document(siteId)
										.collection("confirmed")
										.document(sharedPrefs.uid)
										.get();
										
					if (res.exists) { return true; } return false;
				}
				
	Future<bool> isPending(String siteId) async {
				var res = await sitesRef.document(siteId)
										.collection("pending")
										.document(sharedPrefs.uid)
										.get();
										
					if (res.exists) { return true; } return false;
				}
			
	@override
	Widget build(BuildContext context) {
		
		if (sharedPrefs.pendingRequest=="") {
					return Center(child: Text("No appointment requests pending at this time"));
					} else {
							return FutureBuilder(
												future: Future.wait([
																		isConfirmed(sharedPrefs.pendingRequest),
																		isPending(sharedPrefs.pendingRequest),
																		]),
												initialData: [],
												builder: (context, snapshot) {
														var values = snapshot.data;
														if (snapshot.data.length>0) {
																if (snapshot.data[0]==true) {
																			return Center(child: Text("Appointment confirmed"));
																			}
																if (snapshot.data[1]==true) {
																			return Center(child: Text("appointment request pending"));
																			}
																else {
																			sharedPrefs.pendingRequest = "";
																			return Center(child: Text("your request for appointment has been denied"));
																			}
																	} else {
																				return Center(child: CircularProgressIndicator());
																				}
																	},
															);
													}
										}
							}
												
