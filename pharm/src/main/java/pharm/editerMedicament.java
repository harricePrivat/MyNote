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

@WebServlet("/editerMedicament")
public class editerMedicament extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private IMedicament medocMetier;

	public editerMedicament() {
		super();

	}

	public void init() {
		medocMetier = new MedicamentDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		Utilisateur user = (Utilisateur) session.getAttribute("session");

		if (user != null) {
			String username = user.getNom();
			int id = Integer.parseInt(request.getParameter("id"));
			Medicament m = medocMetier.getMedicament(id);
			request.setAttribute("medoc", m);
			request.setAttribute("username", username);
			request.getRequestDispatcher("editMedoc.jsp").forward(request, response);
		}

		else {
			response.sendRedirect("index");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));
		int code = Integer.parseInt(request.getParameter("code"));
		int prix = Integer.parseInt(request.getParameter("prix"));
		int qte = Integer.parseInt(request.getParameter("quantite"));
		String nom = request.getParameter("nom");

		if (request.getParameter("modifier") != null) {
			Medicament m = new Medicament(code, prix, nom, qte);
			m.setIdMedicament(id);
			medocMetier.update(m);
			request.setAttribute("medoc", m);
			response.sendRedirect("accueil");
		}

		else if (request.getParameter("annuler") != null) {
			response.sendRedirect("accueil");
		}

		else if (request.getParameter("supprimer") != null) {

			doGet(request, response);

		}
	}
}