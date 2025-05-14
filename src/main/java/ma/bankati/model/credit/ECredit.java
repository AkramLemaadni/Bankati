package ma.bankati.model.credit;

public enum ECredit {

    EN_ATTENTE("En attente"),
    APPROUVE("Approuvé"),
    REFUSE("Refusé");

    private final String libelle;

    ECredit(String libelle) {
        this.libelle = libelle;
    }

    public String getLibelle() {
        return libelle;
    }

    public static ECredit fromString(String text) {
        for (ECredit statut : ECredit.values()) {
            if (statut.name().equalsIgnoreCase(text)) {
                return statut;
            }
        }
        throw new IllegalArgumentException("Statut inconnu: " + text);
    }
}
