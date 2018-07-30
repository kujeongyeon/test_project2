<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	String idValue = request.getParameter("id");

	Connection conn = null;
	PreparedStatement pstmtItem = null;
	PreparedStatement pstmtDetail = null;

	String jdbcDriver = "jdbc:mysql://localhost:3306/project?serverTimezone=UTC&"+
			   "useUnicode=true&characterEncoding=utf8";
				String dbUser = "jspexam";
				String dbPass = "jsppw";
	
	Throwable occuredException = null;
	
	try{
		int id = Integer.parseInt(idValue);
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		conn.setAutoCommit(false); //트랜잭션 시작
		
		pstmtItem = conn.prepareStatement("insert into ITEM values (?,?)");
		pstmtItem.setInt(1,id);
		pstmtItem.setString(2,"상품이름"+id);
		pstmtItem.executeUpdate();
		
		if(request.getParameter("error")!= null){
			throw new Exception("의도적 익셉션 발생");
		}
		pstmtDetail = conn.prepareStatement("insert into ITEM_DETAiL values(?,?)");
		pstmtDetail.setInt(1, id);
		pstmtDetail.setString(2,"상세설명"+id);
		pstmtDetail.executeUpdate();
		
		conn.commit();//트랜잭션 커밋
	}catch(Throwable e){
		if(conn != null){
			try {
				conn.rollback();
			}catch(SQLException ex){}
		}
		occuredException = e;
	}finally{
		if(pstmtItem != null)
			try {pstmtItem.close();}catch(SQLException ex){}
		if(pstmtDetail != null)
			try {pstmtDetail.close();}catch(SQLException ex){}
		if (conn != null) try {conn.close();}catch(SQLException ex){}
	}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>값입력</title>
</head>
<body>
<% if(occuredException != null) {%>
에러가 발생하였습니다: <%=occuredException.getMessage() %>
<%  }else{ %>
데이터가 성공적으로 들어감
<% } %>
</body>
</html>