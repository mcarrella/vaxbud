import 'package:flutter/material.dart';


class AppointmentsPage extends StatelessWidget {
	final String userAppointments;
	const AppointmentsPage(this.userAppointments);

	
	@override
	Widget build(BuildContext context) {
		print(userAppointments);
		switch(userAppointments) {
			case "none":
					return Center(child: Text("No appointment requests pending at this time"));
						break;
			case "pending":
					return Center(child: Text("Requested submitted for vax site. Pending confirmation"));
					break;
			case "confirmed":
					return Center(child: Text("Appointment confirmed"));
					break;
			default:
					return CircularProgressIndicator();
					break;
				}
	}
}
	