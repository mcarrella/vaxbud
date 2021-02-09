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

	BehaviorSubject<double> radius = BehaviorSubject.seeded(100.0);
	
	radiusChangedCallback(double value) {
				radius.add(value);
		}
	
	

	@override
	Widget build(BuildContext context) {
		return 
						Scaffold(
									
									body: (apptsModeView==true) ? AppointmentsWidget("none") :
												Stack(
														children: <Widget>[
																				SearchInputPanel(radius: radius,
																								onRadiusChanged: radiusChangedCallback),
																
																				StreamBuilder(
																								stream: Firestore.instance.collection("geoPosts"),
																								builder: (context, AsyncSnapshot snapshot) {
																									if (snapshot.hasData) {
																												return ListView.builder(
																															list: snapshot.data.documents,
																															builder: (context, index) {
																																return Text("result here");
																																		
																																	});
																															} else if (snapshot.hasError) {
																																return Text(snapshot.error.toString());
																																} return Center(child: CircularProgressIndicator());
																															}
																															
																												),
																										],
																								),
																
																			
									floatingActionButton: FloatingActionButton.extended(
																		onPressed: () {
																														apptsViewMode = !apptsViewMode;
																														setState(() {});
																									},
																								label: Text('My Appointments'),
																								icon: Icon(Icons.thumb_up),
																								backgroundColor: Colors.pink,
															),
													);
																}
											}