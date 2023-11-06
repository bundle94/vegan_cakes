/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package cpanelServlets;

import Store.StoreDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

/**
 *
 * @author michael
 */
@WebServlet(name = "CpanelStoreServlet", urlPatterns = {"/CpanelStoreServlet"})
@MultipartConfig(maxFileSize = 16177215)
public class CpanelStoreServlet extends HttpServlet {

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
            HttpSession session = req.getSession(true);
            if (session == null) {
                res.sendRedirect("http://localhost:8080/error.html");
            }
            
            if(req.getParameter("action") == null) {
                //RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/cpanel/orders.jsp");
                //dispatcher.forward(req, res);
                res.sendRedirect(req.getContextPath()+"/cpanel/products.jsp");
            }
            
            else {
                // Do nothing here
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
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
            HttpSession session = req.getSession(true);
            if (session == null) {
                res.sendRedirect("http://localhost:8080/error.html");
            }
                        
            if(req.getParameter("action") == null) {
                res.sendRedirect(req.getContextPath()+"/admin/products.jsp");
            }
            
            else {
                
                String action = req.getParameter("action").trim();
                
                if(action.equals("CREATE")) {
                                        String name = req.getParameter("name");
                    String price = req.getParameter("price");
                    String quantity = req.getParameter("quantity");
                    String category = req.getParameter("category");
                    
                    InputStream inputStream = null;
                    
                    Part filePart = req.getPart("fname");
                    
                    if(name.isEmpty() || price.isEmpty() || quantity.isEmpty() || category.isEmpty() || filePart == null) {
                        session.setAttribute("addProductError", "All input fields are required");
                        res.sendRedirect(req.getContextPath()+"/admin/add-product.jsp");
                    }
                    else {
                        System.out.println("Image type: "+ filePart.getContentType());
                        System.out.println("Image Size: "+ filePart.getSize());
                                                
                        if(filePart.getContentType().equals("image/png") || filePart.getContentType().equals("image/jpeg") || filePart.getContentType().equals("image/jpg")) {
                            
                             inputStream = filePart.getInputStream();

                             int newQuantity = Integer.parseInt(quantity);
                             int categoryId = Integer.parseInt(category);

                             StoreDao storeDao = new StoreDao();
                             if(storeDao.createProduct(name, price, inputStream, newQuantity, categoryId) > 0) {
                               session.setAttribute("addProductSuccess", "Product has been added successfully");
                             }
                             else {
                                 session.setAttribute("addProductError", "An error occurred while adding product");
                             }
                             res.sendRedirect(req.getContextPath()+"/admin/add-product.jsp");
                        }
                        else {
                            session.setAttribute("addProductError", "Image type not supported");
                            res.sendRedirect(req.getContextPath()+"/admin/add-product.jsp");
                        }
                    }
                }
                
                if(action.equals("UPDATE")) {
                    int id = Integer.parseInt(req.getParameter("product_id"));
                    String name = req.getParameter("name");
                    String price = req.getParameter("price");
                    String quantity = req.getParameter("quantity");
                    
                    if(name.isEmpty() || price.isEmpty() || quantity.isEmpty()) {
                        res.sendRedirect(req.getContextPath()+"/admin/products.jsp");
                    }
                    int quantityInInteger = Integer.parseInt(quantity);
                    StoreDao storeDao = new StoreDao();
                    
                    storeDao.updateProductDetails(quantityInInteger, name, price, id);
                    res.sendRedirect(req.getContextPath()+"/admin/products.jsp");
                }
                
                if(action.equals("DELETE")) {
                    int id = Integer.parseInt(req.getParameter("product_id"));
                    
                    StoreDao storeDao = new StoreDao();
                    
                    storeDao.deleteProduct(id);
                    res.sendRedirect(req.getContextPath()+"/admin/products.jsp");
                }
            }
                
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
