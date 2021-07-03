<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="ShopX.Product" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SHOPX-PRODUCT</title>
    <link rel="stylesheet" href="Nav.css" />
    <link rel="stylesheet" href="Product.css" />
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


                  <div class="ProductHeader">
             <b>PRODUCT</b>
     </div>

              <asp:DataList ID="ProductInfo" runat="server"  RepeatColumns="1"
            RepeatDirection="Horizontal" OnItemDataBound="ProductInfo_ItemDataBound">
            <ItemTemplate>
            <table>

                <tr>

                      <div class="column">
                          
                            <div class="container">
   

                                                          <%-- --RATING----%>

                               <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
        <ajaxToolkit:Rating ID="ProductRating" runat="server" AutoPostBack="true" 
             StarCssClass="Star" WaitingStarCssClass="WaitingStar" EmptyStarCssClass="Star"
            FilledStarCssClass="FilledStar" MaxRating="5" CurrentRating="0" OnClick="ProductRating_Click">
        </ajaxToolkit:Rating>
   

                                <img src="<%#Eval("Picture") %>" alt="<%#Eval("ProductName") %>" style="width:100%"/>
                                
                                 <div class="overlay"> <%#Eval("ProductName") %> <br /> $<%#Eval("ProductPrice") %> </div>                               
                                
                                
                            </div>


                            <div class ="PDescription">
                          <p><%#Eval("ProductDescription") %></p>
                    </div>
                        </div>

                    
                   
                </tr>
            </table>
                </ItemTemplate>
        </asp:DataList>

                  
            <asp:ImageButton ID="AddToCart" CssClass="hvr-buzz2" ImageUrl="/WebImages/Cart.png"  AlternateText="Add To Cart" runat="server"  OnClick="AddToCart_Click"/>
             <asp:ImageButton ID="ChatSeller" CssClass="hvr-buzz" ImageUrl="/WebImages/Chat.png" AlternateText="Ask Seller" runat="server"  OnClick="ChatSeller_Click"/>
                 
                  
                   <%--   Chat Box Code--%>
          
        <div id="ChatPopUp" visible="false" runat="server" class="Chatcolumn">
                    
                    <div class="ChatBoxHeader">
                   <b style="color:white;">SHOPX CHAT</b>
                      <asp:ImageButton ID="CloseChatPopUp" runat="server" AlternateText="Close" ImageAlign="Right" Width="20" ImageUrl="/WebImages/Close.png" OnClick="CloseChatPopUp_Click" />
                    </div>

                    

                 
                   <div class="Chatcontainer">

                        <asp:DataList ID="Messages" CssClass="MessageStyle" runat="server"  RepeatColumns="1"
            RepeatDirection="Vertical">
            <ItemTemplate>
            <table>

                    <tr>

                        <hr />
                    <br />
                        <asp:Label ID="BuyerMessages" CssClass="BMessages" runat="server" Visible='<%# (Eval("SentBy").ToString() == "Seller") ? false : true %>'>
                        <img src="/WebImages/Avatar.jpg" alt="Avatar" class="right">
                        <p style="margin-top:20px;float:right;margin-right:20px;"><%#Eval("Message") %></p>

                         <br /><br />  <br /><br />
                         <span class="time-left"><%#Eval("Time") %></span>
                        </asp:Label>
                        
                         <asp:Label ID="SellerMessages" CssClass="SMessages" runat="server" Visible='<%# (Eval("SentBy").ToString() == "Buyer") ? false : true %>'>
                         <img src="/WebImages/Avatar.jpg" alt="Avatar">
                         <p style="margin-top:20px;"><%#Eval("Message") %></p>
                         <br /><br />
                         <span class="time-right"><%#Eval("Time") %></span>
                         </asp:Label>

                    </tr>

            </table>
                                 </ItemTemplate>
        </asp:DataList>

                     <hr /> <br />
                    <asp:TextBox runat="server" CssClass="MessageBox" ID="TypedMessage" placeholder="Enter Message"></asp:TextBox>
                       <asp:Button runat="server" ID="SendMessage" CssClass="SendMsgBtn" Text="SEND" OnClick="SendMessage_Click" />
                   </div>
         </div>
   
            <%--  Chat Box Code End--%>
                  
  </div>                  
                  <!-- Site footer -->

                
   

    </form>
</body>
</html>
