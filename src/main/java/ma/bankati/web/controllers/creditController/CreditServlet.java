package ma.bankati.web.controllers.creditController;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.bankati.model.credit.Credit;

import java.io.IOException;

@WebServlet(urlPatterns = {"/credit", "/credit/*"})
public class CreditServlet extends HttpServlet {
    private CreditController creditController;

    @Override
    public void init() throws ServletException {
        System.out.println("CreditController cree et initialise");
        creditController = new CreditController();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        System.out.println("CreditServlet doGet path: " + path);
        
        if(path == null || path.equals("/")) {
            creditController.showAll(request, response);
        } else if(path.equals("/edit")) {
            creditController.editForm(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        System.out.println("CreditServlet doPost path: " + path);
        
        if(path == null) {
            response.sendRedirect(request.getContextPath() + "/credit");
            return;
        }
        
        if(path.equals("/save")) {
            creditController.saveOrUpdate(request, response);
        } else if(path.equals("/delete")) {
            creditController.delete(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    public void destroy() {
        System.out.println("CreditController destroy");
    }
}
