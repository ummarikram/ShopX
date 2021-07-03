<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellerProfile.aspx.cs" Inherits="ShopX.SellerProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profile</title>
    <meta name="viewport" content="width=device-width , intital-scale=1.0" />
    <meta charset="utf-8" />
    <link rel="shortcut icon" href="/assests/favicon/ico" />
    <link rel="stylesheet" href="Nav.css" />
     <link rel="stylesheet" href="SellerProfile.css" />
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

                                 <li class="Active"><a href="Profile.aspx">Profile</a></li>
                               
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

         <br />

                 <div class="profile">

        <img src="/WebImages/Avatar.jpg" alt="Profile Image"  class="profile__image"/>
        <div class="profile__name">
            <asp:Label runat="server" Text="" ID="UserName">

            </asp:Label>
        </div>
        <div class="profile__title">
             <asp:Label runat="server" Text="" ID="Email">

            </asp:Label>
        </div>
        <div class="profile__detail">
             <asp:Label runat="server" Text="" ID="City">
            </asp:Label>
        </div>
         <div class="profile__detail">
             <asp:Label runat="server" Text="" ID="Phone">

            </asp:Label>
         </div>

         <div class="profile__detail">
             <asp:Label runat="server" Text="" ID="Type">

            </asp:Label>
       </div>
        
        <br />
        <asp:Button ID="LogoutBtn" CssClass="LogoutBtn" Text="Logout" runat="server" OnClick="LogoutBtn_Click"/>
        
         <br /> <br />
        <asp:Button ID="AddProduct" CssClass="AddProductBtn" Text="Add Products" runat="server" OnClick="AddProduct_Click"/>
        
                     <br /> <br />
        <asp:Button ID="ShowMessages" CssClass="ShowMsgBtn" Text="My Messages" runat="server" OnClick="ShowMessages_Click"/>
   <br /> <br />
        <asp:Button ID="MyOrders" CssClass="ShowMsgBtn" Text="My Orders" runat="server" OnClick="MyOrders_Click"/>
                 
                 </div>

        <br /><br />
     
   
        <asp:Label ID="PHeader" runat="server">
        <div class="ProductsHeader">
             <b>PRODUCTS</b>
        </div>
        </asp:Label>

        <asp:DataList ID="SellerProducts" runat="server"  RepeatColumns="2"
            RepeatDirection="Horizontal">
            <ItemTemplate>
            <table>

                <tr>
                      <div class="column">
                            <div class="container">

                                <asp:Button ID="UpdProduct" CssClass="UpdPdtBtn" Text="Update" runat="server" CommandArgument='<%# Eval("ProductID") %>' OnClick="UpdProduct_Click"/>
                                <asp:Button ID="RemoveProduct" CssClass="RemovePdtBtn" Text="Remove" runat="server" CommandArgument='<%# Eval("ProductID") %>' OnClick="RemoveProduct_Click"/>

                                 <img src="<%#Eval("Picture") %>" style="width:100%"/>
                                  <div class="overlay"> <%#Eval("ProductName") %> <br /> $ <%#Eval("ProductPrice") %> </div>                               
                             </div>
                        </div>
                   
                </tr>
            </table>
                </ItemTemplate>
        </asp:DataList>
       

         <br /><br /><br />
       
<footer>
           
         <p>Copyright &copy; 2021 All Rights Reserved by 
        <a style="text-decoration:none;color:red;" href="Home.aspx">ShopX</a>.
            </p>
    </footer>
    </form>
</body>
</html>
