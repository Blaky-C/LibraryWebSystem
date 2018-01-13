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
    	String user_id = null;
    	String user_name = null;
    	ConOra condb = null;
    	String sql = null;
    	ResultSet result = null;
    	if (session.getAttribute("user_id")!=null){
    		user_id = session.getAttribute("user_id").toString();
        	condb = new ConOra();
        	condb.getCon();
        	condb.getStatement();
        	sql = "select * from user_info where user_id='"+user_id+"'";
    		condb.query(sql);
    		result = condb.getResult();
    		result.next();
    		user_name = result.getString("user_name");
    	}else{
    		RequestDispatcher  rd = request.getRequestDispatcher("sign_in.jsp");  
    		rd.forward(request, response);  
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
                <a href="account.jsp" class="nav-link text-white active">我的图书馆</a>
            </li>
            <li class="nav-item">
                <a href="#" onclick="show_privilege()" class="nav-link text-white">管理员权限</a>
            </li>
        </ul>        
    </nav>
    
    <br>
    <div class="container-fluid">
        <div class="row">
            <nav class="col-sm-3 col-md-2 hidden-xs-down bg-faded sidebar">
                <ul class="nav nav-pills flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="account.jsp">我的首页</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="borrow_record.jsp">当前借阅</a>
                    </li>
                </ul>
            </nav>

            <main class="col-sm-9 offset-sm-3 col-md-10 offset-md-2 pt-3">
                <h3>个人信息</h3>
                <br>
                <section class="row text-center placeholders">
                    <div class="col-sm-2 placeholder">
                        <img src="<%=(user_id.equals("2010150211")?"img/mitoliya.png":"img/head.jpg") %>" width="200" height="200" class="rounded-circle" alt="用户头像">
                    </div>
                  
                  
                    <div class="col-sm-5 placeholder">
                        <h2><%=user_name %></h2>
                        
                    </div>

                    <div class="col-sm-1 placeholder">
                        <button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#myModal">修改密码</button>
                    </div>

				  	<!-- 模态框 -->
				  	<div class="modal fade" id="myModal">
				    	<div class="modal-dialog modal-sm">
				      		<div class="modal-content">
				        		<!-- 模态框头部 -->
				        		<div class="modal-header">
					          		<h4 class="modal-title">输入</h4>
					          		<button type="button" class="close" data-dismiss="modal">&times;</button>
				        		</div>
					        	<!-- 模态框主体 -->
					        	<div class="modal-body">
									<form method="post" action="ChangePwdServlet">
						  				<div class="form-group">
						   				 	<label for="pwd" class="sr-only">新密码:</label>
						   				 	<input type="password" name="pwd" class="form-control" id="pwd" placeholder="输入新密码">
						  				</div>
						  				<button type="submit" class="btn btn-primary">提交</button>
									</form> 
							 	</div>
					     	</div>
					  	</div>
				  	</div>
                </section>

                <br><br>
                <h3>借阅情况</h3>
                <br>
                <table class="table table-light table-responsive col-sm-6 table-hover" style="display: inline">
                    <thead>
                        <tr class="bg-danger">
                            <th colspan="2" class="text-white">超期图书</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    	sql = "select * from book_info where user_id='"+user_id+"' and if_exceed=1";
                		condb.query(sql);
                		result = condb.getResult();
                		while (result.next()){
                			%>
                				<tr>
                					<td><small><%=result.getString("book_name") %></small></td>
                            		<td><small><%=result.getString("return_date") %></small></td>
                        		</tr>
                			<%
                		}
                    %>
                    	<tr>
                			<td><small>---</small></td>
                        	<td><small>---</small></td>
                        </tr>
                    </tbody>
                </table>
                <table class="table table-light table-responsive col-sm-6 table-hover" style="display: inline">
                    <thead>
                        <tr class="bg-primary">
                            <th colspan="2" class="text-white">借阅图书</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    	sql = "select * from book_info where user_id='"+user_id+"' and if_exceed=0";
                		condb.query(sql);
                		result = condb.getResult();
                		while (result.next()){
                			%>
                				<tr>
                					<td><small><%=result.getString("book_name") %></small></td>
                            		<td><small><%=result.getString("return_date") %></small></td>
                        		</tr>
                			<%
                		}
                    %>
                    	<tr>
                			<td><small>---</small></td>
                        	<td><small>---</small></td>
                        </tr>
                    </tbody>
                </table>
            </main>
        </div>
    </div>
	<br><br><br><br><br><br>    
</div>    
<%
	condb.close();
%> 
</body>
</html>