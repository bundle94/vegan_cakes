<%
    Object loggedInSession = session.getAttribute("isAdminLoggedIn");
    if(loggedInSession == null) {
        response.sendRedirect("/admin/signin.jsp");
    }
    else {
        boolean isLoggedIn = (boolean)loggedInSession;
        if(!isLoggedIn) 
        {
            response.sendRedirect("/admin/signin.jsp");
        }
    }
%>
<%@page import="User.*"%>
<%@page session="true" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="home.jsp" flush="true" />
<%
    UserDao userDao = new UserDao();
%>
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          
                      <div class="content-header">
<div class="container-fluid">
<div class="row mb-2">
<div class="col-sm-6"  style="margin-left: -5px;">
    <h1 class="m-0">Users</h1>
</div>
<div class="col-sm-6" style="margin-right: 5px;">
<ol class="breadcrumb float-sm-right">
    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Users</li>
</ol>
</div>
</div>
</div>
</div>
              <% List<User> users = userDao.getAllUsers();
    if (users == null || users.size() == 0) { %>
        <div class="alert alert-info" role="alert">There are no registered customer yet</div>
    <% } else { %>
            <table class="table table-striped">
             <thead>
               <tr>
                 <th scope="col">Name</th>
                 <th scope="col">Email</th>
                 <th scope="col">Phone</th>
                 <th scope="col">Address</th>
                 <th scope="col">Date Created</th>
                 <th scope="col">Date Updated</th>
               </tr>
             </thead>
             <tbody> <% }%>
               <% for (int index=0; index < users.size();index++) {
                User item = (User) users.get(index);
                           %><tr>
                    <td><%= item.getFullName() %></td>
                    <td><%= item.getEmail() %></td>
                   <td><%= item.getPhoneNumber() %></td>
                   <td><%= item.getAddress() %></td>
                   <td><%=item.getDateCreated()%></td>
                   <td><%= item.getDateUpdated() == null ? "" : item.getDateUpdated()%></td>
                   </tr> <% } %></tbody></table>
        </main>
      </div>
    </div>
