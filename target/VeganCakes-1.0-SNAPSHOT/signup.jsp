<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <title>Signup page</title>
    </head>
    <body>
        <% String  error = (String) session.getAttribute("createError"); %>
        <div class="container" style="margin-top: 100px">
            <div align="center"><h2>VEGAN CAKES</h2></div>
            <div class="row">
                                <div class="col-8" style="margin-left: 0px; background-image: url('images/cake_bg.jpg');
  background-size: cover; height: 800px;">
                    
                </div>
                <div class="col-4 jumbotron" style="min-height: 800px;">
                    <% if(error != null) { %> <div class="alert alert-danger" role="alert"><small><%= error %></small> <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span></button></div> <% } %>
                    <form method="POST" action="CreateServlet">
                      <div align="center"><h3>Create Account</h3></div>
                      <div class="form-group">
                        <label for="exampleInputPassword1">Full Name</label>
                        <input type="text" name="name" class="form-control" placeholder="Full Name">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputEmail1">Email</label>
                        <input type="email" name="email" class="form-control" aria-describedby="emailHelp" placeholder="Enter email">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputPassword1">Phone Number</label>
                        <input type="text" name="phone" class="form-control" placeholder="Phone">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputPassword1">Address</label>
                        <input type="text" name="address" class="form-control" placeholder="Address">
                      </div>
                      <div class="form-group">
                        <label for="exampleInputPassword1">Password</label>
                        <input type="password" name="password" class="form-control" placeholder="Password">
                      </div>
                      <button type="submit" class="btn btn-primary btn-block">Sign me up</button>
                      <input type="hidden" name="action" value="CREATE">
                    </form>
                    <div align="center"><small>Already have an account? <a href="signin.jsp">login</a></small></div>
                </div> 
            </div>
                
        </div>
        <% session.removeAttribute("createError"); %>
    </body>
</html>
