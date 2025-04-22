package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class ThankyouServlet
 */
@WebServlet("/thank-you")
public class ThankyouServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThankyouServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Check if this is a redirect from a form submission
		String formType = request.getParameter("type");
		
		if (formType != null) {
			request.setAttribute("formType", formType);
		} else {
			// Default to contact form if no type specified
			request.setAttribute("formType", "contact");
		}
		
		// Forward to thank you page
		request.getRequestDispatcher("/user/thankyou.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Use the same handler as GET
		doGet(request, response);
	}

}
