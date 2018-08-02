<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
MEMBER 테이블의 내용
<table width="100%" border="1">
<tr>
	<td>이름</td><td>아이디</td><td>이메일</td>
</tr>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try{
		String jdbcUrl = "jdbc:apache:commons:dbcp:project";

		conn = DriverManager.getConnection(jdbcUrl);

		String query ="select * from MEMBER order by MEMBERID";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		while(rs.next()) {
%>
<tr>
	<td><%=rs.getString("NAME")%></td>
	<td><%=rs.getString("MEMBERID")%></td>
	<td><%=rs.getString("EMAIL")%></td>
</tr>
<%
		}
	}finally {
		if (rs != null) try {rs.close();}catch(SQLException ex) {}
		if (stmt != null) try {stmt.close();}catch(SQLException ex) {}
		if(conn != null) try {conn.close();}catch(SQLException ex) {}
	}
%>
</table>
</body>
</html>