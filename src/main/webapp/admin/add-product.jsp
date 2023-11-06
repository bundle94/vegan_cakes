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
    String errmsg = "";
    List<Category> categorys = CategoryDao.getList();
    if (categorys == null || categorys.size() == 0) {
        errmsg = "There is no category yet";
    }
    
%>
        <main role="main" style="min-height: 1000px;" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            

<div class="content-header">
<div class="container-fluid">
<div class="row mb-2">
<div class="col-sm-6">
<h1 class="m-0">Add Product</h1>
</div>
<div class="col-sm-6">
<ol class="breadcrumb float-sm-right">
    <li class="breadcrumb-item"><a href="index.jsp">Home</a></li>
    <li class="breadcrumb-item"><a href="products.jsp">Products</a></li>
    <li class="breadcrumb-item active" aria-current="page">Add Product</li>
</ol>
</div>
</div>
</div>
</div>
          <div style="margin-left: 15px;">
        <%
           String  error = (String) session.getAttribute("addProductError");
           String  success = (String) session.getAttribute("addProductSuccess");
        %>
                    <% if(error != null) { %> <div style="max-width: 600px;"><div class="alert alert-danger" role="alert"><small><%= error %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button></div></div> <% } %>
                    <% if(success != null) { %> <div style="max-width: 600px;"><div class="alert alert-success" role="alert"><small><%= success %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span></button></div></div> <% } %>
            <form method="POST" action="../CpanelStoreServlet" enctype="multipart/form-data">
                <label>Name</label>
                <input type="text" name="name" class="form-control" placeholder="Name" style="max-width: 600px;"/>
                                                <div class="form-row">
                    <div class="col">
                <label>Select Category</label>
                <select name="category" class="form-control" style="max-width: 600px;">
                <% for (int index=0; index <categorys.size();index++) {
                    Category item = (Category) categorys.get(index);
                    %>
                        <option value="<%=item.getId()%>"><%=item.getTitle()%></option><% } %>
                </select>
                <small class="text-muted"><i class="fa fa-question-circle"></i> Select the category to which this cake belongs to</small>
                    </div>
                                </div>
                <label>Thumbnail</label>
                <input type="file" name="fname" class="form-control" placeholder="Select Image" style="max-width: 600px;"/>
                <!--<div class="custom-file">
                  <input type="file" name="fname" class="custom-file-input form-control" id="customFile" style="max-width: 600px">
                  <label class="custom-file-label" for="customFile" style="max-width: 600px">Choose file</label>
                </div>-->
                <small class="text-muted"><i class="fa fa-question-circle"></i> Image to be uploaded must be in png, jpeg or jpg and must be less than 1MB</small><br/>
                <label>Quantity</label>
                <input type="text" name="quantity" class="form-control" placeholder="Quantity" style="max-width: 600px;"/>
                <label>Price</label>
                <input type="text" name="price" class="form-control" placeholder="price" style="max-width: 600px;"/><br/>
  
                <input type="hidden" name="action" value="CREATE"/>
                <button class="btn btn-primary">ADD CAKE</button>
            </form>
        </div>
        </main>
        <% session.removeAttribute("addProductError");
           session.removeAttribute("addProductSuccess");
        %>
      </div>
    </div>
