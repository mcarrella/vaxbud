import 'package:flutter/material.dart';

class SiteInfo extends StatefulWidget {
	@override
	SiteInfoState createState() => SiteInfoState();
}


class SiteInfoState extends State<SiteInfo> {
	static final formKey = GlobalKey<FormState>();
	static TextEditingController controllerSiteName = new TextEditingController();
	static TextEditingController controllerSitePhone = new TextEditingController();
	
	@override
	Widget build(BuildContext context) {
		return Container(
							child: Form(
											key: formKey,
											child: Column(
															children: <Widget>[
																			
																					TextFormField(
																									maxLines: 1,
																									controller: controllerSiteName,
																									hintText: "site name",
																									border: OutlineInputBorder(
																												borderRadius: BorderRadius.all(Radius.circular(10.0)),
																												),
																											),
																					SizedBox(height: 20),
																					TextFormField(
																									maxLines: 1,
																									controller: controllerSitePhone,
																									hintText: "site phone",
																									border: OutlineInputBorder(
																												borderRadius: BorderRadius.all(Radius.circular(10.0)),
																												),
																											),
																						],
																			),
																),
													);
										}
}
																					