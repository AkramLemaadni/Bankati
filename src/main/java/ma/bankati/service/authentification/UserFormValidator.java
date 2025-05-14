package ma.bankati.service.authentification;

import java.util.HashMap;
import java.util.Map;

public class UserFormValidator {

    private final Map<String, String> fieldErrors = new HashMap<>();
    private String globalMessage;

    public boolean validate(String login, String password) {
        fieldErrors.clear();
        globalMessage = null;

        if (login == null || login.trim().isEmpty()) {
            fieldErrors.put("usernameError", "Le nom d'utilisateur est requis.");
        } else if (login.length() < 3) {
            fieldErrors.put("usernameError", "Le nom d'utilisateur doit contenir au moins 3 caractères.");
        }

        if (password == null || password.trim().isEmpty()) {
            fieldErrors.put("passwordError", "Le mot de passe est requis.");
        } else if (password.length() < 4) {
            fieldErrors.put("passwordError", "Le mot de passe doit contenir au moins 4 caractères.");
        }

        if (fieldErrors.isEmpty()) {
            globalMessage = "Validation des champs réussie.";
            return true;
        } else {
            globalMessage = "Votre formulaire contient des erreurs !!";
            return false;
        }
    }

    public void setGlobalMessage(String message) {
        this.globalMessage = message;
    }

    public String getGlobalMessage() {
        return globalMessage;
    }

    public Map<String, String> getFieldErrors() {
        return fieldErrors;
    }
}
