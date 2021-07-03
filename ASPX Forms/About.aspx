<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="ShopX.About" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SHOPX-ABOUT</title>
    <link rel="stylesheet" href="Nav.css" />
    <link rel="stylesheet" href="About.css" />
    
   
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
                            <asp:Label ID="Profiler" runat="server">
                                 <li><a href="Profile.aspx">Profile</a></li>
                             </asp:Label>
                            <asp:Label ID="Cart" runat="server">
                                <li><a href="MyCart.aspx">MyCart</a></li>
                            </asp:Label>
                            <li  class="Active"><a href="About.aspx">About</a></li>
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

        <div class="TeamHeader">
             <b>MEET OUR TEAM</b>
     </div>


     <div class="hvr-float">
      <div class="container">
    <img src="/WebImages/Ummar.jpg" alt="Ummar Ikram"/>
    <div class="overlay">UMMAR IKRAM</div>
        </div>
   </div>

        <div class="hvr-float">
      <div class="container">
    <img src="/WebImages/Umar.jpg" alt="Umar Farooq"/>
    <div class="overlay">UMAR FAROOQ</div>
        </div>
   </div>

        <div class="hvr-float">
      <div class="container">
    <img src="/WebImages/Junaid.jpg" alt="Junaid Afzal" />
    <div class="overlay">JUNAID AFZAL</div>
        </div>
   </div>


        <div class="hvr-float">
      <div class="container">
    <img src="/WebImages/Mubeen.jpeg" alt="Mubeen Zulfiqar"/>
    <div class="overlay">MUBEEN ZULFIQAR</div>
        </div>
   </div>
 
    </form>
 
</body>
</html>
