import 'package:flutter/material.dart';

class NewUserWidget extends StatelessWidget {

	final void Function() onRegisterUser;
	final void Function() onRegisterAdmin;
	
	NewUserWidget({this.onRegisterUser, this.onRegisterAdmin});


	@override
	Widget build(BuildContext context) {
		return Scaffold(
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
																													
																													this.onRegisterUsero;
																													
																													},
																										),
																								SizedBox(width: 15),
																								RaisedButton(
																										child: Text("administrator"),
																										onPressed: () {
																													
																													this.onRegisterAdmin;
																												
																													},
																											),
																							],
																),
																],
													),
											);