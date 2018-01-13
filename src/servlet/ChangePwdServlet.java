package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import condb.ConOra;

/**
 * Servlet implementation class ChangePwdServlet
 */
@WebServlet("/ChangePwdServlet")
public class ChangePwdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ConOra cdb = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePwdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTf-8");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		String pwd = request.getParameter("pwd").toString();
		
		System.out.println("************************修改密码开始***************************");
		HttpSession session = request.getSession();
		String user_id = session.getAttribute("user_id").toString();
		
		cdb = new ConOra();
		cdb.getCon();
		cdb.getStatement();
		String sql ="update user_info set user_pwd='"+pwd+"' where user_id='"+user_id+"'";
		System.out.println(cdb.getNum());
		cdb.update(sql);
		PrintWriter out = response.getWriter();
		out.print("<script type=\"text/javascript\">");
		out.print("	alert('修改成功，请重新登录。');");
		out.print("	window.location.href='sign_in.jsp';");
		out.print("</script>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
