import 'package:flutter/material.dart';

import 'package:rxdart/rxdart.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';

import 'package:vaxbud/screens/client_screen/pages/appointments_page.dart';
import 'package:vaxbud/screens/client_screen/pages/results_page.dart';


class ClientScreen extends StatefulWidget {
	@override
	_ClientScreenState createState() => _ClientScreenState();
}


class _ClientScreenState extends State<ClientScreen> {

	bool apptsViewMode = true;

	@override
	Widget build(BuildContext context) {
		return 
						Scaffold(
									appBar: AppBar(title: (apptsViewMode==true) ? Text("MY APPOINTMENTS") : Text('SEARCH VAX SITES')),
									floatingActionButton: FloatingActionButton(
																		onPressed: () {
																						apptsViewMode = !apptsViewMode;
																						setState(() {});
																									},
																		child: (apptsViewMode==true) ? Icon(Icons.search) : Icon(Icons.close),
															
																		
																		backgroundColor: Colors.pink,
															),
									body: (apptsViewMode==true) ? AppointmentsPage("none") : ResultsPage(),
																															
																				
							
																
																			
									
																			
																		);
																}
											}