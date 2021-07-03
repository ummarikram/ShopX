<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fashion.aspx.cs" Inherits="ShopX.Fashion" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SHOPX-FASHION</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="Nav.css" />
    <link rel="stylesheet" href="Fashion.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="row">

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
                                     <a class="Active" href="Fashion.aspx">Fashion</a>
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

            
         
    <div class="FashionHeader">
             <b>FASHION</b>
     </div>


            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

          
              <asp:DataList ID="FashionProducts" runat="server"  RepeatColumns="2"
            RepeatDirection="Horizontal">
            <ItemTemplate>
            <table>

                <tr>
                      <div class="column">
                            <div class="hvr-float">

                                <ajaxToolkit:Rating ID="ProductRating" runat="server"
             StarCssClass="Star" WaitingStarCssClass="WaitingStar" EmptyStarCssClass="Star" 
            FilledStarCssClass="FilledStar" MaxRating="5" ReadOnly="true" CurrentRating='<%#Eval("Ranking") %>'>
        </ajaxToolkit:Rating>

                                <a href="Product.aspx?Product=<%# Eval("ProductID") %>">
                                 <img src="<%#Eval("Picture") %>" alt="<%#Eval("ProductName") %>" style="width:100%"/>
                                </a>
                                    <div class="overlay"> <%#Eval("ProductName") %> <br /> $ <%#Eval("ProductPrice") %> </div>                               
                                
                            </div>
                        </div>
                   
                </tr>
            </table>
                </ItemTemplate>
        </asp:DataList>


            
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
