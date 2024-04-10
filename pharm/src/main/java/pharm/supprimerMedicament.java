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

@WebServlet("/supprimerMedicament")
public class supprimerMedicament extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public supprimerMedicament() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		Utilisateur user = (Utilisateur) session.getAttribute("session");

		if (user != null) {

			int id = Integer.parseInt(request.getParameter("id"));
			IMedicament medocDao = new MedicamentDao();
			medocDao.delete(id);
			response.sendRedirect("accueil");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("WEB-INF/accueil.jsp").forward(request, response);
	}

}
