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

    public void showAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       User connectedUser = (User) request.getSession().getAttribute("connectedUser");
       List<Credit> credits = creditDao.findByUserId(connectedUser.getId());
       request.setAttribute("demandes", credits);
       request.getRequestDispatcher("public/credit.jsp").forward(request, response);

    }

    public void editForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       Long id = Long.parseLong(request.getParameter("id"));
       Credit credit = creditDao.findById(id);
       User connectedUser = (User) request.getSession().getAttribute("connectedUser");

       if (credit == null || !credit.getUserId().equals(connectedUser.getId())) {
           request.setAttribute("errorMessage", "Vous n'avez pas accès à cette demande de crédit.");
           showAll(request, response);
           return;
       }
       
       request.setAttribute("credit", credit);
       showAll(request, response);
    }

    public void delete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Long id = Long.parseLong(request.getParameter("id"));
        Credit credit = creditDao.findById(id);
        User connectedUser = (User) request.getSession().getAttribute("connectedUser");
        if (credit == null || !credit.getUserId().equals(connectedUser.getId())) {
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
       if (id != null) {
           Credit existingCredit = creditDao.findById(id);
           if (existingCredit == null || !existingCredit.getUserId().equals(connectedUser.getId())) {
               request.setAttribute("errorMessage", "Vous n'avez pas accès à cette demande de crédit.");
               showAll(request, response);
               return;
           }
       }

       Credit credit = Credit.builder()
               .id(id)
               .montant(Double.parseDouble(request.getParameter("montant")))
               .dureeMois(Integer.parseInt(request.getParameter("duree")))
               .status(ECredit.EN_ATTENTE)
               .dateDemande(LocalDate.now())
               .userId(connectedUser.getId())
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