package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import condb.ConOra;

/**
 * Servlet implementation class SignUpServlet
 */
@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ConOra cdb = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUpServlet() {
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
		String regID = request.getParameter("user_id").toString();
		String regUN= request.getParameter("user_name").toString();
		String regPW= request.getParameter("user_pwd").toString();
		System.out.print(regID+regUN+regPW);
		cdb = new ConOra();
		cdb.getCon();
		cdb.getStatement();
		String sql = "select * from user_info where user_id='"+regID+"'";
		System.out.println(cdb.getNum());
		cdb.query(sql);
		ResultSet result = cdb.getResult();
		PrintWriter out = response.getWriter();
		try {
			if (result.next()){
				out.print("<script type=\"text/javascript\">");
				out.print("	alert('该用户已被注册，请重新注册');");
				out.print("	window.location.href='sign_up.jsp';");
				out.print("</script>");
			}
			else
			{
				String str = "insert into user_info values('"+regID+"', '"+regUN+"', '"+regPW+"', 'NORM')";
				cdb.update(str);
				out.print("<script type=\"text/javascript\">");
				out.print("	alert('注册成功，请登录');");
				out.print("	window.location.href='sign_in.jsp';");
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

	@Override
	public void destroy() {
		super.destroy();
		cdb.close();
	}
}
