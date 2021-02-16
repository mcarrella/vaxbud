import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';
import 'package:vaxbud/widgets/admin_screen/site_register_form.dart';



class AdminScreen extends StatefulWidget {
	@override
	_AdminScreenState createState() => _AdminScreenState();
}


class _AdminScreenState extends State<AdminScreen> {

	FirebaseAuth _auth = FirebaseAuth.instance;
	CollectionReference requestsRef = Firestore.instance.collection("appointmentRequests");
	CollectionReference sitesRef = Firestore.instance.collection("vaxSites");

	int selectedIndex = 0;
	
	

	createSiteDoc(String siteName) {
			print('CREATING');
			_auth.signInAnonymously().then((result) {
						print(result.user.uid);
						sitesRef.document(result.user.uid).setData({
																	'name': siteName
																	});
						sharedPrefs.uid = result.user.uid;
									});
			setState(() {});
	}
	
	
	@override
	Widget build(BuildContext context) {
	
		
		
		return 
						Scaffold(
									appBar: AppBar(title: (sharedPrefs.uid=="") ? Text("REGISTRATION") 
																			: (selectedIndex==0) ? Text("CURRENT APPOINTMENTS")
																			: Text("PENDING APPOINTMENTS")),
									body: (sharedPrefs.uid=="") ? 
												Center(
														child: Column(
																		children: <Widget>[
																					Text("Please provide information about your vax site"),
																					RaisedButton(
																							child: Text("begin"),
																							onPressed: () async {
																									final siteName = await Navigator.of(context)
																																.push(MaterialPageRoute(builder: (context) =>
																																		SiteRegisterForm()));
																																		
																									createSiteDoc(siteName);
																									
																									}
																								),
																						],
																				),
																			)
																								

															: StreamBuilder(
															stream: requestsRef
																				.document(sharedPrefs.uid)
																				.collection("requests")
																				.snapshots(),
															builder: (context, snapshot) {
																				
																					{
																									if (snapshot.hasData) {
																												return ListView.builder(
																															itemCount: snapshot.data.documents.length,
																															itemBuilder: (context, index) {
																																return Card(
																																				child: ListTile(
																																							leading: Icon(Icons.list),
																																							trailing: Text("GFG",
																																							style: TextStyle(
																																								color: Colors.green,
																																								fontSize: 15),
																																								),
																																							title: Text("List item $index"),
																																							subtitle: Column(
																																										children: <Widget>[
																																												Text('inside column'),
																																												FlatButton(child: Text('confirm'), onPressed: () {}),
																																												FlatButton(child: Text('denyc'), onPressed: () {}),
																																										],
																																								),
																										
																											),
																										);
																																		
																																	});
																															} else if (snapshot.hasError) {
																																return Text(snapshot.error.toString());
																																} return Center(child: CircularProgressIndicator());
																															}
																					
																					}),
																					
									bottomNavigationBar:  (sharedPrefs.uid=="") ? SizedBox(height: 5) : BottomNavigationBar(
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
																		);
																				
																		
																}
											}