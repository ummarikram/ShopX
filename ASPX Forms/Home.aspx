<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ShopX.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SHOPX-HOME</title>
    <link rel="stylesheet" href="Nav.css" />
    <link rel="stylesheet" href="Home.css" />
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
                            <li class="Active"><a href="#">Home</a></li>
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
        
        <br/> <br/><br/><br/> <br/> <br/><br/>
        
   <!-- Fashion Code Start --> 
        
         <div class="Fashion-slideshow-container">
           
            <div class="FashionHeader">
             <a href="Fashion.aspx">FASHION</a>
            </div>

            <br />
            <div class="FashionSlogan">
            <p>Fashion is a Statement!</p>
            </div>


            <asp:DataList ID="FashionProducts" runat="server"  RepeatColumns="1"
            RepeatDirection="Horizontal">
            <ItemTemplate>
            <table>

                <tr>
                      <div class="FashionSlides fade">
                          <a href="Product.aspx?Product=<%# Eval("ProductID") %>">
                        <img src="<%#Eval("Picture") %>" style="width:75%"/>
                             </a>
                              <div class="text" style="left:9%;"><%#Eval("ProductName") %></div>
                        </div>
                   
                </tr>
            </table>
                </ItemTemplate>
        </asp:DataList>
     
<a class="FashionPrev" onclick="FashionPlusSlides(-1)">&#10094;</a>
<a class="FashionNext" onclick="FashionPlusSlides(1)">&#10095;</a>

</div>
<br/>

         <!-- Fashion Code End --> 

           <!-- Electronics Code Start --> 
        
        <div class="Electronics-slideshow-container">
           
            <div class="ElectronicsHeader">
             <a  href="Electronics.aspx">ELECTRONICS</a>
            </div>

            <br />
            <div class="ElectronicsSlogan">
            <p>Technology is power!</p>
            </div>


            <asp:DataList ID="ElectronicsProducts" runat="server"  RepeatColumns="1"
            RepeatDirection="Horizontal">
            <ItemTemplate>
            <table>

                <tr>
                      <div class="ElectronicsSlides fade">
                          <a href="Product.aspx?Product=<%# Eval("ProductID") %>">
                        <img src="<%#Eval("Picture") %>" style="width:75%"/>
                        </a>
                              <div class="text" style="left:9%;"><%#Eval("ProductName") %></div>
                        </div>
                   
                </tr>
            </table>
                </ItemTemplate>
        </asp:DataList>

            
<a class="ElectronicsPrev" onclick="ElectronicsPlusSlides(-1)">&#10094;</a>
<a class="ElectronicsNext" onclick="ElectronicsPlusSlides(1)">&#10095;</a>

</div>
<br />

         <!-- Electronics Code End --> 

         <!-- Food Code Start --> 
        
        <div class="Food-slideshow-container">
           
            <div class="FoodHeader">
             <a href="Food.aspx">FOODS</a>
        </div>
       
        <br />

            <div class="FoodSlogan">
            <p>Food is happiness!</p>
            </div>


             <asp:DataList ID="FoodProducts" runat="server"  RepeatColumns="1"
            RepeatDirection="Horizontal">
            <ItemTemplate>
            <table>

                <tr>
                      <div class="FoodSlides fade">
                           <a href="Product.aspx?Product=<%# Eval("ProductID") %>">
                        <img src="<%#Eval("Picture") %>" style="width:75%"/>
                                </a>
                        <div class="text" style="left:9%;"><%#Eval("ProductName") %></div>
                        </div>
                   
                </tr>
            </table>
                </ItemTemplate>
        </asp:DataList>

        
<a class="FoodPrev" onclick="FoodPlusSlides(-1)">&#10094;</a>
<a class="FoodNext" onclick="FoodPlusSlides(1)">&#10095;</a>

</div>

         <!-- Food Code End --> 

          <!-- Site footer -->
    <footer>
            <br /> <br /> <br />
         <p>Copyright &copy; 2021 All Rights Reserved by 
         <a style="text-decoration:none;color:red;" href="Home.aspx">ShopX</a>.
            </p>
    </footer>

    </form>

    <script src="app.js"> </script>

</body>
</html>
