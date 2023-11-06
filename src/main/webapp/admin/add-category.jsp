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
<%@page import="Category.*"%>
<%@page import="Order.*"%>
<%@page session="true" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="home.jsp" flush="true" />

        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="content-header">
<div class="container-fluid">
<div class="row mb-2">
<div class="col-sm-6">
<h1 class="m-0">Add Category</h1>
</div>
<div class="col-sm-6">
<ol class="breadcrumb float-sm-right">
    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
    <li class="breadcrumb-item"><a href="categories.jsp">Categories</a></li>
    <li class="breadcrumb-item active" aria-current="page">Add category</li>
</ol>
</div>
</div>
</div>
</div>
          <div style="margin-left: 15px;">
        <%
           String  error = (String) session.getAttribute("addCategoryError");
           String  success = (String) session.getAttribute("addCategorySuccess");
        %>
                    <% if(error != null) { %> <div style="max-width: 600px;"><div class="alert alert-danger" role="alert"><small><%= error %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button></div></div> <% } %>
                    <% if(success != null) { %> <div style="max-width: 600px;"><div class="alert alert-success" role="alert"><small><%= success %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button></div></div> <% } %>
            <form method="POST" action="../CpanelCategoryServlet">
                <label>Name</label>
                <input type="text" name="name" class="form-control" placeholder="Name" style="max-width: 600px;"/>
                <small class="text-muted"><i class="fa fa-question-circle"></i> Kindly input the name of the cake category you wish to create</small><br/>
                <input type="hidden" name="action" value="CREATE"/><br/>
                <button class="btn btn-primary">SUBMIT</button>
            </form>
            </div>
        </main>
            <% session.removeAttribute("addCategoryError");
               session.removeAttribute("addCategorySuccess");
            %>
      </div>
    </div>
