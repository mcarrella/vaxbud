import 'package:flutter/material.dart';



class RadiusSlider extends StatelessWidget {
	double radius;
	final void Function(double value) onChangedCallback;
	RadiusSlider({this.radius, this.onChangedCallback});

	@override
	Widget build(BuildContext context) {
		return Slider(
								min: 100.0,
								max: 500.0,
								divisions: 4,
								value: radius,
								label: 'Radius ${radius}km',
								activeColor: Colors.green,
								inactiveColor: Colors.green.withOpacity(0.2),
								onChanged: onChangedCallback,
												);
									}
}
					