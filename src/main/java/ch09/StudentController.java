package ch09;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

/**
 * Servlet implementation class StudentController
 */
@WebServlet("/studentControl")
public class StudentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	StudentDAO dao;
	
	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		dao = new StudentDAO();
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		String view = "";
		if(request.getParameter("action") == null) {
			getServletContext().getRequestDispatcher("/studentControl?action=list")
			.forward(request, response);
		}else {
			switch(action) {
			case "list":
				view = list(request,response);
				break;
			case "insert":
				view = insert(request,response);
				break;
			case "delete":
				view = delete(request,response);				
				break;
			}
						
			getServletContext().getRequestDispatcher("/ch09/"+view).forward(request, response);
		}
	}
	
	public String list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("students", dao.getAll());
		return "studentInfo.jsp";
	}
	
	public String insert(HttpServletRequest request, HttpServletResponse response) {
		Student s = new Student();
		try {
			BeanUtils.populate(s, request.getParameterMap());
		}catch(Exception e) {			
			e.printStackTrace();
		}		
		dao.insert(s);
		return list(request, response);
	}
	
	public String delete(HttpServletRequest request, HttpServletResponse response) {
		String _id = request.getMethod().equals("GET") ? request.getParameter("id") : null;
		
		try {
			int id = Integer.parseInt(_id);			
			request.setAttribute("deleted", dao.delete(id));
		}catch(NumberFormatException e) {
			request.setAttribute("deleted", false);
		}
		
		return list(request, response);
	}
}
