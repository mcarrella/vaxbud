import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VaxSite {

	final String id;
	final String siteName;
	final String sitePhone;
	
	VaxSite({@required this.siteName,
				this.sitePhone,
				this.id});
	
	Map<String, dynamic> toMap() {
		return {
					'id': id,
					'siteName': siteName,
					'sitePhone': sitePhone,
					};
			}
			
	
	static VaxSite fromMap(Map<String, dynamic> map, String documentId) {
		if (map==null) return null;
		return VaxSite(
						siteName: map['name'],
						sitePhone: map['sitePhone'],
						id: documentId,
						);
				}

}