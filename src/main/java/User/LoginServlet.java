package User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import utils.PasswordEncoder;
import User.UserDao;


@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {


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
                res.sendRedirect(req.getContextPath()+"/login.jsp");
            }
            
            else {

                String action = req.getParameter("action").trim();

                if(action.equals("LOGIN"))
                {
                    String email = req.getParameter("email");
                    String password = req.getParameter("password");

                    if(email.isEmpty() || password.isEmpty()) {

                        session.setAttribute("loginError", "All input fields are required");
                        res.sendRedirect(req.getContextPath()+"/login.jsp");
                    }
                    else {
                            PasswordEncoder passwordEncoder = new PasswordEncoder();

                            String encodedPassword = passwordEncoder.hashPassword(password);
                            UserDao userDao = new UserDao();
                            List<User> user = userDao.login(email, encodedPassword);
                            if(user.size() == 1) {
                                session.setAttribute("isLoggedIn", true);
                                session.setAttribute("loggedInUser", user);
                                res.sendRedirect(req.getContextPath()+"/index.jsp");
                            }
                            else {
                                session.setAttribute("loginError", "Invalid username/password combination");
                                res.sendRedirect(req.getContextPath()+"/login.jsp");
                            }
                    }

                }
                if(action.equals("LOGOUT"))
                {
                    session.setAttribute("isLoggedIn", false);
                    session.setAttribute("loggedInUser", null);
                    session.setAttribute("shoppingcart", null);
                    session.invalidate();
                    res.getWriter().write("success");
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

}
