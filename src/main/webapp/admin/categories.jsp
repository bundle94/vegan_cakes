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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Category.*"%>
<%@page import="Store.*"%>
<%@page session="true" import="java.util.*"%>
<jsp:include page="home.jsp" flush="true" />
<%
    StoreDao storeDao = new StoreDao();
    CategoryService categoryService = new CategoryService();
%>
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">

                      <div class="content-header">
<div class="container-fluid">
<div class="row mb-2">
<div class="col-sm-6"  style="margin-left: -5px;">
    <h1 class="m-0">Categories</h1>
</div>
<div class="col-sm-6" style="margin-right: 5px;">
<ol class="breadcrumb float-sm-right">
    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Categories</li>
</ol>
</div>
</div>
</div>
</div>
            <div class="container-fluid">
            
                      <div style="float:right">
            <div class="btn-toolbar mb-2 mb-md-0">
                <a href="add-category.jsp" style="margin-right: 15px;">
                  <i class="fa fa-plus"></i> Add
              </a>
            </div>
          </div>
              <% List<Category> categories = CategoryDao.getList();
    if (categories == null || categories.size() == 0) { %>
        <div class="alert alert-info" role="alert">There is no category, please add a category</div>
        <% } else { %>
            <table class="table table-striped">
             <thead>
               <tr>
                 <th scope="col">Title</th>
                 <th scope="col">Date Created</th>
                 <th scope="col">Date Updated</th>
                 <th scope="col">Operation</th>
               </tr>
             </thead>
             <tbody><% }%>
               <% for (int index=0; index <categories.size();index++) {
                Category item = (Category) categories.get(index);
                           %><tr>
                    <td><%= item.getTitle() %></td>
                   <td><%=item.getDateCreated()%></td>
                   <td><%= item.getDateUpdated() == null ? "" : item.getDateUpdated()%></td>
                   <td><form method="POST" action="../CpanelCategoryServlet"><input type="hidden" name="action" value="DELETE" /><input type="hidden" name="category_id" value="<%=item.getId()%>"/><button class="btn btn-sm btn-danger">Delete</button></form></td></tr> <% } %></tbody></table>
        </main>
      </div>
    </div>
