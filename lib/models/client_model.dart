import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


class ClientModel {
	final String id;
	final String userName;
	final String userPhone;
	
	
	ClientModel({
				this.id,
				this.userName,
				this.userPhone,
				
				});
	
	Map<String, dynamic> toMap() {
		return {
					'id': id,
					'userName': userName,
					'userPhone': userPhone,
					
					};
			}
			
	
	static ClientModel fromMap(Map<String, dynamic> map, String documentId) {
		if (map==null) return null;
		return ClientModel(
						userName: map['name'],
						userPhone: map['phone'],
						
						id: documentId,
						);
				}

}