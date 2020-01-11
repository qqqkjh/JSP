package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt; //sql 인젝션해킹방지하기위해서 이용 
	private ResultSet rs; //실행한결과를 담을수잇는 필드
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";      
			String dbID = "root"; //루트계정접속
			String dbPassword = "qwer1234";//루트계정 비밀번호
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 
			}catch(Exception e) {
			e.printStackTrace();
		}
	}//mysql 접속하기

	public int login(String userID, String userPassword) {
		String SQL= "SELECT userPassword FROM USER WHERE userID = ?"; //패스워드가져오기 
		try {
			pstmt= conn.prepareStatement(SQL);//SQL물불러와서
			pstmt.setString(1, userID);//매개변수로 들어온(1)을 ?에 해당하는 내용으로 넣어줌 즉 userID= 매개변수 같은효과로 쿼리검색
			rs = pstmt.executeQuery();
			if(rs.next()) {//next 실행결과가 있으면 true반환
				if(rs.getString(1).equals(userPassword))//쿼리에의한 결과물즉 비번이 매개변수로온 비번과 일치하면 통과 (즉 1반환) 
					return 1;//로그인성공
				else
					return 0; //비번 불일치
					
			}
			return -1; //아이디가없다 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;//디비오류
	}
	public int join(User user) {
		String SQL ="INSERT INTO USER VALUES(?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserGander());
			pstmt.setString(4, user.getUserName());
			pstmt.setString(5, user.getUserEmail());
			return pstmt.executeUpdate();//성공시0반환?
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스오류
	}
	
}
