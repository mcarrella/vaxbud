import 'package:fltuter/material.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';

import 'package:vaxbub/widgets/client_screen/appointments_widget.dart';
import './sites_explorer.dart';

class ClientScreen extends StatefulWidget {
	@override
	_ClientScreenState createState() => _ClientScreenState();
}


class ClientScreenState extends State<ClientScreen> {

	int selectedIndex = 0;

	

	@override
	Widget build(BuildContext context) {
		return 
						Scaffold(
									
									body: StreamBuilder(
															stream: Firestore.instance.collection("sites"),
															builder: (context, AsyncSnapshot snapshot) {
																
																			switch(selectedIndex) {
																						case 0:
																									return AppointmentsWidget("none");
																									break;
																						case 1:
																									return SitesExplorer(sitesList: snapshot.data.documents);
																									break;
																						default:
																									return CircularProgressIndicator();
																									break;
																									
																							}
																			}),
																									
																											
									botttomNaivgationBar: BottomNavigationBar(
																		currentIndex: selectedIndex,
																		onTap: (int index) => setState(() => selectedIndex = index),
																		items: [
																							BottomNavigationBarItem(
																														icon: Icon(Icons.list),
																														title: Text("appointments"),
																												),
																							BottomNavigationBarItem(
																														icon: Icon(Icons.search),
																														title: Text("search"),
																													),
																				],
																		),
																		
																}
											}