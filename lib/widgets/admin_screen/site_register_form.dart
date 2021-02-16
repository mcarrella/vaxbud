import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:vaxbud/widgets/common/search_place_widget.dart';

class SiteRegisterForm extends StatefulWidget {
	@override
	_SiteRegisterFormState createState() => _SiteRegisterFormState();
}


class _SiteRegisterFormState extends State<SiteRegisterForm> {
	final _formKey = GlobalKey<FormState>();
	
	String _siteName;
	String _sitePhone;
	LatLng _siteLocation;
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
					body: Center(
							child: Form(
									key: this._formKey,
									child: Padding(
										padding: const EdgeInsets.all(32.0),
										child: Column(
											mainAxisSize: MainAxisSize.min,
											children: <Widget>[
												
												SizedBox(height: 15),
												Text("site name: "),
												TextFormField(
													autovalidate: false,
													onSaved: (value) => this._siteName = value,
													validator: (value) {
														if (value.length <3) {
															return 'a minimum of 3 characters is required';
															}
														},
													),
												SizedBox(height: 15),
												TextFormField(
													autovalidate: false,
													onSaved: (value) => this._siteName = value,
													validator: (value) {
														if (value.length <10) {
															return 'a minimum of 10 characters is required';
															}
														},
													),
													
												RaisedButton(
															child: Text("submit"),
															onPressed: () {
																				Navigator.pop(context, _siteName);
																			},
																		),
												],
											),
										),
									),
								),
							);
					}
	}
												