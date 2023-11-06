<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <title>Signin page</title>
    </head>
    <body>
        <% String  success = (String) session.getAttribute("createSuccess"); 
           String  error = (String) session.getAttribute("loginError");
        %>
        <div class="container" style="margin-top: 100px">
            <div align="center"><h2>VEGAN CAKES</h2></div>
            <div class="row">
                <div class="col-8" style="margin-left: 0px; background-image: url('images/cake_bg3.jpg');
  background-size: cover; height: 800px;">
                    
                </div>
                <div class="col-4 jumbotron" style="min-height: 800px;">
                    <div align="center"><h3>Sign in</h3></div>
                    <% if(success != null) { %> <div class="alert alert-success" role="alert"><small><%= success %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span></button></div> <% } %>
                        <% if(error != null) { %> <div class="alert alert-danger" role="alert"><small><%= error %></small>  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span></button></div> <% } %>
                    <form method="POST" action="LoginServlet">
                      <div class="form-group">
                          <label for="exampleInputEmail1">Email</label>
                          <div class="input-group">  
                            <input type="email" class="form-control" name="email" placeholder="Enter email"/>
                          </div>
                      </div>
                      <div class="form-group">
                          <label for="exampleInputPassword">Password</label>
                          <div class="input-group">  
                            <input type="password" class="form-control" name="password" placeholder="Password"/>
                          </div>
                      </div>
                      <button type="submit" class="btn btn-primary btn-block">Sign in</button>
                      <input type="hidden" name="action" value="LOGIN">
                    </form>
                    <div align="center"><small>Want to enjoy our lovely pastries? <a href="signup.jsp">create an account</a></small></div>
                </div> 
            </div>
                
        </div>
        <% session.removeAttribute("loginError");
           session.removeAttribute("createSuccess");
        %>
    </body>
</html>
