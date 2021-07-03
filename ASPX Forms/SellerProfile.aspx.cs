using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using ShopX.DAL;
using System.IO;

namespace ShopX
{
    public partial class SellerProfile : System.Web.UI.Page
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
                else
                {
                    Login.Visible = false;
                }

                Email.Text = Session["Username"].ToString();

                dal objMyDal = new dal();

                String FName = string.Empty, LName = string.Empty, city = string.Empty, phone = string.Empty, type = string.Empty, totalorders = string.Empty;

                objMyDal.GetUserInfo(ref FName, ref LName, Email.Text, ref type, ref phone, ref city, ref totalorders);

                UserName.Text = FName + " " + LName;

                City.Text = city;

                Phone.Text = phone;

                Type.Text = type;

                int ProductCount = objMyDal.GetProductCount(Email.Text);

                if (ProductCount == 0)
                {
                    PHeader.Visible = false;
                }

                else
                {

                    // Display Products

                    DataTable dt = objMyDal.DisplaySellerProducts(Email.Text);

                    if (dt != null)
                    {
                        if (dt.Rows.Count > 0)
                        {
                            SellerProducts.DataSource = dt;
                            SellerProducts.DataBind();
                        }
                    }
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

        protected void LogoutBtn_Click(object sender, EventArgs e)
        {
            Session["Username"] = null;

            Response.Redirect("~/Login.aspx");
        }

        protected void MyOrders_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Orders.aspx");
        }

        protected void AddProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AddProduct.aspx");

        }

        protected void RemoveProduct_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;

            int ProductID = Convert.ToInt32(btn.CommandArgument);


            dal objMyDal = new dal();

            string PrevPicture = "";

            int Removed = objMyDal.RemoveProduct(ProductID, ref PrevPicture);

            if (PrevPicture != "" && PrevPicture != "WebImages\\Loading.png")
            {
                string path = Server.MapPath(PrevPicture);
                FileInfo file = new FileInfo(path);

                if (file.Exists)//check file exsit or not  
                {
                    file.Delete();
                }

            }

            if (Removed == 1)
            {
                Response.Redirect("~/SellerProfile.aspx");

            }
        }

        protected void UpdProduct_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;

            int ProductID = Convert.ToInt32(btn.CommandArgument);

     
            Response.Redirect("~/UpdateProduct.aspx?Product=" + ProductID.ToString());

           
        }

        protected void ShowMessages_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/SellerChat.aspx");
        }
    }
}