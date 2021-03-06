import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong/latlong.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';
import 'package:vaxbud/widgets/admin_screen/site_register_form.dart';



class AdminScreen extends StatefulWidget {
	@override
	_AdminScreenState createState() => _AdminScreenState();
}


class _AdminScreenState extends State<AdminScreen> {

	FirebaseAuth _auth = FirebaseAuth.instance;
	final geo = Geoflutterfire();
	
	CollectionReference sitesRef = Firestore.instance.collection("vaxSites");
	
	_handleConfirm(String clientId) {
			sitesRef.document(sharedPrefs.uid)
					.collection("confirmed")
					.document(clientId).setData({});
			}

	int selectedIndex = 0;
	String uid;
	
	

	createSiteDoc(Map<String, dynamic> siteData) {
			print('CREATING');
			_auth.signInAnonymously().then((result) {
						print(result.user.uid);
						LatLng coords = siteData['coords'];
						GeoFirePoint point = geo.point(latitude: coords.latitude,
														longitude: coords.longitude);
						sitesRef.document(result.user.uid).setData({
																	'name': siteData['siteName'],
																	'phone': siteData['sitePhone'],
																	'position': point.data,
																	});
						sharedPrefs.uid = result.user.uid;
						setState(() {
										uid = sharedPrefs.uid;
										});
									});
			
	}
	
	@override
	initState() {
			super.initState();
			uid = sharedPrefs.uid;
		}
	
	
	@override
	Widget build(BuildContext context) {
	
		
		
		
		return 
						Scaffold(
									appBar: AppBar(title: (uid=="") ? Text("REGISTRATION") 
																			: (selectedIndex==0) ? Text("CURRENT APPOINTMENTS")
																			: Text("PENDING APPOINTMENTS")),
									body: (uid=="") ? 
												Center(
														child: Column(
																		children: <Widget>[
																					Text("Please provide information about your vax site"),
																					RaisedButton(
																							child: Text("begin"),
																							onPressed: () async {
																									final siteData = await Navigator.of(context)
																																.push(MaterialPageRoute(builder: (context) =>
																																		SiteRegisterForm()));
																																		
																									createSiteDoc(siteData);
																									
																									
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
																																ClientModel _client = ClientModel.fromMap(item.data(), item.documentID);
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
																																												FlatButton(child: Text('confirm'), onPressed: () {
																																															_handleConfirm(_client.id),
																																												FlatButton(child: Text('deny'), onPressed: () {}),
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
																					
									bottomNavigationBar:  (uid=="") ? SizedBox(height: 5) : BottomNavigationBar(
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