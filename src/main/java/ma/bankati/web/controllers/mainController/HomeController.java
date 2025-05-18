package ma.bankati.web.controllers.mainController;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.bankati.dao.dataDao.IDao;
import ma.bankati.model.data.MoneyData;
import ma.bankati.model.users.User;
import ma.bankati.service.moneyServices.IMoneyService;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/home", loadOnStartup = 1)
public class HomeController extends HttpServlet
{
    private IMoneyService moneyService;
    private IDao dataDao;

    @Override
    public void init() throws ServletException {
        System.out.println("HomeController créé et initialisé");
        moneyService = (IMoneyService) getServletContext().getAttribute("moneyService");
        dataDao = (IDao) getServletContext().getAttribute("dataDao");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                                throws ServletException, IOException {

        System.out.println("Call for HomeController doGet Method");

        // Get the connected user
        User connectedUser = (User) request.getSession().getAttribute("connectedUser");
        
        if (connectedUser == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Fetch money data for the connected user
        List<MoneyData> userMoneyData = dataDao.findByUserId(connectedUser.getId());
        
        // Default to the converted data if no user-specific data found
        MoneyData result;
        if (userMoneyData != null && !userMoneyData.isEmpty()) {
            // Get the primary currency (Dh) data
            result = userMoneyData.stream()
                    .filter(data -> "Dh".equals(data.getDevise().name()))
                    .findFirst()
                    .orElse(userMoneyData.get(0)); // Fallback to first currency
        } else {
            // Fallback to the converted result
            result = moneyService.convertData();
        }
        
        request.setAttribute("result", result);
        request.setAttribute("allCurrencies", userMoneyData);

        // 🔁 Récupérer le chemin de la vue injecté par le filtre
        String viewPath = (String) request.getAttribute("viewPath");

        if (viewPath == null) {
            // Cas de sécurité si quelqu'un arrive ici sans rôle (non connecté ?)
            response.sendRedirect("login");
            return;
        }

        request.getRequestDispatcher(viewPath).forward(request, response);
    }
    
    @Override
    public void destroy() {
        System.out.println("HomeController détruit");
    }
}
