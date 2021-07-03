s<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="ShopX.Signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server"><title>SHOPX-SIGNUP</title>
    <link rel="stylesheet" href="Nav.css" />
    <link rel="stylesheet" href="Signup.css" />
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
                            <li class="Active"><a href="Signup.aspx">Signup</a></li>
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
        <h1 style="cursor:default;">Create Account</h1>

         <div class ="textbox">
        <i class="fas fa-user-tie"></i>
             
             <asp:TextBox ID="FnameTxt" runat="server" MaxLength="30" placeholder ="Enter your First Name"></asp:TextBox>
                
             
        </div>

            <asp:RegularExpressionValidator runat="server"  Display = "Dynamic"
                 ErrorMessage="Only Characters Allowed" ValidationExpression="^[A-Za-z]*$"
                 ControlToValidate="FnameTxt" ForeColor="Red">

             </asp:RegularExpressionValidator>

        <div class ="textbox">
         <i class="fas fa-lock"></i>
        <asp:TextBox ID="LnameTxt" runat="server" MaxLength="30"  placeholder ="Enter your Last Name"></asp:TextBox>
        </div>

            <asp:RegularExpressionValidator runat="server"  Display = "Dynamic"
                 ErrorMessage="Only Characters Allowed" ValidationExpression="^[A-Za-z]*$"
                 ControlToValidate="LnameTxt" ForeColor="Red">

             </asp:RegularExpressionValidator>


         <div class ="textbox">
         <i class="fas fa-lock"></i>
         <asp:TextBox ID="EmailTxt" runat="server" MaxLength="30" placeholder ="Enter your Email"></asp:TextBox>
        </div>

             <asp:RegularExpressionValidator runat="server"  Display = "Dynamic"
                 ErrorMessage="Enter Valid Email Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                 ControlToValidate="EmailTxt" ForeColor="Red">

             </asp:RegularExpressionValidator>


         <div class ="textbox">
         <i class="fas fa-lock"></i>
         <asp:TextBox ID="CityTxt" runat="server" MaxLength="30"  placeholder ="Enter your City"></asp:TextBox>
        </div>


            <asp:RegularExpressionValidator runat="server"  Display = "Dynamic"
                 ErrorMessage="Only Characters Allowed" ValidationExpression="^[A-Za-z]*$"
                 ControlToValidate="CityTxt" ForeColor="Red">

             </asp:RegularExpressionValidator>



         <div class ="textbox">
         <i class="fas fa-lock"></i>
        <asp:TextBox ID="PhoneTxt" runat="server" MaxLength="11"  placeholder ="Enter your Phone"></asp:TextBox>
        </div>

             <asp:RegularExpressionValidator runat="server"  Display = "Dynamic"
                 ErrorMessage="Enter Correct Phone Number" ValidationExpression="^([0-0]{1})([0-9]{10})$"
                 ControlToValidate="PhoneTxt" ForeColor="Red">

             </asp:RegularExpressionValidator>



        <div class ="textbox">
         <i class="fas fa-lock"></i>
         <asp:TextBox ID="PassTxt" runat="server" MaxLength="10" placeholder ="Enter Password"></asp:TextBox>
        </div>


            <asp:RegularExpressionValidator Display = "Dynamic" ControlToValidate = "PassTxt"
                ValidationExpression = "^[\s\S]{8,}$" runat="server" ForeColor="Red" ErrorMessage="Minimum 8 characters required.">

            </asp:RegularExpressionValidator>


        <div class ="textbox">
         <i class="fas fa-lock"></i>
         <asp:TextBox ID="CPassTxt" runat="server" TextMode="Password" MaxLength="10" placeholder ="Confirm Password"></asp:TextBox>
        </div>
            <br />
            <asp:RadioButton ID="rdSeller" GroupName="UserType" runat="server" />
            <b style="cursor:default;">SELLER</b>
            <asp:RadioButton ID="rdBuyer"  GroupName="UserType" runat="server" />
            <b style="cursor:default;">BUYER</b>

            <br /><br />

             <asp:Button ID="SignUpbtn" CssClass="btn" Text="Sign Up" runat="server" OnClick="SignUpbtn_Click" />
           
             <!-- Site footer -->

         
            </div>
   
    </form>
</body>
</html>
