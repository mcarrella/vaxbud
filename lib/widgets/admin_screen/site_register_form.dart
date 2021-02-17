import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:vaxbud/widgets/common/search_place_widget.dart';

class SiteRegisterForm extends StatefulWidget {
	@override
	_SiteRegisterFormState createState() => _SiteRegisterFormState();
}


class _SiteRegisterFormState extends State<SiteRegisterForm> {

	
	TextEditingController _nameController = TextEditingController();
	TextEditingController _phoneController = TextEditingControler();
	
	String _siteName;
	String _sitePhone;
	LatLng _siteLocation;
	
	
	locationSelectedCallback(LatLng coords) {
		setState(() {
					_siteLocation = coords;
				});
		}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
					body: Center(
							
									child: Padding(
										padding: const EdgeInsets.all(32.0),
										child: Column(
											mainAxisSize: MainAxisSize.min,
											children: <Widget>[
												
												SizedBox(height: 15),
												Text("site name: "),
												TextField(
														controller: _nameController,
														),
												SizedBox(height: 15),
												Text("phone: "),
												TextField(
														controller: _phoneController,
														)
												SizedBox(height: 15),
												Text("location: "),
												SearchPlaceWidget(onSelect: locationSelectedCallback),
												RaisedButton(
															child: Text("submit"),
												
															onPressed: () {
																				Navigator.pop(context, {'siteName': _nameControoler.text,
																										'sitePhone': _phoneController.text,
																										'siteLocation': _siteLocation});
																			},
																		),
												],
											),
										),
								
								),
							);
					}
	}
												