<%@page import="com.my.vo.Product"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%><%response.setHeader("Access-Control-Allow-Origin", "*");
    %>
<%
Map<Product, Integer>cart = (Map)session.getAttribute("cart");
if(cart != null){
   int cnt=0;
%>{"status": 1,"products":[
<% for(Product p: cart.keySet()){%>
     {<%=p%>, "quantity": <%=cart.get(p) %>}   
     <%if(!(cnt++ + 1 == cart.size()))%>,
<% }//end for
%>]}   
<%}else{%>   
{"status":-1, "msg":"장바구니가 비었습니다"}   
<%}
%>