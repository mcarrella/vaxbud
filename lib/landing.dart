import 'package:flutter/material.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:vaxbud/screens/admin_screen/admin_screen.dart';
import 'package:vaxbud/screens/client_screen/client_screen.dart';



class Landing extends StatefulWidget {
	@override
	_LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {

	FirebaseAuth _auth = FirebaseAuth.instance;
	CollectionReference clientsRef = Firestore.instance.collection("clients");
	
	
	
	createClientDoc(String uid) {
		clientsRef.document(uid).setData({});
	}
	
	createClient() {
		_auth.signInAnonymously().then((result) {
						createClientDoc(result.user.uid);
						sharedPrefs.uid = result.user.uid;
						});
		sharedPrefs.role = "client";
	}
	
	
															
	
	Widget _buildNewUser() => Scaffold(
							appBar: AppBar(title: Text("NEW USER")),
							body: Column(
											children: <Widget>[
																Text("Vax Buddy"),
																Text("Welcome new user"),
																Text("Please make a selection: "),
																Row(
																		children: <Widget>[
																								RaisedButton(
																										child: Text("patient"),
																										onPressed: () {
																													registerClient();
																							
																													
																													},
																										),
																								SizedBox(width: 15),
																								RaisedButton(
																										child: Text("administrator"),
																										onPressed: () {
																													
																													registerAdmin();
																												
																													},
																											),
																							],
																),
																],
													),
											);
	

	
	
	registerClient() {
						createClient();
						setState(() {});
					}
	registerAdmin() {
						sharedPrefs.role = "admin";
						setState(() {});
				}
	
								

	
	@override
	Widget build(BuildContext context) {
		
												switch(sharedPrefs.role) {
																			
																			
																			case "client":
																								print('CLIENT');
																								return ClientScreen();
																								break;
																			case "admin":
																								print('ADMIN');
																								return AdminScreen();
																								break;
																			case "":
																								print('NEW USER');
																								return _buildNewUser();
																								break;
																			default: 
																								print('DEFAULT');
																								return Center(child: Text("SPLASH"));
																								break;
																					}
																}
												
																
										
}