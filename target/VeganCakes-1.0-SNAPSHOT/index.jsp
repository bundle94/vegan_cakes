<%@page session="true" import="java.util.*"%>
    <% Object loggedInSession = session.getAttribute("isLoggedIn");
    if(loggedInSession != null) {
        boolean isLoggedIn = (boolean)loggedInSession;
        if(!isLoggedIn) 
        {
            response.sendRedirect("signin.jsp");
        }
    }
    else
    {
        response.sendRedirect("signin.jsp");
    }%>
    <jsp:include page="header.jsp" flush="true" />
    <jsp:include page="products.jsp" flush="true" />
    </body>
</html>
