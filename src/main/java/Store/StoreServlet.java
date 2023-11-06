package Store;

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
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "StoreServlet", urlPatterns = {"/StoreServlet"})
public class StoreServlet extends HttpServlet {

  
    protected void processRequest(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = res.getWriter()) {


            HttpSession session = req.getSession(true);
            if (session == null) {
                res.sendRedirect("http://localhost:8080/error.html");
            }
            ArrayList list= (ArrayList)session.getAttribute("shoppingcart");
            
            if(req.getParameter("action") == null) {
                res.sendRedirect(req.getContextPath()+"/index.jsp");
            }
            else{
            
            String action = req.getParameter("action").trim();
            
            if(action.equals("ADD")) {
                Product product = getProduct(req);  
                if(list==null)
                {
                   list = new ArrayList();
                   list.add(product);
                }
                else
                {
                  boolean found = false;
                  String productName = product.getName().trim();
                  for(int i=0;i<list.size(); i++)
                  {
                       String name = ((Product)list.get(i)).getName().trim();
                       Product aproduct = (Product)list.get(i);
                       if(productName.equals(name))
                       {  
                           found = true;
                           aproduct.setQuantity(aproduct.getQuantity()+product.getQuantity());
                           aproduct.setPrice(aproduct.getPrice()+product.getPrice());
                       }
                   }
                   if(!found)
                   {
                       list.add(product);
                   }
                }
                session.setAttribute("shoppingcart", list);
                res.sendRedirect(req.getContextPath()+"/index.jsp?category="+ product.getCategoryId());
            }
            
            else if(action.equals("DELETE"))
            {
                int catId = Integer.parseInt(req.getParameter("cat_id"));
                int index = Integer.parseInt(req.getParameter("deleteindex"));
                if(list != null){
                    list.remove(index);
                }
                session.setAttribute("shoppingcart", list);
                res.sendRedirect(req.getContextPath()+"/index.jsp?category="+catId);
            }
            }
        }
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
    
    private Product getProduct(HttpServletRequest req) {
        
        StoreDao storeDao = new StoreDao();

        Double price = Double.valueOf(req.getParameter("price"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String name = req.getParameter("name");
        int id = Integer.parseInt(req.getParameter("id"));
        String image = req.getParameter("image");
        //String sizes = req.getParameter("sizes");
        int catId = Integer.parseInt(req.getParameter("cat_id"));

        Product product = new Product();
        product.setName(name);
        product.setId(id);
        if(quantity > storeDao.getProductQuantity(id)) {
            product.setQuantity(storeDao.getProductQuantity(id));
        }
        else {
            product.setQuantity(quantity);
        }
        Double priceByQuantity = quantity * price;
        product.setPrice(priceByQuantity);
        product.setImage(image);
        //product.setSizes(sizes);
        product.setCategoryId(catId);

        return product;
    }

}
