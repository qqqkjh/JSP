<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="bbs.BbsDAO" %>  
  <%@ page import="bbs.Bbs" %>  
 <%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> 
 
 
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
		
	}
	
	
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지않은 글입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이없습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}else{
					BbsDAO bbsDAO =new BbsDAO();
					int result = bbsDAO.delete(bbsID);
					
					if(result == -1){//디비오류란건 주키오류 즉 프라이머리키인 아이디가 중복된다는뜻
						PrintWriter script =response.getWriter();
						script.println("<script>");
						script.println("alert('글삭제이 실패함.')");
						script.println("history.back()");
						script.println("</script>");
					}else{
						
						PrintWriter script =response.getWriter();
						script.println("<script>");
						script.println("location.href ='bbs.jsp'");
						script.println("</script>");
						
					}
					
					
					
				
			}		
	
	%>

</body>
</html>