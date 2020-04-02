<%@page import="com.my.vo.Customer"%>
<%@page import="com.my.exception.AddException"%>
<%@page import="com.my.service.OrderService"%>
<%@page import="com.my.dao.OrderDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.my.vo.OrderLine"%>
<%@page import="com.my.vo.OrderInfo"%>
<%@page import="com.my.vo.Product"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String id = (String)session.getAttribute("loginInfo");

System.out.println(id);
if(id == null){
%>{"status": -1, "msg": "로그인부터 하세요"}	   
<%  return;
}

Map<Product, Integer>cart = (Map)session.getAttribute("cart");
if(cart == null){
%>{"status": -1, "msg":"장바구니가 비었습니다"}

<%
  return;
}else{
  OrderInfo info = new OrderInfo();
  Customer c = new Customer();
  c.setId(id);
  info.setOrder_customer(c);
  List<OrderLine>lines = new ArrayList<>();
  for(Product p: cart.keySet()){
	  OrderLine line = new OrderLine();
	  line.setOrder_product(p);
	  line.setOrder_quantity(cart.get(p));
	  lines.add(line);
  }
  info.setLines(lines);
  OrderService service = OrderService.getInstance();
  try{
  	service.addOrder(info);
  	session.removeAttribute("cart");
%>  {"status": 1, "msg":"주문성공"}
<%}catch(AddException e){
%>  {"status": -1, "msg":"<%=e.getMessage()%>"}
<%}
}%>