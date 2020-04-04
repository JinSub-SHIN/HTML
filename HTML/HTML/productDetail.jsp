<%@page import="com.my.exception.NotFoundException"%><%@page import="com.my.service.ProductService"%>
<%@page import="com.my.vo.Product"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%><%response.setHeader("Access-Control-Allow-Origin", "*");
    %><%
String prod_no = request.getParameter("prod_no");
ProductService service = ProductService.getInstance();

if(prod_no == null || prod_no.equals("")){%>
	{"status": -1, "msg":"상품번호가 없습니다"}
<%
}else{
 try{
	 Product p = service.findByNo(prod_no);
  %>{"status": 1, <%=p%>}
<%}catch(NotFoundException e){%>
  {"status": -1, "msg":"<%=e.getMessage()%>"}
<%	
  }
}
%>