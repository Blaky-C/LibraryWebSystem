package bean;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserInfo {
	private String user_id;
	private String user_name;
	private String user_pwd;
	private String privilege;
	
	public UserInfo() {	}
	
	public UserInfo(ResultSet result) {
		try {
			user_id = result.getString(1);
			user_name = result.getString(2);
			user_pwd = result.getString(3);
			privilege = result.getString(4);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
