package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import condb.ConOra;

/**
 * Servlet implementation class ChangePrivilegeServlet
 */
@WebServlet("/ChangePrivilegeServlet")
public class ChangePrivilegeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ConOra cdb = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePrivilegeServlet() {
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
		
		String user_id = request.getParameter("user_id").toString();
		cdb = new ConOra();
		cdb.getCon();
		cdb.getStatement();
		String sql = "select * from user_info where user_id='"+user_id+"'";
		cdb.query(sql);
		ResultSet result = cdb.getResult();
		String privilege = null;
		try {
			result.next();
			privilege = result.getString("privilege");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(privilege);
		String new_privilege = null;
		if (privilege.equals("ADMIN")) {
			new_privilege = "NORM";
		}else {
			new_privilege = "ADMIN";
		}
		
		System.out.println(new_privilege);
		sql = "update user_info set privilege='"+new_privilege+"' where user_id='"+user_id+"'";
		
		PrintWriter out = response.getWriter();
		
		cdb.update(sql);
		
		out.print("<script type=\"text/javascript\">");
		out.print("	alert('用户权限已更改。');");
		out.print("	window.location.href='user_info.jsp';");
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
