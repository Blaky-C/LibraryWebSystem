package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import condb.ConOra;

/**
 * Servlet implementation class SignInServlet
 */
@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ConOra cdb = new ConOra();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignInServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");

		String userId = request.getParameter("user_id").toString();
		String userPwd = request.getParameter("user_pwd").toString();
		System.out.print(userId + userPwd);
		boolean if_remember = false;
		if (request.getParameterValues("remember")!=null) {
			if_remember = true;
		}
		System.out.println(if_remember);
		if (if_remember) {
			Cookie reme_name = new Cookie("remember_user_id", userId);
			Cookie reme_pwd = new Cookie("remember_user_pwd", userPwd);
			Cookie if_reme = new Cookie("if_reme", "true");
			reme_name.setMaxAge(60*60*5);
			reme_pwd.setMaxAge(60*60*5);
			if_reme.setMaxAge(60*60*5);
			response.addCookie(reme_name);
			response.addCookie(reme_pwd);
			response.addCookie(if_reme);
		}else {
			Cookie[] cookies=request.getCookies();  
            for(Cookie c:cookies){  
                if(c.getName().equals("remember_user_id")||c.getName().equals("remember_user_pwd")||c.getName().equals("if_reme")){  
                    c.setMaxAge(0);//设置cookie失效  
                    response.addCookie(c);
                }  
            }  
		}
		
		ConOra cdb = new ConOra();
		cdb.getCon();
		cdb.getStatement();
		String sql = "select * from user_info where user_id='"+userId+"' and user_pwd='"+userPwd+"'";
		cdb.query(sql);
		ResultSet result = cdb.getResult();
		PrintWriter out = response.getWriter();
		try {
			if (result.next()){
				System.out.println("账户匹配成功。");
				HttpSession session = request.getSession();
				session.setAttribute("user_id", userId);
				session.setMaxInactiveInterval(20*60);
				
				String privilege = result.getString("privilege");
				session.setAttribute("privilege", privilege);
				System.out.println(privilege);
				if (privilege.equals("NORM")) {
					response.sendRedirect("account.jsp");
				}else {
					response.sendRedirect("admin.jsp");
				}
				
			}else{
				out.print("<script type=\"text/javascript\">");
				out.print("	alert('登录失败，请重新登录。');");
				out.print("	window.location.href='sign_in.jsp';");
				out.print("</script>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	@Override
	public void destroy() {
		super.destroy();
		cdb.close();
	}

}
