package ma.bankati.service.authentification;

import ma.bankati.model.users.User;

import java.util.Map;

public interface IAuthentificationService {

    boolean validateLoginForm(String username, String password);

    User connect(String username, String password);

    Map<String, String> getFieldErrors();

    String getGlobalMessage();

    void disconnect();
}
