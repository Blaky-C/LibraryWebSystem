package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import condb.ConOra;

/**
 * Servlet implementation class ClearUserServlet
 */
@WebServlet("/ClearUserServlet")
public class ClearUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ConOra cdb = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClearUserServlet() {
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
		
		PrintWriter out = response.getWriter();
		String sql = "delete from user_info where user_id='"+user_id+"'";
		
		cdb = new ConOra();
		cdb.getCon();
		cdb.getStatement();
		cdb.update(sql);
		sql = "delete from book_info where user_id="+user_id+"'";
		cdb.update(sql);
		out.print("<script type=\"text/javascript\">");
		out.print("	alert('该用户已注销。');");
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
