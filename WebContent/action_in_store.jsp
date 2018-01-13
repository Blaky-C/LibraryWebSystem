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
    <style type="text/css">
    	body {
    	  padding-top: 40px;
    	  padding-bottom: 40px;
    	}

    	.form-signin {
    	  max-width: 330px;
    	  padding: 15px;
    	  margin: 0 auto;
    	}
    </style>
    <%
    	String user_id = session.getAttribute("user_id").toString();
    	ConOra condb = new ConOra();
    	condb.getCon();
    	condb.getStatement();
    	String sql = "select * from user_info where user_id='"+user_id+"'";
		condb.query(sql);
		ResultSet result = condb.getResult();
		result.next();
		String user_name = result.getString("user_name");
    %>
</head>
<body style="background-image: url(img/bg.jpg)">
<div class="container">
    <br><br>
    <header class="header clearfix">
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
        <h1 class="text-dark">图书管理系统</h3><br>
    </header>

    <nav class="navbar navbar-expand-sm bg-dark navbar-dark inlie" role="navigation">
        <ul class="nav nav-pills" role="tablist">
            <li class="nav-item">
                <a href="index.jsp" class="nav-link text-white">首页</a>
            </li>
            <li class="nav-item">
                <a href="search.jsp" class="nav-link text-white">图书查询</a>
            </li>
            <li class="nav-item">
                <a href="account.jsp" class="nav-link text-white">我的图书馆</a>
            </li>
            <li class="nav-item">
                <a href="admin.jsp" class="nav-link text-white active">管理员权限</a>
            </li>
        </ul>        
    </nav>
    <br>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-sm-3 col-md-2 hidden-xs-down bg-faded sidebar">
                <ul class="nav nav-pills flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="admin.jsp">我的首页</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="borrow_record.jsp">当前借阅</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="check_in_store.jsp">入库管理</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="check_out_store.jsp">图书注销</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="user_info.jsp">用户信息管理</a>
                    </li>
                </ul>
            </nav>

            <main class="col-sm-9 offset-sm-3 col-md-10 offset-md-2 pt-3">
                <h3>入库管理</h3>
                <div class="container">
	        		<form class="form-signin" action="InStoreServlet" method="POST">
		        		<label for="inputBookId" class="sr-only">图书编号</label>
		        		<input type="text" name="book_id" id="inputBookrId" class="form-control" placeholder="图书编号" required autofocus><br>
		        	
		        		<label for="inputBookName" class="sr-only">图书名称</label>
		        		<input type="text" name="book_name" id="inputBookName" class="form-control" placeholder="图书名称" required><br>
		
			        	<label for="inputAuthor" class="sr-only">作者</label>
		    	    	<input type="text" name="author" id="inputAuthor" class="form-control" placeholder="作者" required><br>
		        
		        		<button class="btn btn-lg btn-primary btn-block" type="submit">入库</button>
	      			</form>
  				</div>
            </main>
        </div>
    </div>
	<br><br><br><br><br><br>    
</div>    
 
</body>
</html>