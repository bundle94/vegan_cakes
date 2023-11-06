<%@page session="true" import="java.util.*"%>
    <% Object loggedInSession = session.getAttribute("isLoggedIn");
    if(loggedInSession != null) {
        boolean isLoggedIn = (boolean)loggedInSession;
        if(!isLoggedIn) 
        {
            response.sendRedirect("signin.jsp");
        }
    }
    else
    {
        response.sendRedirect("signin.jsp");
    }%>
<%@page import="Store.Product"%>
<%@page import="Category.Category"%>
<%@page import="Category.CategoryDao"%>
<%@page import="Store.StoreService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" flush="true" />
        <div class="container" style="margin-top: 80px">
            <div class="row">
                <div class="col-4">
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
                <div class="col-8" id="cartbox">
                      <% StoreService storeService = new StoreService(); %>
  <% ArrayList  list = (ArrayList) session.getAttribute("shoppingcart"); %>
  <h3>My Cart</h3>
                    <% if(list == null || list.size() == 0) { %> <div class="alert alert-info" role="alert">Your shopping cart is empty, kindly go back to store and add items to your cart</div> 
                    <% } else { %>               <div class="alert alert-warning" role="alert">
                  <small>Before you proceed to the payment page, we want to ensure that you have reviewed the contents of your shopping cart carefully. This is a friendly reminder to confirm your selections.
                  If you have any doubts or if you wish to add more items to your order, please feel free to explore our category sections.</small>
              </div>
                    <table class="table table-striped">
  <thead>
    <tr>
      <th scope="col"></th>
      <th scope="col"></th>
      <th scope="col">Quantity</th>
      <th scope="col">Price</th>
      <th scope="col"></th>
    </tr>
  </thead>
  <tbody>
  <% for (int index=0; index <list.size();index++) {
   Product item = (Product) list.get(index);
              %><tr>
       <td><img src="data:image/png;base64,<%= item.getImage() %>" width="80" height="80" alt="<%= item.getName() %>"/></td>
      <td><%= item.getName() %></td>
      <td><%= item.getQuantity() %></td>
      <td>£<%= String.format("%.2f", item.getPrice()) %></td>
      <td><form name="deleteForm"
    action="CheckoutServlet"
    method="POST">
              <button type="submit" class="btn btn-danger btn-sm"><i class="fa fa-remove"></i></button>
   <input type="hidden" name= "deleteindex" value='<%= index %>'>
   <input type="hidden" name="action" value="DELETE">
      </form></td>
              </tr>
              <% } %> </tbody></table>
              <div class="dropdown-divider"></div>
              <div><b>TOTAL</b><span style="float:right"><b>£<%= String.format("%.2f",storeService.getCartTotal(list)) %></b></span></div><hr/>
              <div align="right">
                  <a data-toggle="modal" data-target="#ModalSlide2" href="#" class="btn btn-primary rounded">Pay Now</a>
              </div><% } %>
                </div>
            </div>
        </div>
    </body>
  <div class="modal fade" id="ModalSlide2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2" aria-hidden="true">
  <div class="modal-dialog modal-dialog-slideout"  style="max-width:60%;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title align-right" id="exampleModalLabel">MoneyPal Solutions</h5>

      </div>
      <div class="modal-body" style="margin-top:20px;">
                              <%
           String  error = (String) session.getAttribute("paymentError");
          ArrayList cart = (ArrayList) session.getAttribute("shoppingcart");
        %>
         <div class="row">
                          <div class="col-4 offset-2" id="paymentBox">
                                  <div class="alert alert-warning" role="alert">
                  <small>Kindly input your card details below, your details are secured with us</small>
              </div>
             <div class="alert alert-danger" id="error-message-container" style="display: none;"role="alert"><small id="error-message"></small></div>
    <div align="center">
    <img src="images/mastercard-logo.png" width="40" height="30"/><img src="images/visa-logo.png" width="50" height="30" style="margin-left: 60px;"/><img src="images/amex-logo.png" width="50" height="30" style="margin-left: 60px;"/>
    </div><br/>
                  <form>
                      <div class="form-row">
                          <div class="col">
                              <input type="text" name="name" id="name" class="form-control" placeholder="Card Name">
                              <small class="text-muted"><i class="fa fa-question-circle"></i> Full name as displayed on card</small>
                          </div>
                      </div><br/>
                      <div class="form-row">
                          <div class="col">
                              <input type="text" name="pan" id="pan" class="form-control" placeholder="Card Number">
                          </div>
                      </div><br/>
                      <div class="form-row">
                        <div class="col">
                          <input type="text" name="expiry" id="expiry" class="form-control" placeholder="MM/YY">
                        </div>
                        <div class="col">
                          <input type="password" name="cvv" id="cvv" class="form-control" placeholder="CVV">
                          <input type="hidden" name="action" value="ORDER"/>
                        </div>
                      </div><br/>
                        <div class="form-row">
                            <div class="col">
                                <button type="button" name="pay" id="pay" class="btn btn-primary btn-block">Pay £<%= String.format("%.2f",storeService.getCartTotal(cart)) %></button>
                            </div>
                        </div>
                        <div class="form-row">
                            <div align="center" class="col">
                            </div>
                        </div>
                    </form>
                
             </div>
                                                    <div class="col-md-4 order-md-2 mb-4">
          <h4 class="d-flex justify-content-between align-items-center mb-3">
            <span class="text-muted">Cart Summary</span>
          </h4>
          <ul class="list-group mb-3"><%if (cart != null) { %>
                              <% for (int index=0; index < cart.size();index++) {
                    Product item = (Product) cart.get(index); %>
            <li class="list-group-item d-flex justify-content-between lh-condensed">
              <div>
                  <h6 class="my-0"><%= item.getName() %></h6>
                  <small class="text-muted">Quantity (<%= item.getQuantity() %>)</small>
              </div>
              <span class="text-muted">£<%= String.format("%.2f", item.getPrice()) %></span>
            </li> <% } } %>
            <li class="list-group-item d-flex justify-content-between">
                <span><strong>Total (GBP)</strong></span>
              <strong>£<%= String.format("%.2f",storeService.getCartTotal(cart)) %></strong>
            </li>
          </ul>
        </div>
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
</html>
<script>
    $('#pay').click(function(){
        $(this).html('<img src="images/loader.gif" width="20" height="20">');
        var context = $(this);
                 $.ajax({
                    type: 'POST',
                    url: "OrderServlet",
                    data: {
                        action: 'ORDER',
                        pan: $('#pan').val(),
                        name: $('#name').val(),
                        cvv: $('#cvv').val(),
                        expiry: $('#expiry').val()
                    },
                    success: function( res ) {
                        if(res === "success") {
                            $('#ModalSlide2').modal('hide');
                            Swal.fire({
                              title: 'Payment Successful',
                              text: 'Thanks so much for your patronage, see you again.',
                              icon: 'success',
                              showCancelButton: false,
                              allowOutsideClick: false,
                              allowEscapeKey: false,
                              confirmButtonColor: '#3085d6',
                              confirmButtonText: 'OK'
                            }).then((result) => {
                              if (result.isConfirmed) {
                                window.location.replace("index.jsp");
                              }
                            });
                        }
                        else {
                            $('#error-message').html(res);
                            $('#error-message-container').slideDown('fast');
                            $(context).html('Pay £'+ <%= String.format("%.2f",storeService.getCartTotal(cart)) %>);
                        }
                    },
                    error:function(error) {
                      console.log(error);
                    }
                });
    });
</script>
