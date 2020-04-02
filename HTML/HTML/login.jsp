<%@page import="com.my.exception.NotFoundException"%>
<%@page import="com.my.service.CustomerService"%>
<%@ page language="java" 
      contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 String id = request.getParameter("id"); 
 String pwd = request.getParameter("pwd");
 CustomerService service = CustomerService.getInstance();
 try{
 	service.login(id, pwd);
 	session.setAttribute("loginInfo", id);

 	System.out.println("로그인성공" + session.getAttribute("loginInfo"));
%>{"status":1}<% 	
 }catch(NotFoundException e){
%>{"status":-1}
<%
}%>