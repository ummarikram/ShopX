<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="ShopX.Orders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SHOPX-ORDERS</title>
    <link rel="stylesheet" href="Nav.css" />
    <link rel="stylesheet" href="Orders.css" />
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
                            <li ><a href="Home.aspx">Home</a></li>
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
                           <asp:Label ID="Profiler" runat="server">
                                 <li class="Active"><a href="Profile.aspx">Profile</a></li>
                             </asp:Label>
                            <asp:Label ID="Cart" runat="server">
                                <li><a href="MyCart.aspx">MyCart</a></li>
                            </asp:Label>
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

        <br/> <br/><br/><br/>
        <div class="OrderHeader">
             <b>MY ORDERS</b>
     </div>

        <asp:Label ID="OrderedProductsContainer" runat="server" CssClass="container">
            <div class="box"> 
                <div class="box-row"> 

                    
        <asp:DataList ID="UserOrders" runat="server"  RepeatColumns="1"
            RepeatDirection="Vertical" OnItemDataBound="UserOrders_ItemDataBound">
            <ItemTemplate>
            <table>

                <tr>
                    <div class="box-cell box1"> 
                       <%#Eval("ProductName") %>
                    </div> 
                      
                    <div class="box-cell box2"> 
                       $<%#Eval("ProductPrice") %>
                    </div> 
                      
                    <asp:Label ID="DisplayStatusForBuyer" runat="server" CssClass="box-cell box3"> 
                       <%#Eval("OrderStatus") %>
                    </asp:Label>

                    <asp:DropDownList ID="DisplayStatusForSeller" DataMember=' <%#Eval("OrderID") %>' AutoPostBack="true" OnSelectedIndexChanged="DisplayStatusForSeller_SelectedIndexChanged" CssClass="box-cell StatusDropDown" runat="server">
    <asp:ListItem Enabled="true" Text="Processing" Value="1"></asp:ListItem>
    <asp:ListItem Text="Shipped" Value="2"></asp:ListItem>
    <asp:ListItem Text="Delivered" Value="3"></asp:ListItem>
</asp:DropDownList>
                    
                    
                </tr>

            </table>
                </ItemTemplate>
           </asp:DataList>
                </div> 
            </div> 
        </asp:Label> 

    </form>
</body>
</html>
