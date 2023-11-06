<%@page import="Category.Category"%>
<%@page import="Category.CategoryDao"%>
<%@page import="Store.Product"%>
<%@page import="Store.StoreService"%>
<%@page import="User.User"%>
<%@page import="java.util.*"%>
<%@page session="true" contentType="text/html" pageEncoding="UTF-8"%>
<% 
    StoreService storeService = new StoreService();
    String errmsg = "";
    List<Category> categorys = CategoryDao.getList();
    if (categorys == null || categorys.size() == 0) {
        errmsg = "There is no category yet";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/themes/bootstrap.min.css" integrity="sha512-6xVTeh6P+fsqDhF7t9sE9F6cljMrK+7eR7Qd+Py7PX5QEVVDLt/yZUgLO22CXUdd4dM+/S6fP0gJdX2aSzpkmg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.min.css">
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.32/dist/sweetalert2.all.min.js"></script>
        <title>Home page</title>
                <style>
.modal-dialog {
  max-width: 25%;
}
.modal-dialog-slideout {
  min-height: 100%;
  margin: 0 0 0 auto;
  background: #fff;
}
.modal.fade .modal-dialog.modal-dialog-slideout {
  -webkit-transform: translate(100%, 0)scale(1);
  transform: translate(100%, 0)scale(1);
}
.modal.fade.show .modal-dialog.modal-dialog-slideout {
  -webkit-transform: translate(0, 0);
  transform: translate(0, 0);
  display: flex;
  align-items: stretch;
  -webkit-box-align: stretch;
  height: 100%;
}
.modal.fade.show .modal-dialog.modal-dialog-slideout .modal-body {
  overflow-y: auto;
  overflow-x: hidden;
}
.modal-dialog-slideout .modal-content {
  border: 0;
}
.modal-dialog-slideout .modal-header,
.modal-dialog-slideout .modal-footer {
  height: 4rem;
  display: block;
}
        </style>
    </head>
    <body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <a class="navbar-brand" href="index.jsp">VEGAN CAKES</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">

           <div class="collapse navbar-collapse" id="navbarColor02">

    </div>
          <ul class="navbar-nav mr-auto">    
      
            <li class="nav-item">
        <a class="nav-link"data-toggle="modal" data-target="#ModalSlide" href="#">
            <% ArrayList  list = (ArrayList) session.getAttribute("shoppingcart"); %> <i class="fa fa-shopping-basket"></i> My Cart <span class="badge badge-danger badge-pill"><%= list==null ? 0 : list.size() %></span>
        </a>
            </li>
                        <li class="nav-item">
        <a class="nav-link" href="#">
            |
        </a></li>
    </ul>
      <%
          ArrayList  userDetails = (ArrayList) session.getAttribute("loggedInUser");
          User userDetail = null;
          String fullname = "USER";
          if(userDetails != null) {
            userDetail = (User) userDetails.get(0);
          }
      %>
        <ul class="navbar-nav mr-auto">
      <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" aria-haspopup="true" aria-expanded="false"><i class="fa fa-user"></i> <%= userDetail == null ? fullname : userDetail.getFullName() %></a>
    <div class="dropdown-menu">
        <a class="dropdown-item logoutbtn" href="#"><i class="fa fa-sign-out"></i> Logout</a>
    </div>
      </li></ul>
  </div>
                      
</nav>
 <div class="modal fade" id="ModalSlide" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2" aria-hidden="true">
  <div class="modal-dialog modal-dialog-slideout" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title align-right" id="exampleModalLabel">Shopping Cart</h5>

      </div>
      <div class="modal-body" style="margin-top:20px;">
                 <% if(list == null || list.size() == 0) { %>
       <div class="alert alert-info" role="alert"><small>Your cart is empty!</small></div>
              <% }
 else 
 { %>
 <table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">Image</th>
      <th scope="col">Title</th>
      <th scope="col">Quantity</th>
      <th scope="col">Price</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
  <% for (int index=0; index <list.size();index++) {
   Product item = (Product) list.get(index);
              %><tr>
       <td><img src="data:image/png;base64,<%= item.getImage() %>" width="60" height="60" alt="<%= item.getName() %>"/></td>
       <td><small><%= item.getName() %></small></td>
      <td><small><%= item.getQuantity() %></small></td>
      <td><small>£<%= String.format("%.2f", item.getPrice()) %></small></td>
      <td><form name="deleteForm"
    action="StoreServlet"
    method="POST">
              <button type="submit" class="btn btn-danger btn-sm"><i class="fa fa-remove"></i></button>
   <input type="hidden" id="index" name= "deleteindex" value='<%= index %>'>
   <input type="hidden" id="catId" name= "cat_id" value='<%= item.getCategoryId() %>'>
   <input type="hidden" name="action" value="DELETE">
      </form></td>
              </tr>
              <% } %> </tbody></table>
              <div class="dropdown-divider"></div>
              <div class="dropdown-item"><b>TOTAL(GBP)</b><span style="float:right"><b id="amount">£<%= String.format("%.2f",storeService.getCartTotal(list)) %></b></span></div>
              <div class="dropdown-item" align="center"><a href="cart.jsp" class="btn btn-primary btn-block">Proceed to Checkout</a></div><% }%>
          
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<script>
            $(document).on('click', '.logoutbtn', function(){
            alertify.defaults.theme.ok = "btn btn-danger";
            alertify.defaults.theme.cancel = "btn btn-default";
            alertify.confirm("Sure you want to logout?").set('onok', function () {
                $.ajax({
                    type: 'POST',
                    url: "LoginServlet",
                    data: {
                        action: 'LOGOUT'
                    },
                    success: function( res ) {
                        if(res === "success") {
                            window.location.replace("signin.jsp");
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
            }).set({title: "Logout"}).set({labels: {ok: 'Continue', cancel: 'Cancel'}});
        });
</script>