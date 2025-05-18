package ma.bankati.web.controllers.userController;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import ma.bankati.dao.userDao.IUserDao;
import ma.bankati.dao.userDao.UserDaoImpl;
import ma.bankati.model.users.ERole;
import ma.bankati.model.users.User;


public class UserController {

    private final IUserDao userDao;

    public UserController() {
        this.userDao = new UserDaoImpl();
    }

    public void showAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userDao.findAll();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }

    public void editForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        User user = userDao.findById(id);
        request.setAttribute("user", user);
        showAll(request, response);
    }

    public void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        userDao.deleteById(id);
        response.sendRedirect(request.getContextPath() + "/users");
    }

    public void saveOrUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        Long id = (idStr == null || idStr.isEmpty()) ? null : Long.parseLong(idStr);

        User user = User.builder()
                .id(id)
                .firstName(req.getParameter("firstName"))
                .lastName(req.getParameter("lastName"))
                .username(req.getParameter("username"))
                .password(req.getParameter("password"))
                .role(ERole.valueOf(req.getParameter("role")))
                .creationDate(LocalDate.now())
                .build();

        if (id == null) {
            userDao.save(user);
        } else {
            User existingUser = userDao.findById(id);
            if (existingUser != null) {
                user.setCreationDate(existingUser.getCreationDate());
            }
            userDao.update(user);
        }

        resp.sendRedirect(req.getContextPath() + "/users");
    }
}
