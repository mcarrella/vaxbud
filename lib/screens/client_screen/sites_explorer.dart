import 'package:flutter/material.dart';
import 'package:vaxbud/widgets/search_input_panel.dart';
class SitesExporer extends StatefulWidget {
	@override
	_SitesExplorerState createState() => _SitesExplorerState();
}


class _SitesExplorerState extends State<SitesExplorer> {

	int selectedIndex = 0;
	@override
	Widget build(BuildContext context) {
			return Scaffold(
						body: Stack(
										children: <Widget>[
																SearchInputPanel(),
																(selectedIndex==0) ? CalendarWidget() : MapListWidget(),
																],
													),
																
						botttomNaivgationBar: BottomNavigationBar(
																		currentIndex: selectedIndex,
																		onTap: (int index) => setState(() => selectedIndex = index),
																		items: [
																							BottomNavigationBarItem(
																														icon: Icon(Icons.list),
																														title: Text("calendar"),
																												),
																							BottomNavigationBarItem(
																														icon: Icon(Icons.search),
																														title: Text("map"),
																													),
																				],
																		),
  }
}