import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vaxbud/widgets/common/search_place_widget.dart';


class SiteLocationWidget extends StatelessWidget {
	
	Geoflutterfire geo = Geoflutterfire();
	BehaviorSubject<GeoFirePoint> selectedPoint = BehaviorSubject();
	
	void onSelectCallback(LatLng coords) {
		GeoFirePoint geoPoint = geo.point(latitude: coords.latitude,
											longitude: coords.longitude);
		selectedPoint.add(geoPoint);
	}
	
	@override
	Widget build(BuildContext context) {
		return SearchPlaceWidget(onSelect: onSelectCallback);
		}
}
	