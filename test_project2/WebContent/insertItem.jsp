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
		conn.setAutoCommit(false); //Ʈ����� ����
		
		pstmtItem = conn.prepareStatement("insert into ITEM values (?,?)");
		pstmtItem.setInt(1,id);
		pstmtItem.setString(2,"��ǰ�̸�"+id);
		pstmtItem.executeUpdate();
		
		if(request.getParameter("error")!= null){
			throw new Exception("�ǵ��� �ͼ��� �߻�");
		}
		pstmtDetail = conn.prepareStatement("insert into ITEM_DETAiL values(?,?)");
		pstmtDetail.setInt(1, id);
		pstmtDetail.setString(2,"�󼼼���"+id);
		pstmtDetail.executeUpdate();
		
		conn.commit();//Ʈ����� Ŀ��
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
<title>���Է�</title>
</head>
<body>
<% if(occuredException != null) {%>
������ �߻��Ͽ����ϴ�: <%=occuredException.getMessage() %>
<%  }else{ %>
�����Ͱ� ���������� ��
<% } %>
</body>
</html>