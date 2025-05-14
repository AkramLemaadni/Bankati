package ma.bankati.service.authentification;

import ma.bankati.dao.userDao.IUserDao;
import ma.bankati.model.users.User;

import java.util.Map;
import java.util.Optional;

public class AuthentificationServiceImpl implements IAuthentificationService {

    private IUserDao userDao;
    private User connectedUser;
    private final UserFormValidator validator = new UserFormValidator();

    public AuthentificationServiceImpl() {
    }

    public AuthentificationServiceImpl(IUserDao userDao) {
            this.userDao = userDao;
    }

    @Override
    public boolean validateLoginForm(String username, String password) {
        return validator.validate(username, password);
    }

    @Override
    public User connect(String username, String password) {
        Optional<User> userOpt = userDao.findByLoginAndPassword(username, password);
        if (userOpt.isPresent()) {
            connectedUser = userOpt.get();
            validator.setGlobalMessage("Connexion réussie !");
        } else {
            validator.setGlobalMessage("Échec de la connexion.");
        }
        return connectedUser;
    }

    @Override
    public Map<String, String> getFieldErrors() {
        return validator.getFieldErrors();
    }

    @Override
    public String getGlobalMessage() {
        return validator.getGlobalMessage();
    }

    @Override
    public void disconnect() {
        connectedUser = null;
    }
}
