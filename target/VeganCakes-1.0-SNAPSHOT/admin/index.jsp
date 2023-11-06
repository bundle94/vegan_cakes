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
<%@page import="Store.*"%>
<%@page import="User.*"%>
<%@page session="true" import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="home.jsp" flush="true" />
<%
    OrderDao orderDao = new OrderDao();
    CategoryDao categoryDao = new CategoryDao();
    StoreDao storeDao = new StoreDao();
    UserDao userDao = new UserDao();
%>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                    <div class="content-header">
<div class="container-fluid">
<div class="row mb-2">
<div class="col-sm-6">
<h1 class="m-0">Home</h1>
</div>
<div class="col-sm-6">
<ol class="breadcrumb float-sm-right">
    <li class="breadcrumb-item active" aria-current="page">Home</li>
</ol>
</div>
</div>
</div>
</div>
            <section class="content">
<div class="container-fluid">

<div class="row">
<div class="col-12 col-sm-6 col-md-3">
<div class="info-box">
<span class="info-box-icon bg-info elevation-1"><i class="fa fa-bell"></i></span>
<div class="info-box-content">
<span class="info-box-text">New Order</span>
<span class="info-box-number">
    <a href="orders.jsp"><%= orderDao.getCountofNewOrders() %></a>
</span>
</div>

</div>

</div>

<div class="col-12 col-sm-6 col-md-3">
<div class="info-box mb-3">
<span class="info-box-icon bg-danger elevation-1"><i class="fa fa-tags"></i></span>
<div class="info-box-content">
<span class="info-box-text">Products</span>
<span class="info-box-number"><a href="products.jsp"><%= storeDao.getCountofProducts() %></a></span>
</div>

</div>

</div>


<div class="clearfix hidden-md-up"></div>
<div class="col-12 col-sm-6 col-md-3">
<div class="info-box mb-3">
<span class="info-box-icon bg-success elevation-1"><i class="fa fa-bars"></i></span>
<div class="info-box-content">
<span class="info-box-text">Categories</span>
<span class="info-box-number"><a href="categories.jsp"><%= categoryDao.getCountofCategories() %></a></span>
</div>

</div>

</div>

<div class="col-12 col-sm-6 col-md-3">
<div class="info-box mb-3">
<span class="info-box-icon bg-warning elevation-1"><i class="fa fa-users"></i></span>
<div class="info-box-content">
<span class="info-box-text">Users</span>
<span class="info-box-number"><a href="users.jsp"><%= userDao.getCountofUsers() %></a></span>
</div>

</div>

</div>

</div>
</div>
        </main>
      </div>
    </div>
