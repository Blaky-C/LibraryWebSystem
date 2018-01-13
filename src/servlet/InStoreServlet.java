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
 * Servlet implementation class InStoreServlet
 */
@WebServlet("/InStoreServlet")
public class InStoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ConOra cdb = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InStoreServlet() {
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
		String book_name = request.getParameter("book_name").toString();
		String author = request.getParameter("author").toString();
		
		cdb = new ConOra();
		cdb.getCon();
		cdb.getStatement();
		
		HttpSession session = request.getSession();
		String user_id = session.getAttribute("user_id").toString();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Calendar c = Calendar.getInstance();
		String store_date = sdf.format(c.getTime());
		
		String sql = "select * from book_info where book_id='"+book_id+"'";
		System.out.println(cdb.getNum());
		cdb.query(sql);
		ResultSet result = cdb.getResult();
		PrintWriter out = response.getWriter();
		try {
			if (result.next()){
				out.print("<script type=\"text/javascript\">");
				out.print("	alert('该图书已存在！');");
				out.print("	window.location.href='action_in_store.jsp';");
				out.print("</script>");
			}
			else
			{
				sql = "insert into book_info values('"+book_id+"', '"+book_name+"', '"+author+"', '1', '0', '/', '/', '/', '0', '"+store_date+"', '"+user_id+"', '/', '/')";
				cdb.update(sql);
				out.print("<script type=\"text/javascript\">");
				out.print("	alert('图书入库成功。');");
				out.print("	window.location.href='check_in_store.jsp';");
				out.print("</script>");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
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

}
