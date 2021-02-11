import 'package:fltuter/material.dart';

import 'package:rxdart/rxdart.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';

import 'package:vaxbub/widgets/client_screen/appointments_widget.dart';
;

class ClientScreen extends StatefulWidget {
	@override
	_ClientScreenState createState() => _ClientScreenState();
}


class ClientScreenState extends State<ClientScreen> {

	bool apptsViewMode = true;

	@override
	Widget build(BuildContext context) {
		return 
						Scaffold(
									appBar: AppBar(title: 'CLIENT SCREEN'),
									floatingActionButton: FloatingActionButton.extended(
																		onPressed: () {
																						apptsViewMode = !apptsViewMode;
																						setState(() {});
																									},
																		label: Text('My Appointments'),
																		icon: Icon(Icons.thumb_up),
																		backgroundColor: Colors.pink,
															),
									body: (apptsModeView==true) ? AppointmentsWidget("none") :
												Stack(
														children: <Widget>[
																				(apptsModeView==true) ? Center(child: Text("USER APPOINTMENTS")
																										: ResultsPage(),
																
																				(apptsModeView==true) ? AppointmentsWidget("none") 
																									: ResultsPage(),
																															
																				
																										],
																								),
																
																			
									
													);
																}
											}