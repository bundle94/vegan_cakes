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
<%@page import="Store.*"%>
<%@page session="true" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <h1 class="m-0">Products</h1>
</div>
<div class="col-sm-6" style="margin-right: 5px;">
<ol class="breadcrumb float-sm-right">
    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">Products</li>
</ol>
</div>
</div>
</div>
</div>
            <div class="container-fluid">
            
                      <div style="float:right">
            <div class="btn-toolbar mb-2 mb-md-0">
                <a href="add-product.jsp" style="margin-right: 15px;">
                  <i class="fa fa-plus"></i> Add
              </a>
            </div>
          </div>
              <% List<Store> products = storeDao.getAllProducts();
    if (products == null || products.size() == 0) { %>
        <div class="alert alert-info" role="alert">There are no products yet, kindly add a product</div>
        <% } else { %>
            <table class="table table-striped table-sm" id="products_table">
             <thead>
               <tr>
                 <th scope="col">Image</th>
                 <th scope="col">Title</th>
                 <th scope="col">Category</th>
                 <th scope="col">Quantity</th>
                 <th scope="col">Price</th>
                 <th scope="col">Date Created</th>
                 <th scope="col">Date Updated</th>
                 <th scope="col"></th>
               </tr>
             </thead>
             <tbody><% }%>
               <% for (int index=0; index <products.size();index++) {
                Store item = (Store) products.get(index);
                           %><form method="POST" action="../CpanelStoreServlet"><tr>
                    <td><img src="data:image/png;base64,<%= item.getEncodedPhoto() %>" width="60" height="60" alt="<%= item.getName() %>"/></td>
                    <td><input type="text" name="name" value="<%= item.getName() %>" class="form-control" style="width:250px;"/></td>
                   <td><%= categoryService.getCategoryNameById(item.getCategoryId()) %></td>
                   <td><input type="text" name="quantity" value="<%= item.getQuantity() %>"class="form-control" style="width:60px;"/></td>
                   <td><input type="text" name="price" value="<%= item.getPrice() %>"class="form-control" style="width:90px;"/></td>
                   <td><%=item.getDateCreated()%></td>
                   <td><%= item.getDateUpdated() == null ? "" : item.getDateUpdated()%></td>
                   <td><input type="hidden" name="action" value="UPDATE" /><input type="hidden" name="product_id" value="<%=item.getId()%>"/><button class="btn btn-sm btn-secondary"><i class="fa fa-edit"></i></button></form> <form method="POST" action="../CpanelStoreServlet"><input type="hidden" name="action" value="DELETE" /><input type="hidden" name="product_id" value="<%=item.getId()%>"/><button class="btn btn-sm btn-danger"><i class="fa fa-trash"></i></button></form></td></tr> <% } %></tbody></table>
                   
                   </div>
        </main>
      </div>
    </div>
            <script>
        $(document).ready( function () {
            //$('#products_table').DataTable();
            //var table = new DataTable('#products_table');
        } );
        </script>
