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
if(id == null){
%>{"status": -1, "msg": "로그인부터 하세요"}	   
<%  return;
}

  OrderService service = OrderService.getInstance();
  String json = "{";
  try{
  	List<OrderInfo> infos = service.findById(id);
  	json += "\"status\":1";
  	json +=", \"infos\":[";
  	for(int i=0; i<infos.size(); i++) {
  		OrderInfo info = infos.get(i);
  		if(i != 0){
  			json += ",";
  		}
  		json += "{";
  		json += "\"order_no\":" + info.getOrder_no();
  		json += ", \"order_dt\":\"" + info.getOrder_dt() +"\"";
  		json += ", \"lines\":[";
  		
		List<OrderLine> lines = info.getLines();
		System.out.println(lines.size());
		for(int j=0; j< lines.size(); j++) {
			OrderLine line = lines.get(j);
			if(j != 0){
	  			json += ",";
	  		}
			Product p = line.getOrder_product();
			int order_quantity = line.getOrder_quantity();
			json += "{";
			json += p;
			json += ", \"order_quantity\":" + order_quantity;
			json += "}";
		}
		json += "]";
  		json += "}";
		
	}
  	json += "]";
  }catch(Exception e){
	  json += "\"status\":-1, \"msg\":\""+e.getMessage()+"\"";  
  }
  json += "}";
%><%=json%>