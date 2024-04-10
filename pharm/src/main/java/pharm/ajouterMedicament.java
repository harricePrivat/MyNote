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

@WebServlet("/ajouterMedicament")
public class ajouterMedicament extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ajouterMedicament() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		Utilisateur user = (Utilisateur) session.getAttribute("session");
		if (user != null) {
			String username = user.getNom();
			request.setAttribute("username", username);
			request.getRequestDispatcher("addMedocForm.jsp").forward(request, response);
		} else {
			response.sendRedirect("index");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String code = request.getParameter("codeBarre");
		String nom = request.getParameter("nom");
		String prix = request.getParameter("prix");
		String qte = request.getParameter("quantite");
		String alertMessage = "erreur";
		if (request.getParameter("ajouter") != null) {

			if(code == "" || nom == "" || prix == "" || qte == "") {
				
				request.setAttribute("alertMessage", alertMessage);
				doGet(request, response);
			}
			else {
				alertMessage = "success";
				int codeBarre = Integer.parseInt(code);
				int prixMed = Integer.parseInt(prix);
				int quantite = Integer.parseInt(qte);
				IMedicament medocMetier = new MedicamentDao();
				Medicament medoc = new Medicament(codeBarre, nom, prixMed, quantite);
				
				medocMetier.add(medoc);
				request.setAttribute("alertMessage", alertMessage);
				doGet(request, response);
				
			}
			
		}


		if (request.getParameter("annuler") != null) {
			response.sendRedirect("accueil");
		}

	}
}