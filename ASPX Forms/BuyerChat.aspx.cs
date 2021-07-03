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
    public partial class BuyerChat : System.Web.UI.Page
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
                else if (Session["UserType"].ToString() == "SELLER")
                {
                    Response.Redirect("~/SellerChat.aspx");
                }
                else
                {
                    Login.Visible = false;

                    dal objMyDal = new dal();

                    DataTable dt = objMyDal.DisplaySellerNamesChatBox(Session["Username"].ToString());

                    if (dt != null)
                    {
                        if (dt.Rows.Count > 0)
                        {
                            SellerNamesLeft.DataSource = dt;
                            SellerNamesLeft.DataBind();
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
            TypedMessage.Visible = true;
            SendMessage.Visible = true;

            var myLI = (HtmlControl)sender;

            int SellerID = Int16.Parse(myLI.Attributes["name"]);

            SendMessage.CommandArgument = SellerID.ToString();

            dal objMyDal = new dal();

            DataTable dt = objMyDal.GetSelectedSellerNameChatBox(SellerID);

            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    SellerNameTop.DataSource = dt;
                    SellerNameTop.DataBind();
                }
            }

            if (Session["Username"] != null)
            {
                dt = objMyDal.ShowConversation(Session["Username"].ToString(),0,SellerID);

                if (dt != null)
                {
                    Messages.DataSource = dt;
                    Messages.DataBind();
                }

            }
        }


        protected void SendMessage_Click(object sender, EventArgs e)
        {
            string Message = TypedMessage.Value;

            TypedMessage.Value = string.Empty;

            Button btn = sender as Button;

            int SellerID = Convert.ToInt32(btn.CommandArgument);

            dal objMyDal = new dal();

            int delivered = objMyDal.SendMessage(Message, "Buyer", Session["Username"].ToString(), 0, 0, SellerID);

            if (delivered == 1)
            {
                DataTable dt = objMyDal.ShowConversation(Session["Username"].ToString(),0, SellerID);

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