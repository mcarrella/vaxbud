import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:vaxbud/widgets/common/search_place_widget.dart';

class SiteRegisterForm extends StatefulWidget {
	@override
	_SiteRegisterFormState createState() => _SiteRegisterFormState();
}


class _SiteRegisterFormState extends State<SiteRegisterForm> {

	
	
	TextEditingController _nameController = TextEditingController();
	TextEditingController _phoneController = TextEditingController();
	
	String _siteName;
	String _sitePhone;
	LatLng _coords;

	
	
	locationSelectedCallback(LatLng coords) {
		setState(() {
					_coords = coords;
					

				});
		}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
					body: CustomScrollView(
										slivers: <Widget>[
												SliverList(
														delegate: SliverChildListDelegate([
																SizedBox(height: 30),
												Text("site name: "),
												TextField(
														controller: _nameController,
														),
												SizedBox(height: 15),
												Text("phone: "),
												TextField(
														controller: _phoneController,
														),
												SizedBox(height: 15),
												Text("location: "),
												SearchPlaceWidget(onSelect: locationSelectedCallback),
												RaisedButton(
															child: Text("submit"),
														
															onPressed: () {
																				Navigator.pop(context, {'siteName': _nameController.text,
																										'sitePhone': _phoneController.text,
																										'coords': _coords});
																			},
																		),
																]),
													),
												
										
												
													]),
							);
					}
	}
												