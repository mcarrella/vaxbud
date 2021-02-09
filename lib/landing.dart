import 'package:flutter/material.dart';
import 'package:vaxbud/services/storage/shared_prefs.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:vaxbud/screens/admin_screen/admin_screen.dart';
import 'package:vaxbud/widgets/admin_screen/admin_setup_widget.dart';

import 'package:vaxbud/screens/client_screen/client_screen.dart';


class Landing extends StatefulWidget {
	@override
	_LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {

	FirebaseAuth _auth = FirebaseAuth.instance;
	CollectionReference clientsRef = Firestore.instance.collection("clients");
	
	Future<String> createUserId() {
		return await _auth.signInAnonymously();
	}
	
	createClientDoc(String uid) {
		clientsRef.document(uid).setData({});
	}
	
	createClient() {
		createUserId().then((result) {
							createClientDoc(result.user.uid);
							sharedPrefs.uid = result.user.uid;
							});
		sharedPrefs.role = "client";
	}
	
	
	

	
	
	registerClient() {
						createClient();
						setState(() {});
					}
	registerAdmin() {
						sharedPrefs.role = "admin";
						setState(() {});
				}
	
	_buildClient() {
					return ClientScreen();
				}}
	
	_buildAdmin() {
						if (sharedPrefs.uid) {
													return AdminScreen(adminId: sharedPrefs.uid);
													} else { 
																return AdminSetupWidget();
																}
													}
	_buildNewUser() {
				return NewUserWidget(onRegisterUser: registerUser,
										onRegisterAdmin: registerAdmin);
					}
	
	
	@override
	Widget build(BuildContext context) {
		
												switch(sharedPrefs.role) {
																			
																			
																			case "client":
																								_buildClient();
																								break;
																			case "admin":
																								_buildAdmin();
																								break;
																			case "":
																								_buildNewUser();
																								break;
																			default: 
																								return Center(child: Text("SPLASH"));
																								break;
																					}
																}
}