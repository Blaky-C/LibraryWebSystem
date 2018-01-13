<%@page import="java.sql.ResultSet"%>
<%@page import="condb.ConOra"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>Search Result</title>
  	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
  	<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
  	<script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
  	<script src="https://cdn.bootcss.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
  	<script type="text/javascript">
  		window.onload=function(){ 
  			document.getElementById("ul_2").click();
  			document.getElementById("ul_1").click();
  		} 
  	</script>
  	<%
    	String user_name=null;
    	String user_id =null;
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
    
    <br>
	<br>
	
	<%
		request.setCharacterEncoding("UTF-8");
		String search_content = request.getParameter("search_content");
		sql = "select * from book_info where book_name like '%"+search_content+"%'";
		condb = new ConOra();
		condb.getCon();
		condb.getStatement();
	%>
	<!-- 检索结果 -->
	<p>检索到<span id="num" style="color: red;font-weight: bold"></span>条,书名为<span style="color: red;font-weight: bold"><%=search_content %></span>的结果</p>
	<hr>

	<!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
    	<li class="nav-item">
      		<a id="ul_1" class="nav-link active" data-toggle="tab" href="#all">所有图书</a>
    	</li>
    	<li class="nav-item">
      		<a id="ul_2" class="nav-link" data-toggle="tab" href="#unlended">可借图书</a>
    	</li>
  	</ul>
  	<br>
	
	<%! String book_id=null;  %>
	<!-- Tab panes -->
	<div class="tab-content">
	    <div id="all" class="container tab-pane fade"><br>
	    	<%
		    	condb.query(sql);
				result = condb.getResult();
				result.last();
			   	int num = result.getRow();//存储查询到的长度  
			  	%>
			  		<script type="text/javascript">
			  			document.getElementById("num").innerHTML = <%=num %>;
			  			//window.location.reload();
			  		</script>
			  	<%
			  	
			   	//重置ResultSet指针
				result.beforeFirst();
	    		int count = 0;
	    		while (result.next()){
	    			%>
	    			<h5 style="color: blue">
	    			<%
	    				book_id = result.getString("book_id");
	    				out.print((++count)+". "+result.getString("book_name"));
	    			%>
	    			</h5> <br>
	      			<p style="font-weight: bold;">作者：<%=result.getString("author") %> &#160;&#160;<%=result.getString("book_id") %></p>
	      			<%
	      				if (result.getInt("if_lended")==1){
	      					%>
	      					<p style="font-weight: bold;"><span class="text-danger">已借</span> &#160;&#160;&#160;&#160;&#160;应还日期：<%=result.getString("return_date") %></p>
	      					<%
	      				}else{
	      					%>
	      					<span style="font-weight: bold;" class="text-left col-sm-4">未借</span>
	      					<a href="LendBookServlet?book_id=<%=book_id %>" class="btn btn-primary">借书</a>
	      					<%
	      				}
	      			%>
	      			<hr>
	      			<%
	    		}
	    	%>
	   		<script type="text/javascript">
	   			
	   		</script>
	    </div>
	    <div id="unlended" class="container tab-pane fade"><br>
	      	<%
				sql = "select * from book_info where book_name like '%"+search_content+"%' and if_lended = 0";
				condb.query(sql);
				result = condb.getResult();
				result.last();
			   	num = result.getRow();//存储查询到的长度  
			   	%>
		  		<script type="text/javascript">
		  			//document.getElementById("num").innerHTML = <%=num %>;
		  			//window.location.reload();
		  		</script>
		  		<%
			   	//重置ResultSet指针
				result.beforeFirst();
	    		count = 0;
	    		while (result.next()){
	    			book_id = result.getString("book_id").toString();
	    			%>
	    			<h5 style="color: blue">
	    			<%=(++count)+". "+result.getString("book_name") %>
	    			</h5> <br>
	      			<p style="font-weight: bold;">作者：<%=result.getString("author") %> &#160;&#160;<%=result.getString("book_id") %></p>
	      			<span style="font-weight: bold;" class="text-left col-sm-4">未借</span>
	      			<a href="LendBookServlet?book_id=<%=book_id %>" class="btn btn-primary">借书</a>
	      			<hr>
	      			<%
	    		}
	    	%>
	    </div>
	</div>
  	
 	
</div>
<%
	condb.close();	
%>
</body>
</html>