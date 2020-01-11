package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt; //sql ��������ŷ�����ϱ����ؼ� �̿� 
	private ResultSet rs; //�����Ѱ���� �������մ� �ʵ�
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";      
			String dbID = "root"; //��Ʈ��������
			String dbPassword = "qwer1234";//��Ʈ���� ��й�ȣ
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 
			}catch(Exception e) {
			e.printStackTrace();
		}
	}//mysql �����ϱ�

	public int login(String userID, String userPassword) {
		String SQL= "SELECT userPassword FROM USER WHERE userID = ?"; //�н����尡������ 
		try {
			pstmt= conn.prepareStatement(SQL);//SQL���ҷ��ͼ�
			pstmt.setString(1, userID);//�Ű������� ����(1)�� ?�� �ش��ϴ� �������� �־��� �� userID= �Ű����� ����ȿ���� �����˻�
			rs = pstmt.executeQuery();
			if(rs.next()) {//next �������� ������ true��ȯ
				if(rs.getString(1).equals(userPassword))//���������� ������� ����� �Ű������ο� ����� ��ġ�ϸ� ��� (�� 1��ȯ) 
					return 1;//�α��μ���
				else
					return 0; //��� ����ġ
					
			}
			return -1; //���̵𰡾��� 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;//������
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
			return pstmt.executeUpdate();//������0��ȯ?
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽�����
	}
	
}