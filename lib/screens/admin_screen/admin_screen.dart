import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';


class AdminScreen extends StatefulWidget {
	@override
	_AdminScreenState createState() => _AdminScreenState();
}


class _AdminScreenState extends State<AdminScreen> {

	int selectedIndex = 0;
	
	

	@override
	Widget build(BuildContext context) {
		return 
						Scaffold(
									appBar: AppBar(title: (selectedIndex==0) ? Text("CURRENT APPOINTMENTS")
																			: Text("PENDING APPOINTMENTS")),
									body: StreamBuilder(
															stream: Firestore.collection("sites")
																				.document(sharedPrefs.uid)
																				.collection("appointments");
															builder: (context, snapshot) {
																				
																					{
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
																														title: Text("pending"),
																													),
																				],
																		),
																		
																}
											}