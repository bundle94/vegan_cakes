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
<%
    ProductOrderDao productOrderDao = new ProductOrderDao();
    CategoryService categoryService = new CategoryService();
    
    int orderId = 0;
    
    String order = request.getParameter("order");
    if(order == null) {
        response.sendRedirect("orders.jsp");
    }
    else {
        orderId = Integer.parseInt(order);
    }
%>
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          
                      <div class="content-header">
<div class="container-fluid">
<div class="row mb-2">
<div class="col-sm-6"  style="margin-left: -5px;">
    <h1 class="m-0">Order details</h1>
</div>
<div class="col-sm-6" style="margin-right: 5px;">
<ol class="breadcrumb float-sm-right">
    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
    <li class="breadcrumb-item"><a href="orders.jsp">Orders</a></li>
    <li class="breadcrumb-item active" aria-current="page">Order details</li>
</ol>
</div>
</div>
</div>
</div>

              <% List<ProductOrderCpanel> products = productOrderDao.getProductsByOrderId(orderId);
    if (products == null || products.size() == 0) { %>
        <div class="alert alert-info" role="alert">There are no products ordered yet</div>
    <% } else { %>
            <table class="table table-striped">
             <thead>
               <tr>
                 <th scope="col">Image</th>
                 <th scope="col">Title</th>
                 <th scope="col">Category</th>
                 <th scope="col">Quantity</th>
                 <th scope="col">Price</th>
                 <th scope="col">Delivered</th>
                 <th scope="col">Date Created</th>
                 <th scope="col">Date Updated</th>
                 <th scope="col">Status</th>
               </tr>
             </thead>
             <tbody>
               <% for (int index=0; index < products.size();index++) {
                ProductOrderCpanel item = (ProductOrderCpanel) products.get(index);
                           %><tr>
                    <td><img src="data:image/png;base64,<%= item.getEncodedPhoto() %>" width="60" height="60" alt="<%= item.getName() %>"/></td>
                    <td><%= item.getName() %></td>
                   <td><%= categoryService.getCategoryNameById(item.getCategoryId()) %></td>
                   <td><%= item.getQuantity() %></td>
                   <td>£<%= item.getPrice() %></td>
                   <% if(item.isDelivered()) { %> <td><span class="badge badge-success">Delivered</span></td>
                   <% } else { %> <td><span class="badge badge-danger">Not Delivered</span></td> <% } %>
                   <td><%=item.getDateCreated()%></td>
                   <td><%= item.getDateUpdated() == null ? "" : item.getDateUpdated()%></td>
                   <td><form action="../ProductOrderServlet" method="POST"><input type="hidden" name="product_order_id" value="<%=item.getId()%>"/><input type="hidden" name="order_id" value="<%=item.getOrderId()%>"/><input type="hidden" name="action" value="DELIVERED"/><% if(item.isDelivered()) { %><% } else { %><button class="btn btn-sm btn-primary">Delivered</button><% } %></form></td></tr> <% } %></tbody></table><% } %>
        </main>
      </div>
    </div>
