<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellerChat.aspx.cs" Inherits="ShopX.Chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SHOPX-CHAT</title>
	<link rel="stylesheet" href="Nav.css" />
	<link rel="stylesheet" href="Chat.css" />
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
        <div class="ChatHeader">
             <b>CHAT ROOM</b>
     </div>
        
        <asp:Label ID="ChatContainer" runat="server" >
        <div id="container">
	<aside>
		<ul>
			
              <%--USER LIST--%>
                <asp:DataList ID="BuyerNamesLeft" runat="server"  RepeatColumns="1"
            RepeatDirection="Horizontal">
            <ItemTemplate>
            <table>

                <tr>

			<li id="SelectedBuyer" runat="server">
				<a style="text-decoration:none; padding: 0px 5px;" runat="server" name='<%#Eval("BuyerID") %>' onserverclick="ShowConversation">
                <img src="/WebImages/Avatar.jpg" width="50" alt="<%#Eval("BuyerName") %>"/>
				<div >
					<h2 style="text-align:center;padding-left:5px;"><%#Eval("BuyerName") %></h2>
                  
				</div>

                    </a>

            </li>
               </tr>
            </table>
                </ItemTemplate>
            <SeparatorTemplate>
    <h4 class="OrderHistory_RowSeparator"></h4>
</SeparatorTemplate>
        </asp:DataList>

		   
		</ul>
	</aside>
	<main>
		<header>

             <asp:DataList ID="BuyerNameTop" runat="server"  RepeatColumns="1"
            RepeatDirection="Vertical">
            <ItemTemplate>
            <table>

                <tr><div>
			<img src="/WebImages/Avatar.jpg" width="50" alt='<%#Eval("BuyerName")%>'/>
			
				<h2 style="float:right;text-align:center; margin-top:20px; margin-left:20px;"><%#Eval("BuyerName") %></h2>
			</div>


                      </tr>

            </table>
                </ItemTemplate>
        </asp:DataList>
		</header>

		<div id="chat">

            
          <asp:DataList ID="Messages"  Width="100%" runat="server"  RepeatColumns="1"
            RepeatDirection="Vertical">
            <ItemTemplate>
            <table>

                <tr>
               <asp:Label ID="BuyerMessages" runat="server" Visible='<%# (Eval("SentBy").ToString() == "Seller") ? false : true %>'>
			            <li class="you">

				<div class="entete">
					<h3><%#Eval("Time") %></h3>
				</div>
				<div class="message">
					<%#Eval("Message") %>
				</div>
              
			            </li>
            </asp:Label>
                <asp:Label ID="SellerMessages" runat="server" Visible='<%# (Eval("SentBy").ToString() == "Buyer") ? false : true %>'>
			<li class="me">

                
				<div  class="entete">
					<h3><%#Eval("Time") %></h3>
				</div>
				<div class="message">
					<%#Eval("Message") %>
				</div>

            </li>
            </asp:Label>  
               </tr>
            </table>
                </ItemTemplate>
        </asp:DataList>
			
		</div>	

         <footer>
			<textarea id="TypedMessage" runat="server" placeholder="Type your message"></textarea>
			<asp:Button ID="SendMessage" runat="server" Text="SEND" CssClass="SendMsgBtn" OnClick="SendMessage_Click" />
		</footer>
	</main>
</div>
         </asp:Label>

        
    </form>
</body>
</html>
