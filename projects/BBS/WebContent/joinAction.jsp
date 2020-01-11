<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="user.UserDAO" %>  
 <%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> 
 <jsp:useBean id="user" class="user.User" scope="page"/>
 <jsp:setProperty name="user" property="userID"/> 
 <jsp:setProperty name="user" property="userPassword"/>
 <jsp:setProperty name="user" property="userGander"/>
 <jsp:setProperty name="user" property="userName"/>
 <jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 웹사이트</title>
</head>
<body>
	<% 
		String userID =null;
		if(session.getAttribute("userID")!=null){
			userID= (String) session.getAttribute("userID");
		}
		if(userID !=null){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인되어있음.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
			
		}
		if(user.getUserID()==null||user.getUserPassword()==null||user.getUserGander()==null||
		user.getUserName()==null||user.getUserEmail()==null){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('입력이안된사항이있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			UserDAO userDAO =new UserDAO();
			int result = userDAO.join(user);
			
			if(result == -1){//디비오류란건 주키오류 즉 프라이머리키인 아이디가 중복된다는뜻
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("alert('이미존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				session.setAttribute("userID", user.getUserID());
				PrintWriter script =response.getWriter();
				script.println("<script>");
				script.println("location.href ='main.jsp'");
				script.println("</script>");
				
			}
			
			
			
		
	}
	%>

</body>
</html>