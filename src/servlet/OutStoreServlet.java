package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
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
 * Servlet implementation class OutStoreServlet
 */
@WebServlet("/OutStoreServlet")
public class OutStoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ConOra cdb = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OutStoreServlet() {
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
		
		String book_id = request.getParameter("book_id").toString();
		
		cdb = new ConOra();
		cdb.getCon();
		cdb.getStatement();
		
		HttpSession session = request.getSession();
		String user_id = session.getAttribute("user_id").toString();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Calendar c = Calendar.getInstance();
		String remove_date = sdf.format(c.getTime());
		
		PrintWriter out = response.getWriter();
		String sql = "update book_info set if_in_store='0', remove_date='"+remove_date+"', remove_admin_id='"+user_id+"' where book_id='"+book_id+"'";
		cdb.update(sql);
		out.print("<script type=\"text/javascript\">");
		out.print("	alert('图书出库成功。');");
		out.print("	window.location.href='check_out_store.jsp';");
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
