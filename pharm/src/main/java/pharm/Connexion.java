package pharm;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import pharm.MedicamentDao;
import pharm.Medicament;
import pharm.Utilisateur;
import pharm.IMedicament;


@WebServlet(name = "cs", urlPatterns = { "/index", "*.html" })
public class Connexion extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UtilisateurDao userDao = new UtilisateurDao();
       
    
    public Connexion() {
        super();
        
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("Index.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String  password = request.getParameter("password");
		String alertMessage = " ";
		if(email == "" && password == "") {
			request.setAttribute("alertMessage", alertMessage);
			request.getRequestDispatcher("Index.jsp").forward(request, response);
			
		}
		else {
			//response.getWriter().append(email+password);
			Utilisateur user = userDao.connexion(email, password);
			if(user.getIdUtilisateur() != 0) {
				HttpSession session = request.getSession();
				session.setAttribute("session", user);
				response.sendRedirect("accueil");
			}
			
			else if(user.getEmail() == null || password == null) {
				alertMessage = "erreur";
				request.setAttribute("alertMessage", alertMessage);
				request.getRequestDispatcher("Index.jsp").forward(request, response);
			}
			
			else {
				doGet(request, response);
			}
		}
		
				
	}

}
