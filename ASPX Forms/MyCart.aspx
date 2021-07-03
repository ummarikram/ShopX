<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyCart.aspx.cs" Inherits="ShopX.MyCart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SHOPX-CART</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="stylesheet" href="Nav.css" />
    <link rel="stylesheet" href="MyCart.css" />
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <div class="wrapper">
                <nav>
                    <div class = "main">
                    <div class ="Logo">
                        <a href="Home.aspx">
                            <img src="/WebImages/ShopXLogo.png" />
                         </a>
                    </div>
                        <ul>
                            <li><a href="Home.aspx">Home</a></li>
                            <li class="Categories">
                                <a href="#" class="dropbtn">Categories</a>
                                <div class="dropdown-content">
                                     <a href="Fashion.aspx">Fashion</a>
                                     <a href="Electronics.aspx">Electronics</a>
                                     <a href="Food.aspx">Food</a>
                                 </div>
                            </li>
                            <asp:Label ID="Login" runat="server">
                            <li><a href="Login.aspx">Login</a></li>
                            </asp:Label>
                            <li><a href="Signup.aspx">Signup</a></li>
                            
                                 <li><a href="Profile.aspx">Profile</a></li>
                                <li class="Active"><a href="MyCart.aspx">MyCart</a></li>
                        
                            <li><a href="About.aspx">About</a></li>
                        </ul>   
                    </div>
                    
                    <asp:TextBox  ID="SearchBar" AutoPostBack="true" runat="server" OnTextChanged="SearchBar_TextChanged"  CssClass="SearchStyle"></asp:TextBox>
                 
<asp:Label runat="server" ID="ProductDropDown" CssClass="list-group">
       <asp:DataList ID="FoundProducts" runat="server"  RepeatColumns="1"
            RepeatDirection="Vertical">
            <ItemTemplate>
            <table>

                <tr>

                    <a style="text-decoration:none;color:black;" href="Product.aspx?Product=<%# Eval("ProductID") %>"><%# Eval("ProductName") %></a>
                    
                    </tr>
            </table>
                </ItemTemplate>
        </asp:DataList>
</asp:Label>

                    <div class ="SearchLogo">

                        <asp:ImageButton runat="server" OnClick="SearchBar_TextChanged" AlternateText="Search" CssClass="SearchIcon" ImageUrl="/WebImages/SearchIcon.png" />

                    </div>  

                </nav>
            </div>
            
        </header>

        <br />  <br /> 
        <br />  <br />
        <br />  <br />

        <div class="row">
  <div class="col-75">
    <div class="container">
        <h1 style="font-family: 'Century Gothic';">BILLING INFORMATION</h1> <br />
         <asp:RadioButton ID="rdCOD" Checked="true" AutoPostBack="true" OnCheckedChanged="SelectedPaymentType" GroupName="PaymentType" runat="server" />
            <b style="cursor:default;">Cash on Delivery</b>
            <asp:RadioButton ID="rdCARD" AutoPostBack="true" OnCheckedChanged="SelectedPaymentType"  GroupName="PaymentType" runat="server" />
            <b style="cursor:default;">Credit/Debit Card</b>
        <div class="row">
          <asp:Label ID="COD" runat="server" CssClass="col-50">
            <h3>Shipping Address</h3>
              <br />
              <asp:Label runat="server" Text=" Full Name" CssClass="fa fa-user"></asp:Label>
           <asp:TextBox ID="FullName" runat="server" placeholder="John M. Doe"></asp:TextBox>
           

                <asp:Label runat="server" Text=" Email" CssClass="fa fa-envelope"></asp:Label>
             <asp:TextBox ID="Email" runat="server" placeholder="john@example.com"></asp:TextBox>
            
               <asp:Label runat="server" Text=" Address" CssClass="fa fa-address-card-o"></asp:Label>
            <asp:TextBox ID="Address" runat="server" placeholder="Your Address"></asp:TextBox>
            
                <asp:Label runat="server" Text=" City" CssClass="fa fa-institution"></asp:Label>
            <asp:TextBox ID="City" runat="server" placeholder="New York"></asp:TextBox>

          </asp:Label>

          <asp:Label ID="CARD" Visible="false" runat="server" class="col-50">
             <h3>Card Details</h3>
              <br />
              <asp:Label runat="server" Text=" Name on Card" CssClass="fa fa-user"></asp:Label>
           <asp:TextBox ID="FullNameCard" runat="server" placeholder="John M. Doe"></asp:TextBox>
           

                <asp:Label runat="server" Text=" Card Number" CssClass="fa fa-address-card-o"></asp:Label>
             <asp:TextBox ID="CardNumber" runat="server" placeholder="111-222-333"></asp:TextBox>
            
               <asp:Label runat="server" Text=" Expiry" CssClass="fa fa-address-card-o"></asp:Label>
            <asp:TextBox ID="CardExpiry" runat="server" placeholder="MM/YYYY"></asp:TextBox>
            
                <asp:Label runat="server" Text=" CVV" CssClass="fa fa-address-card-o"></asp:Label>
            <asp:TextBox ID="CardCVV" MaxLength="3" runat="server" placeholder="789"></asp:TextBox>
          
          </asp:Label>
          
        </div>
        
        <asp:Button ID="Checkout" runat="server" CssClass="btn" Text="Place Order" OnClick="Checkout_Click" />

    </div>
  </div>


           
                      
           <div class="col-25">


                        <div class="container">
     <h4 style="font-size:30px;">Cart <span class="price" style="color:black"><i class="fa fa-shopping-cart"></i>
         <asp:Label ID="CartProductCount" runat="server" Text=""></asp:Label>
              </span></h4>
            <hr /> <br />
              <asp:DataList ID="ProductsInCart" runat="server" RepeatDirection="Vertical" RepeatColumns="1">
            <ItemTemplate>
            <table>

                <tr>

                    <h2 style="font-size:20px;font-weight:lighter;"><%#Eval("ProductName") %>  <span class="price" style="color:black"></span></h2>
                      
                      <h2 style="font-size:20px;">$<%#Eval("ProductPrice") %></h2>
                          <asp:Button ID="RemoveProduct" CssClass="hvr-buzz-out" Text="Remove" runat="server" CommandArgument='<%# Eval("ProductID") %>' OnClick="RemoveProduct_Click"/>

                      
                    
                        
                   
                        
                   
                </tr>
            </table>
                </ItemTemplate>
                   <SeparatorTemplate>
                    <table width="20">
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </SeparatorTemplate>
        </asp:DataList>
                            <br />
                <hr /> 
                            <h4 style="font-size:30px;">Total <span class="price" style="color:black">
         <asp:Label ID="TotalPrice" runat="server" Text=""></asp:Label>
              </span></h4>
                            
                        </div>
  </div>
                   
               
</div>

         <footer>
            <br /> <br /> <br />
         <p>Copyright &copy; 2021 All Rights Reserved by 
         <a style="text-decoration:none;color:red;" href="Home.aspx">ShopX</a>.
            </p>
    </footer>
    </form>
</body>
</html>
