<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateProduct.aspx.cs" Inherits="ShopX.UpdateProduct" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UPDATE PRODUCT</title>
    <meta name="viewport" content="width=device-width , intital-scale=1.0" />
    <meta charset="utf-8" />
    <link rel="shortcut icon" href="/assests/favicon/ico" />
    <link rel="stylesheet" href="Nav.css" />
     <link rel="stylesheet" href="UpdateProduct.css" />
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

             <div class ="login-box">
        <h1>UPDATE PRODUCT DETAILS</h1>

         <div class ="textbox">
        <i class="fas fa-user-tie"></i>
             
             <asp:TextBox ID="PName" runat="server" MaxLength="30" placeholder ="Enter Product Name"></asp:TextBox>
                
             
        </div>

           

        <div class ="textbox">
         <i class="fas fa-lock"></i>
        <asp:TextBox ID="PDescription" runat="server" MaxLength="100"  placeholder ="Enter Product Description"></asp:TextBox>
        </div>

        <div class ="textbox">
         <i class="fas fa-lock"></i>
        <asp:TextBox ID="PPrice" runat="server" placeholder ="Enter Product Price"></asp:TextBox>
        </div>


         <asp:RegularExpressionValidator runat="server"  Display = "Dynamic"
                 ErrorMessage="Only Digits Allowed" ValidationExpression="^\d+$"
                 ControlToValidate="PPrice" ForeColor="Red">

             </asp:RegularExpressionValidator>
  
                  <asp:FileUpload ID="ImageUpload" runat="server"/>
                   
                  <br />  <br />
            <asp:RadioButton ID="rdFashion" GroupName="ProductType" runat="server" />
            <b>FASHION</b>
            <asp:RadioButton ID="rdElectronics"  GroupName="ProductType" runat="server" />
            <b>ELECTRONICS</b>
                 <asp:RadioButton ID="rdFood"  GroupName="ProductType" runat="server" />
            <b>FOOD</b>
         
                <br />
        <asp:Button ID="UpdProductbtn" CssClass="btn" Text="Update Product" runat="server" OnClick="UpdProductbtn_Click"/>
            </div>
    </form>
</body>
</html>
