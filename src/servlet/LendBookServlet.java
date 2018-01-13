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
 * Servlet implementation class LendBookServlet
 */
@WebServlet("/LendBookServlet")
public class LendBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ConOra cdb = null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LendBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setCharacterEncoding("UTf-8");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		if (session.getAttribute("user_id")==null) {
			out.print("<script type=\"text/javascript\">");
			out.print("	alert('借书请先登录。');");
			out.print("	window.location.href='sign_in.jsp';");
			out.print("</script>");
		}else {
			String user_id = session.getAttribute("user_id").toString();
			String book_id = request.getParameter("book_id").toString();
			
			System.out.println("************************连接数据库开始***************************");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			Calendar c = Calendar.getInstance();
			String lend_date = sdf.format(c.getTime());
			c.add(Calendar.DATE, 30);
			String return_date = sdf.format(c.getTime());
			
			cdb = new ConOra();
			cdb.getCon();
			cdb.getStatement();
			String sql ="update book_info set if_lended='1', user_id='"+user_id+"', lend_date='"+lend_date+"', return_date='"+return_date+"' where book_id='"+book_id+"'";
			cdb.update(sql);
			
			out.print("<script type=\"text/javascript\">");
			out.print("	alert('借书成功。');");
			out.print("	window.location.href='search.jsp';");
			out.print("</script>");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
