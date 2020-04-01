<%@page import="com.my.service.ProductService"%><%@page import="java.util.HashMap"%>
<%@page import="com.my.vo.Product"%><%@page import="java.util.Map"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%><%response.setHeader("Access-Control-Allow-Origin", "*");
    %><%
String prod_no = request.getParameter("prod_no");
String sQuantity = request.getParameter("quantity");

if(prod_no == null || prod_no.equals("")|| sQuantity == null ||sQuantity.equals("")){
%>{"status": -1, "msg": "상품번호와 수량을 정확히 입력하세요"}
<%
return;
} 
int quantity = Integer.parseInt(sQuantity);
ProductService service = ProductService.getInstance();
Product p = service.findByNo(prod_no);
Map<Product, Integer> cart = (Map)session.getAttribute("cart");
if(cart == null){
	cart = new HashMap<>();
	session.setAttribute("cart", cart);
}
Integer oldQuantity = (Integer)cart.get(p);
if(oldQuantity != null){
	quantity += oldQuantity;
}
cart.put(p, quantity);
%>
{"status":1, "msg": "장바구니에 넣었습니다."}