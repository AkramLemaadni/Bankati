package ma.bankati.web.controllers.creditController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.bankati.dao.creditDao.CreditDaoImpl;
import ma.bankati.dao.creditDao.ICreditDao;
import ma.bankati.model.credit.Credit;
import ma.bankati.model.credit.ECredit;
import ma.bankati.model.users.User;
import ma.bankati.service.creditService.ICreditService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

public class CreditController{
    private final ICreditDao creditDao;

   public CreditController(){this.creditDao = new CreditDaoImpl();}

   // Getter for creditDao
   public ICreditDao getCreditDao() {
       return creditDao;
   }

    public void showAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       User connectedUser = (User) request.getSession().getAttribute("connectedUser");
       List<Credit> credits = creditDao.findByUserId(connectedUser.getId());
       request.setAttribute("demandes", credits);
       
       // Check user role to determine which view to display
       if (connectedUser.getRole() == ma.bankati.model.users.ERole.ADMIN) {
           // For admin users, show all credits
           List<Credit> allCredits = creditDao.findAll();
           request.setAttribute("demandes", allCredits);
           request.getRequestDispatcher("/admin/credit.jsp").forward(request, response);
       } else {
           // For regular users, show only their credits
           request.getRequestDispatcher("/public/credit.jsp").forward(request, response);
       }
    }

    public void editForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       try {
           Long id = Long.parseLong(request.getParameter("id"));
           Credit credit = creditDao.findById(id);
           User connectedUser = (User) request.getSession().getAttribute("connectedUser");

           if (credit == null) {
               request.setAttribute("errorMessage", "Demande de crédit non trouvée.");
               showAll(request, response);
               return;
           }
           
           // For admin users, allow access to any credit
           boolean isAdmin = connectedUser.getRole() == ma.bankati.model.users.ERole.ADMIN;
           
           if (!isAdmin && !credit.getUserId().equals(connectedUser.getId())) {
               request.setAttribute("errorMessage", "Vous n'avez pas accès à cette demande de crédit.");
               showAll(request, response);
               return;
           }
           
           request.setAttribute("credit", credit);
           
           if (isAdmin) {
               // Find user information for the credit
               List<Credit> allCredits = creditDao.findAll();
               request.setAttribute("demandes", allCredits);
               request.getRequestDispatcher("/admin/credit.jsp").forward(request, response);
           } else {
               User user = (User) request.getSession().getAttribute("connectedUser");
               List<Credit> credits = creditDao.findByUserId(user.getId());
               request.setAttribute("demandes", credits);
               request.getRequestDispatcher("/public/credit.jsp").forward(request, response);
           }
       } catch (NumberFormatException e) {
           request.setAttribute("errorMessage", "Identifiant de demande invalide.");
           showAll(request, response);
       }
    }

    public void delete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Long id = Long.parseLong(request.getParameter("id"));
        Credit credit = creditDao.findById(id);
        User connectedUser = (User) request.getSession().getAttribute("connectedUser");
        boolean isAdmin = connectedUser.getRole() == ma.bankati.model.users.ERole.ADMIN;
        
        if (credit == null || (!isAdmin && !credit.getUserId().equals(connectedUser.getId()))) {
            request.setAttribute("errorMessage", "Vous n'avez pas accès à cette demande de crédit.");
            showAll(request, response);
            return;
        }
        
        creditDao.deleteById(id);
        response.sendRedirect(request.getContextPath() + "/credit");
    }

    public void saveOrUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String idStr = request.getParameter("id");
       Long id = (idStr == null || idStr.isEmpty()) ? null : Long.parseLong(idStr);
       User connectedUser = (User) request.getSession().getAttribute("connectedUser");
       boolean isAdmin = connectedUser.getRole() == ma.bankati.model.users.ERole.ADMIN;
       
       if (id != null) {
           Credit existingCredit = creditDao.findById(id);
           if (existingCredit == null || (!isAdmin && !existingCredit.getUserId().equals(connectedUser.getId()))) {
               request.setAttribute("errorMessage", "Vous n'avez pas accès à cette demande de crédit.");
               showAll(request, response);
               return;
           }
       }

       // Determine credit status - admins can change status
       ECredit status = ECredit.EN_ATTENTE;
       if (isAdmin && request.getParameter("status") != null && !request.getParameter("status").isEmpty()) {
           try {
               status = ECredit.valueOf(request.getParameter("status"));
           } catch (IllegalArgumentException e) {
               // Invalid status, use default
           }
       }

       // Determine userId - admins can create/edit credits for other users
       Long userId = connectedUser.getId();
       if (isAdmin && request.getParameter("userId") != null && !request.getParameter("userId").isEmpty()) {
           try {
               userId = Long.parseLong(request.getParameter("userId"));
           } catch (NumberFormatException e) {
               // Invalid userId, use default
           }
       }

       Credit credit = Credit.builder()
               .id(id)
               .montant(Double.parseDouble(request.getParameter("montant")))
               .dureeMois(Integer.parseInt(request.getParameter("duree")))
               .status(status)
               .dateDemande(LocalDate.now())
               .userId(userId)
               .build();

       if(id == null) {
           creditDao.save(credit);
           request.setAttribute("successMessage", "Demande de crédit ajoutée avec succès!");
       } else {
           creditDao.update(credit);
           request.setAttribute("successMessage", "Demande de crédit mise à jour avec succès!");
       }
       response.sendRedirect(request.getContextPath() + "/credit");
    }
}