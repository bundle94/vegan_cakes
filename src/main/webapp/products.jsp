<%response.sendRedirect("index.jsp");%>
<%@page import="Store.Store"%>
<%@page import="Store.StoreDao"%>
<%@page import="Category.Category"%>
<%@page import="Category.CategoryDao"%>
<%@page import="Category.CategoryService"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    CategoryService categoryService = new CategoryService();
    String errmsg = "";
    int categoryId = request.getParameter("category") == null ? 1 : Integer.parseInt(request.getParameter("category"));
    List<Store> products = StoreDao.getProducts(categoryId);
    if (products == null || products.size() == 0) {
        errmsg = "There is no product yet for this category, please come back later";
    }
%>
                <div class="container" style="margin-top: 30px">
                    <div class="row">
                                <div class="col-md-4">
                                    <% 
    String nocatmsg = "";
    List<Category> categorys = CategoryDao.getList();
    if (categorys == null || categorys.size() == 0) {
        nocatmsg = "There is no category yet";
    }
%>
            <div style="position: fixed; width: 350px;">
                  <h4 class="d-flex justify-content-between align-items-center mb-3">
            <span class="text-muted">Categories</span>
          </h4>
         <%if(!nocatmsg.isEmpty()) { %>               
    <div class="alert alert-info"><%= nocatmsg %></div>
<%  } else { %>
          <ul class="list-group mb-3">
              <% for (int index=0; index < categorys.size();index++) {
   Category item = (Category) categorys.get(index);%>
            <li class="list-group-item d-flex justify-content-between lh-condensed">
              <div>
                  <h6 class="my-0"><a href="index.jsp?category=<%=item.getId()%>"><%= item.getTitle() %></a></h6>
                  <!--<small class="text-muted">40</small>-->
              </div>
            </li> <% }}%>
          </ul>
            </div>
        </div>
                        <div class="col col-8">
                            <div align="center" class="alert alert-secondary" role="alert"><h4><%= categoryService.getCategoryNameById(categoryId) %></h4></div>
                        
                    
                     <%if(!errmsg.isEmpty()) { %>               
    <div class="alert alert-info" role="alert"><%= errmsg %></div>
<%     } else { %> <div class="row"> <% for (int index=0; index < products.size();index++) {
   Store item =  (Store)products.get(index);
 %> 
                    
                   
                        <div class="col col-4" align="center" style="margin-top: 30px">
                                                
                      <img
                          src="data:image/png;base64,<%= item.getEncodedPhoto() %>"
                           width="200" height="250" max-height="200"alt="<%= item.getName() %>" style="max-height:250px;"><br/>
                      <small class="text-muted" style="margin-top: 5px"><%= item.getQuantity() %> Piece(s) available</small>
                      <h6 class="text-black mb-0"><%= item.getName() %>  <span><small>£<%= item.getPrice() %></small></span></h6>
                      <p style="margin-top: 5px;">   <form name="addForm"
    action="StoreServlet"
    method="POST"><input type="hidden" name="cat_id" value="<%=item.getCategoryId()%>"/><input type="hidden" name="image" value="<%=item.getEncodedPhoto()%>"/><input type="hidden" name="id" value="<%=item.getId()%>"/><input type="hidden" name="name" value="<%=item.getName()%>"/><input type="hidden" name="price" value="<%=item.getPrice()%>"/><input type="hidden" name="action" value="ADD"><input name="quantity" type="number" min="1" step="1" max="<%=item.getQuantity()%>" value="1" style="width:50px;"/> 
                          <% if(item.getQuantity() == 0) { %> <span class="badge badge-danger">Out of stock</span> <% } else { %> <button class="btn btn-primary btn-sm">Add to cart</button> <% } %></form></p>
                      </button>
                    
                        </div> <% } }%>

                    </div>
                </div>
