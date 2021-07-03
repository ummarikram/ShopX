using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using ShopX.DAL;

namespace ShopX
{
    public partial class Chat : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SearchBar.Attributes.Add("autocomplete", "off");

                if (Session["Username"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
                else if (Session["UserType"].ToString() != "SELLER")
                {
                    Response.Redirect("~/BuyerChat.aspx");
                }
                else
                {
                    Login.Visible = false;
                   
                    Cart.Visible = false;
                    
                    dal objMyDal = new dal();

                    DataTable dt = objMyDal.DisplayBuyerNamesChatBox(Session["Username"].ToString());

                    if (dt != null)
                    {
                        if (dt.Rows.Count > 0)
                        {
                            BuyerNamesLeft.DataSource = dt;
                            BuyerNamesLeft.DataBind();
                        }
                    }

                    if (dt.Rows.Count == 0)
                    {
                        ChatContainer.Visible = false;
                    }

                    TypedMessage.Visible = false;
                    SendMessage.Visible = false;
                }
            }
        }

        protected void SearchBar_TextChanged(object sender, EventArgs e)
        {
            dal objMyDal = new dal();

            string Query = SearchBar.Text;

            if (Query != "")
            {

                DataTable dt = objMyDal.ShowSearchQueuryProducts(Query);

                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        FoundProducts.DataSource = dt;
                        FoundProducts.DataBind();
                        ProductDropDown.Visible = true;
                    }
                }
            }
            else
            {
                ProductDropDown.Visible = false;
            }
        }
        public void ShowConversation(object sender, EventArgs e)
        {
            var myLI = (HtmlControl)sender;

            TypedMessage.Visible = true;
            SendMessage.Visible = true ;

            int BuyerID = Int16.Parse(myLI.Attributes["name"]);

            SendMessage.CommandArgument = BuyerID.ToString();

            dal objMyDal = new dal();

            DataTable dt = objMyDal.GetSelectedBuyerNameChatBox(BuyerID);

            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    BuyerNameTop.DataSource = dt;
                    BuyerNameTop.DataBind();
                }
            }

            if (Session["Username"] != null)
            {
                dt = objMyDal.ShowConversation(Session["Username"].ToString(), BuyerID);

                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        Messages.DataSource = dt;
                        Messages.DataBind();
                    }
                }

            }
        }

        protected void SendMessage_Click(object sender, EventArgs e)
        {
            string Message = TypedMessage.Value;

            TypedMessage.Value = string.Empty;

            Button btn = sender as Button;

            int BuyerID = Convert.ToInt32(btn.CommandArgument);

            dal objMyDal = new dal();

            int delivered = objMyDal.SendMessage(Message,"Seller", Session["Username"].ToString(),0,BuyerID);

            if (delivered == 1)
            {
                DataTable dt = objMyDal.ShowConversation(Session["Username"].ToString(), BuyerID);

                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        Messages.DataSource = dt;
                        Messages.DataBind();
                    }
                }
            }

        }
    }
}