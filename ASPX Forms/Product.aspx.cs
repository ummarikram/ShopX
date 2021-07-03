using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using AjaxControlToolkit;
using ShopX.DAL;

namespace ShopX
{
    public partial class Product : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SearchBar.Attributes.Add("autocomplete", "off");

                if (Session["Username"] == null)
                {
                    Profiler.Visible = false;
                    Cart.Visible = false;
                }
                else
                {
                    Login.Visible = false;

                    if (Session["UserType"].ToString() == "SELLER")
                    {
                        Cart.Visible = false;
                    }

                    
                }


                if (Request.QueryString["Product"] != null)
                {
                    dal objMyDal = new dal();

                    string Sid = Request.QueryString["Product"].ToString();
                    int ProductID = Int16.Parse(Sid);


                    DataTable dt = objMyDal.ShowExistingProductDetails(ProductID);

                    if (dt != null)
                    {
                        if (dt.Rows.Count > 0)
                        {
                            ProductInfo.DataSource = dt;
                            ProductInfo.DataBind();
                        }
                    }

                   
                }
                else
                {
                    Response.Redirect("~/Home.aspx");
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
        protected void ChatSeller_Click(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            else if (Session["UserType"].ToString() == "SELLER")
            {
                Response.Write("<script> alert('Permission denied!'); </script>");
            }
            else
            {

                ChatPopUp.Visible = true;
                ChatSeller.Visible = false;
                AddToCart.Visible = false;

                string Sid = Request.QueryString["Product"].ToString();
                int ProductID = Int16.Parse(Sid);

                dal objMyDal = new dal();

                DataTable dt = objMyDal.ShowConversationBuyerSide(Session["Username"].ToString(), ProductID);

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
            string Message = TypedMessage.Text;
            TypedMessage.Text = string.Empty;

            string Sid = Request.QueryString["Product"].ToString();
            int ProductID = Int16.Parse(Sid);

            dal objMyDal = new dal();

            int delivered = objMyDal.SendMessage(Message,"Buyer", Session["Username"].ToString(),ProductID);

            if (delivered == 1)
            {

                DataTable dt = objMyDal.ShowConversationBuyerSide(Session["Username"].ToString(), ProductID);

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

        protected void CloseChatPopUp_Click(object sender, ImageClickEventArgs e)
        {
            ChatPopUp.Visible = false;
            ChatSeller.Visible = true;
            AddToCart.Visible = true;
        }

        protected void ProductInfo_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item)
            {
                dal objMyDal = new dal();

                string Sid = Request.QueryString["Product"].ToString();
                int ProductID = Int16.Parse(Sid);

                AddToCart.CommandArgument = ProductID.ToString();

                DataTable dt = new DataTable();

                if (Session["Username"] == null)
                {
                    dt = objMyDal.GetProductRating(ProductID);
                }
                else if (Session["UserType"].ToString() == "SELLER")
                {
                    dt = objMyDal.GetProductRating(ProductID);
                }
                else
                {
                    dt = objMyDal.GetUserProductRating(ProductID, Session["Username"].ToString());
                }


                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        Rating ProductRating = (Rating)e.Item.FindControl("ProductRating");

                        ProductRating.CurrentRating = Convert.ToInt32(dt.Rows[0]["Ranking"]);
                    }
                }

            }
        }

        protected void ProductRating_Click(object sender, RatingEventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            else if (Session["UserType"].ToString() == "SELLER")
            {
                Response.Write("<script> alert('Permission denied!'); </script>");
            }
            else
            {

                int RankingGiven = Int16.Parse(e.Value.ToString());

                dal objMyDal = new dal();

                string Pid = Request.QueryString["Product"].ToString();
                int ProductID = Int16.Parse(Pid);

                
                objMyDal.GiveProductRating(ProductID, Session["Username"].ToString(), RankingGiven);
            }
        }

        protected void AddToCart_Click(object sender, ImageClickEventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            else if (Session["UserType"].ToString() == "SELLER")
            {
                Response.Write("<script> alert('Permission denied!'); </script>");
            }
            else
            {
                ImageButton btn = sender as ImageButton;

                int ProductID = Convert.ToInt32(btn.CommandArgument);

                dal objMyDal = new dal();

                int Added = objMyDal.AddToCart(ProductID, Session["Username"].ToString());

                if (Added == 1)
                {
                    Response.Write("<script> alert('Product Added to Cart!'); </script>");
                }
            }
        }
    }
}