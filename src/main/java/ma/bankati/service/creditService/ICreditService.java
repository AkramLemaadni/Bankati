package ma.bankati.service.creditService;

import ma.bankati.model.credit.Credit;
import ma.bankati.model.credit.ECredit;

import java.util.List;

public interface ICreditService {
    Credit creerDemande(Credit demande);
    boolean supprimerDemande(Long id);
    List<Credit> getDemandesUtilisateur(Long userId);
    List<Credit> getDemandesParStatut(ECredit statut);
    Credit getDemandeById(Long id);
}
