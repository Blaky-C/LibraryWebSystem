<%@page import="java.sql.ResultSet"%>
<%@page import="condb.ConOra"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Index</title>
    <!-- 新 Bootstrap4 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <!-- popper.min.js 用于弹窗、提示、下拉菜单 -->
    <script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
    <!-- 最新的 Bootstrap4 核心 JavaScript 文件 -->
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <%
    	String user_name=null;
    	String user_id =null;
    	if (session.getAttribute("user_id")!=null){
    		user_id = session.getAttribute("user_id").toString();
    		ConOra condb = new ConOra();
        	condb.getCon();
        	condb.getStatement();
        	String sql = "select * from user_info where user_id='"+user_id+"'";
    		condb.query(sql);
    		ResultSet result = condb.getResult();
    		result.next();
    		user_name = result.getString("user_name");
    	}
    	boolean if_norm=true;
    	if (session.getAttribute("privilege")!=null){
    		if_norm = (session.getAttribute("privilege").toString().equals("NORM"));
    	}
    %>
    <script type="text/javascript">
    	function show_privilege(){
    		alert("所在用户权限不可见。");
    	}
    </script>
</head>
<body style="background-image: url(img/bg.jpg)">
<div class="container">
    <br><br>
    <header class="header clearfix">
        <%
    	if (user_id!=null){
    		%>
		        <nav>
		            <ul class="nav nav-pills float-right">
		                <li class="nav-item">
		                     <span class="nav-link">欢迎,&nbsp;<span class="text-primary"><%=user_name %></span></span>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link text-danger" href="./SignOutServlet?user_id=<%=user_id %>">退出</a>
		                </li>
		            </ul>
		        </nav>
    		<%
    	}else{
    		%>
	    	<nav>
	            <ul class="nav nav-pills float-right">
	                <li class="nav-item">
	                    <a class="nav-link" href="sign_in.jsp">登录</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="sign_up.jsp">注册</a>
	                </li>
	            </ul>
	        </nav>
    		<%
    	}
    	%>
        <h1 class="text-dark">图书管理系统</h3><br>
    </header>

    <nav class="navbar navbar-expand-sm bg-dark navbar-dark inlie" role="navigation">
        <ul class="nav nav-pills" role="tablist">
            <li class="nav-item">
                <a href="index.jsp" class="nav-link text-white">首页</a>
            </li>
            <li class="nav-item">
                <a href="search.jsp" class="nav-link text-white active">图书查询</a>
            </li>
            <li class="nav-item">
                <%
            		if (if_norm){
            			%>
		            	<a href="account.jsp" class="nav-link text-white">我的图书馆</a> 
            			<%
            		}else{
            			%>
                		<a href="#" class="nav-link text-white" onclick="show_privilege()">我的图书馆</a>          
            			<%
            		}
            	%>
            </li>
            <li class="nav-item">
            	<%
            		if (if_norm){
            			%>
		            	<a href="#" class="nav-link text-white" onclick="show_privilege()">管理员权限</a> 
            			<%
            		}else{
            			%>
                		<a href="admin.jsp" class="nav-link text-white">管理员权限</a>          
            			<%
            		}
            	%>
            </li>
        </ul>        
    </nav>
    
    <br><br>
    <form action="search_result.jsp" method="post" class="form-inline mt-2 mt-md-0">
    	<legend>图书检索</legend>
        <input type="text" name="search_content" placeholder="请输入查询内容..." class="form-control mr-sm-2">
        <button class="btn btn-primary my-2 my-sm-0" type="submit">&nbsp;查询&nbsp;</button>
    </form>
</div>   

 
 
</body>
</html>