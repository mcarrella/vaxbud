import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
	static SharedPreferences _sharedPrefs;
	
	init() async {
		if (_sharedPrefs == null) {
			_sharedPrefs = await SharedPreferences.getInstance();
			}
		}
		
	String get uid => _sharedPrefs.getString(keyUid) ?? "";
	String get role => _sharedPrefs.getString(keyRole) ?? "";
	String get adminSiteId => _sharedPrefs.getString(keySiteId) ?? "";
	String get pendingRequest => _sharedPrefs.getString(keyPending) ?? "";
	
	set uid(String value) {
		_sharedPrefs.setString(keyUid, value);
		}
		
	set role(String value) {
		_sharedPrefs.setString(keyRole, value);
		}
		
	set adminSiteId(String value) {
		_sharedPrefs.setString(keySiteId, value);
		}
		
	set pendingRequest(String value) {
		_sharedPrefs.setString(keyPending, value);
	}
	}
	
final sharedPrefs = SharedPrefs();
const String keyUid = "key_uid";
const String keyRole = "key_role";
const String keySiteId = "key_siteid";
const String keyPending = "key_pending";