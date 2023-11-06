package Order;

import Store.Product;
import Store.StoreDao;
import User.User;
import User.UserDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import utils.PasswordEncoder;
import Order.OrderDao;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "OrderServlet", urlPatterns = {"/OrderServlet"})
public class OrderServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = res.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = req.getSession(true);
            if (session == null) {
                res.sendRedirect("http://localhost:8080/error.html");
            }
            
            if(req.getParameter("action") == null) {
                res.sendRedirect(req.getContextPath()+"/index.jsp");
            }
            
            else {

                String action = req.getParameter("action").trim();

                if(action.equals("ORDER"))
                {
                    String pan = req.getParameter("pan");
                    String expiry = req.getParameter("expiry");
                    String cvv = req.getParameter("cvv");
                    String name = req.getParameter("name");

                    if(pan.isEmpty() || expiry.isEmpty() || cvv.isEmpty() || name.isEmpty()) {
                        res.getWriter().write("All input fields are required");
                    }
                    else {
                        
                        int orderCreated = 0;
                        
                        boolean errorEncountered = false;
                        String msg = "";
                        if(checkCardDetails(pan, expiry, cvv, name)) {
                            ArrayList  userDetails = (ArrayList) session.getAttribute("loggedInUser");
                            User userDetail = (User) userDetails.get(0);
                            OrderDao orderDao = new OrderDao();
                            orderCreated = orderDao.create(userDetail.getId());
                            if(orderCreated > 0) {
                                ProductOrderDao productOrderDao = new ProductOrderDao();
                                StoreDao storeDao = new StoreDao();
                                ArrayList  list = (ArrayList) session.getAttribute("shoppingcart");
                                    for (int index=0; index <list.size();index++) {
                                        Product item = (Product) list.get(index);
                                        ProductOrder productOrder = new ProductOrder();
                                        productOrder.setOrderId(orderCreated);
                                        String formattedprice = String.format("%.02f", item.getPrice());
                                        productOrder.setPrice(formattedprice);
                                        productOrder.setProductId(item.getId());
                                        productOrder.setQuantity(item.getQuantity());
                                                                              
                                        int createProductOrder = productOrderDao.create(productOrder);
                                        if(createProductOrder > 0) {
                                            int quantity = storeDao.getProductQuantity(item.getId());
                                            int newQuantity = quantity-item.getQuantity();
                                            storeDao.updateQuantity(newQuantity, item.getId());
                                        } else {
                                            errorEncountered = true;
                                            msg = "Your payment is not successful a"; 
                                        }
                                    }
                            } else {
                                    errorEncountered = true;
                                    msg = "Your payment is not successful b"; 
                            }
                        }
                        else {
                            errorEncountered = true;
                            msg = "There is an error with your card details";
                        }
                        
                        if(errorEncountered) {
                            res.getWriter().write(msg);
                        }
                        else {
                            session.setAttribute("shoppingcart", null);
                            res.getWriter().write("success");
                        }
                    }

                }

            }

        }
    }
    
    public boolean checkCardDetails(String pan, String expiry, String cvv, String name) throws IOException{
        boolean didNotFindError = true;
        String regex = "[0-9]+";
        
        if(expiry.length() != 5 || !expiry.contains("/") || expiry.indexOf("/") != 2) {
            return false;
        }
        String[] result = expiry.split("/");
        int leftSide = Integer.parseInt(result[0]);
        int rightSide = Integer.parseInt(result[1]);
        if((leftSide < 01 || leftSide > 12) || (rightSide < 23)) {
            return false;
        }
        if(pan.length() < 10 || !pan.matches(regex)) {
            return false;
        }
        if(cvv.length() != 3 || !cvv.matches(regex)) {
            return false;
        }
        
        return didNotFindError;
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
