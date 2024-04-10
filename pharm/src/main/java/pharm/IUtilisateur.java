package pharm;

import pharm.Utilisateur;

public interface IUtilisateur {
	
	public Utilisateur connexion(String login, String password);
	public void validateEmail(String email);
	
	
}
