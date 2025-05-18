package ma.bankati.service.creditService;

import ma.bankati.dao.creditDao.ICreditDao;
import ma.bankati.model.credit.Credit;
import ma.bankati.model.credit.ECredit;
import java.util.List;

public class CreditService implements ICreditService {
    private final ICreditDao creditDao;

    public CreditService() {
        this.creditDao = null; // Default constructor required for reflection
    }

    public CreditService(ICreditDao creditDao) {
        this.creditDao = creditDao;
    }

    @Override
    public Credit creerDemande(Credit demande) {
        // Validate business rules
        if (demande.getMontant() <= 0) {
            throw new IllegalArgumentException("Le montant doit être positif");
        }
        if (demande.getDureeMois() < 1) {
            throw new IllegalArgumentException("La durée minimale est de 1 mois");
        }

        // Set default values
        demande.setStatus(ECredit.EN_ATTENTE);
        demande.setDateDemande(java.time.LocalDate.now());

        return creditDao.save(demande);
    }

    @Override
    public boolean supprimerDemande(Long id) {
        Credit demande = creditDao.findById(id);
        if (demande != null && demande.getStatus() == ECredit.EN_ATTENTE) {
            creditDao.deleteById(id);
            return true;
        }
        return false;
    }

    @Override
    public List<Credit> getDemandesUtilisateur(Long userId) {
        if (userId == null) {
            throw new IllegalArgumentException("L'ID utilisateur ne peut pas être null");
        }
        return creditDao.findByUserId(userId);
    }

    @Override
    public List<Credit> getDemandesParStatut(ECredit statut) {
        if (statut == null) {
            throw new IllegalArgumentException("Le statut ne peut pas être null");
        }
        return creditDao.findByStatus(statut);
    }

    @Override
    public Credit getDemandeById(Long id) {
        if (id == null) {
            throw new IllegalArgumentException("L'ID de la demande ne peut pas être null");
        }
        return creditDao.findById(id);
    }
}