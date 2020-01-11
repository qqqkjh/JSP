<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="bbs.BbsDAO" %>  
 <%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> 
 <jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
 <jsp:setProperty name="bbs" property="bbsTitle"/> 
 <jsp:setProperty name="bbs" property="bbsContent"/>
 
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
		if(userID ==null){
			PrintWriter script =response.getWriter();
			script.println("<script>");
			script.println("alert('로그인하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			
		}else{
			if(bbs.getBbsTitle()==null||bbs.getBbsContent()==null){
						PrintWriter script =response.getWriter();
						script.println("<script>");
						script.println("alert('입력이안된사항이있습니다.')");
						script.println("history.back()");
						script.println("</script>");
					}else{
						BbsDAO bbsDAO =new BbsDAO();
						int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
						
						if(result == -1){//디비오류란건 주키오류 즉 프라이머리키인 아이디가 중복된다는뜻
							PrintWriter script =response.getWriter();
							script.println("<script>");
							script.println("alert('글쓰기에 실패함 .')");
							script.println("history.back()");
							script.println("</script>");
						}else{
							
							PrintWriter script =response.getWriter();
							script.println("<script>");
							script.println("location.href ='bbs.jsp'");
							script.println("</script>");
							
						}
							
		}
		
			
			
		
	}
	%>

</body>
</html>