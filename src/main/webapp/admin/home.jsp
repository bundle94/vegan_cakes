<%response.sendRedirect("index.jsp");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">

    <title>VEGAN CAKES Admin</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.1/examples/dashboard/">

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
                <link href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/alertify.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/css/themes/bootstrap.min.css" integrity="sha512-6xVTeh6P+fsqDhF7t9sE9F6cljMrK+7eR7Qd+Py7PX5QEVVDLt/yZUgLO22CXUdd4dM+/S6fP0gJdX2aSzpkmg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/custom.min.css" rel="stylesheet">
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap4.min.css"/>
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap4.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/AlertifyJS/1.13.1/alertify.min.js"></script>
    <!-- Custom styles for this template -->
    <link href="dashboard.css" rel="stylesheet">
  </head>

  <body>
    <nav class="navbar navbar-expand-lg navbar-primary bg-lightblue">
      <a class="navbar-brand" href="dashboard.jsp" style="margin-left:20px;">VEGAN CAKES</a>
      <div class="container">
        
      </div>
                 <div class="collapse navbar-collapse" id="navbarColor02">

    </div>
              <ul class="navbar-nav mr-auto">
      <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" aria-haspopup="true" aria-expanded="false" style="color: white;"><i class="fa fa-user"></i> Administrator</a>
    <div class="dropdown-menu">
        <a class="dropdown-item logoutbtn" href="#"><i class="fa fa-sign-out"></i> Logout</a>
    </div>
      </li></ul>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar" style="min-height: 1000px;">
          <div class="sidebar-sticky">
            <ul class="nav flex-column" style="margin-top:10px;">
              <li >
                  <a href="index.jsp" style="margin-left: 20px;">
                  <span class="fa fa-home" style="font-size: 20px;"></span>
                  Home
                </a><hr/>
              </li>
              <li>
                <a href="orders.jsp" style="margin-left: 20px;">
                  <span class="fa fa-bell" style="font-size: 20px;"></span>
                  Orders
                </a><hr/>
              </li>
              <li>
                <a href="categories.jsp" style="margin-left: 20px;">
                  <span class="fa fa-bars" style="font-size: 20px;"></span>
                  Categories
                </a><hr/>
              </li>
              <li>
                <a href="products.jsp" style="margin-left: 20px;">
                  <span class="fa fa-tags" style="font-size: 20px;"></span>
                  Products
                </a><hr/>
              </li>
              <li>
                <a href="users.jsp" style="margin-left: 20px;">
                  <span class="fa fa-users" style="font-size: 20px;"></span>
                  Users
                </a>
              </li>
            </ul>
          </div>
        </nav>

    <script>
      
        $(document).on('click', '.logoutbtn', function(){
            alertify.defaults.theme.ok = "btn btn-danger";
            alertify.defaults.theme.cancel = "btn btn-default";
            alertify.confirm("Sure you want to logout?").set('onok', function () {
                $.ajax({
                    type: 'POST',
                    url: "../LoginServlet",
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

  </body>
</html>