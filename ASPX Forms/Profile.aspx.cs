using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using ShopX.DAL;

namespace ShopX
{
    public partial class Profile : System.Web.UI.Page
    {
        private void GetUserInfo()
        {
            if (!IsPostBack)
            {
                SearchBar.Attributes.Add("autocomplete", "off");

                if (Session["Username"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
                else
                {
                    Login.Visible = false;
                }

                Email.Text = Session["Username"].ToString();

                dal objMyDal = new dal();

                String FName = string.Empty, LName = string.Empty, city = string.Empty, phone = string.Empty, type = string.Empty, totalorders = string.Empty;

                objMyDal.GetUserInfo(ref FName, ref LName, Email.Text,ref type, ref phone, ref city, ref totalorders);

                if (type == "SELLER")
                {
                    Session["UserType"] = "SELLER";
                    Response.Redirect("~/SellerProfile.aspx");
                }

                Session["UserType"] = "BUYER";

                UserName.Text = FName + " " + LName;

                City.Text = city;

                Phone.Text = phone;

                Type.Text = type; 
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

        protected void Page_Load(object sender, EventArgs e)
        {
            GetUserInfo();
        }

        protected void LogoutBtn_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;

            Response.Redirect("~/Login.aspx");
        }

        protected void ShowMessages_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/BuyerChat.aspx");
        }

        protected void MyOrders_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Orders.aspx");
        }
    }
}