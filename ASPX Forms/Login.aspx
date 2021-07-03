<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ShopX.Login" %>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>SHOPX-LOGIN</title>
        <link rel="stylesheet" href="Nav.css" />
        <link rel="stylesheet" href="Login.css" />
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

                            <li class="Active"><a href="Login.aspx">Login</a></li>

                            <li><a href="Signup.aspx">Signup</a></li>
                            <asp:Label ID="Profiler" runat="server">
                                 <li><a href="Profile.aspx">Profile</a></li>
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


          <div class ="login-box">
        <h1 style="cursor:default;">Login</h1>

         <div class ="textbox">
        <i class="fas fa-user-tie"></i>
              <asp:TextBox ID="EmailTxt" runat="server" MaxLength="30"  placeholder ="Email"></asp:TextBox>
        </div>

               <asp:RegularExpressionValidator runat="server"  Display = "Dynamic"
                 ErrorMessage="Enter Valid Email Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                 ControlToValidate="EmailTxt" ForeColor="Red">

             </asp:RegularExpressionValidator>


        <div class ="textbox">
         <i class="fas fa-lock"></i>
                     <asp:TextBox ID="PasswordTxt" runat="server" TextMode="Password" MaxLength="10" placeholder ="Password"></asp:TextBox>

       
        </div>

              <asp:CheckBox ID="RememberCheck" Text="   Remember me" runat="server"/>
               <asp:Button ID="Loginbtn" CssClass="btn" Text="Sign In" runat="server" OnClick="Loginbtn_Click"/>
                <asp:Button ID="Signupbtn" CssClass="btn" Text="Sign Up" runat="server" OnClick="Signupbtn_Click"/>

        </div> 
 
            </form>
        </body>  
</html>
