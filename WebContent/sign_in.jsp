<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Sign in</title>
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
    	  background-color: #eee;
    	}

    	.form-signin {
    	  max-width: 330px;
    	  padding: 15px;
    	  margin: 0 auto;
    	}
    	.form-signin .form-signin-heading,
    	.form-signin .checkbox {
    	  margin-bottom: 10px;
    	}
    	.form-signin .checkbox {
    	  font-weight: normal;
    	}
    	.form-signin .form-control {
    	  position: relative;
    	  height: auto;
    	  -webkit-box-sizing: border-box;
    	          box-sizing: border-box;
    	  padding: 10px;
    	  font-size: 16px;
    	}
    	.form-signin .form-control:focus {
    	  z-index: 2;
    	}
    	.form-signin input[type="email"] {
    	  margin-bottom: -1px;
    	  border-bottom-right-radius: 0;
    	  border-bottom-left-radius: 0;
    	}
    	.form-signin input[type="password"] {
    	  margin-bottom: 10px;
    	  border-top-left-radius: 0;
    	  border-top-right-radius: 0;
    	}
    </style>
    <%
    	String user_id = "";
    	String user_pwd = "";
    	String if_reme = "";
    	Cookie[] cookies = request.getCookies();
    	if (cookies!=null){
    		for (Cookie c: cookies){
    			if (c.getName().equals("remember_user_id")){
    				user_id = c.getValue();
    				System.out.print(user_id);
    			}
    			if (c.getName().equals("remember_user_pwd")){
    				user_pwd = c.getValue();
    			}
    			if (c.getName().equals("if_reme")){
    				if_reme = c.getValue();
    			}
    		}
    	}
    	%>
    		<script type="text/javascript">
    			window.onload=function(){
    				document.getElementById("inputID").value=<%=user_id %>;
    				document.getElementById("inputPassword").value=<%=user_pwd %>;	
    				document.getElementById("remember").checked=<%=if_reme.equals("true")?"true":"false" %>
    			}
    		</script>
    	<%
    %>
</head>

<body style="background-image: url(img/bg.jpg)">
    <div class="container">
        <form class="form-signin" method="post" action="SignInServlet">
      		<h2 class="form-signin-heading">用户登录</h2>
      		<label for="inputID" class="sr-only">用户ID</label>
      		<input type="text" name="user_id" id="inputID" class="form-control" placeholder="用户ID" required autofocus>
      		<label for="inputPassword" class="sr-only">密码</label>
      		<input type="password" name="user_pwd" id="inputPassword" class="form-control" placeholder="密码" required>
      		<div class="checkbox">
          		<label>
          			<input type="checkbox" name="remember" id="remember" value="remember-me">记住密码
        		</label>
      		</div>
      		<button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
    	</form>
  	</div>
</body>
</html>
  