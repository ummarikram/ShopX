using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using ShopX.DAL;

namespace ShopX
{
    public partial class MyCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SearchBar.Attributes.Add("autocomplete", "off");

                if (Session["Username"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
                else if (Session["UserType"].ToString() == "SELLER")
                {
                    Response.Redirect("~/Home.aspx");
                }
                else
                {
                    Login.Visible = false;
         
                    // Display Products
                    dal objMyDal = new dal();

                    int Count = 0;

                    DataTable dt = objMyDal.CartProducts(Session["Username"].ToString(), ref Count);

                    CartProductCount.Text = Count.ToString();


                    int Total = 0;

                    for (int i = 0; i < Count; i++)
                    {
                        Total += Int16.Parse(dt.Rows[i]["ProductPrice"].ToString());
                    }

                    TotalPrice.Text = "$" + Total.ToString();


                    if (dt != null)
                    {
                        if (dt.Rows.Count > 0)
                        {
                            ProductsInCart.DataSource = dt;
                            ProductsInCart.DataBind();
                        }
                    }

                    String FName = string.Empty, LName = string.Empty, city = string.Empty, phone = string.Empty, type = string.Empty, totalorders = string.Empty;

                    objMyDal.GetUserInfo(ref FName, ref LName, Session["Username"].ToString(), ref type, ref phone, ref city, ref totalorders);

                    FullName.Text = FName + " " + LName;

                    Email.Text = Session["Username"].ToString();

                    City.Text = city;
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
        protected void RemoveProduct_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;

            int ProductID = Convert.ToInt32(btn.CommandArgument);

            dal objMyDal = new dal();

            int Removed = objMyDal.RemoveFromCart(ProductID, Session["Username"].ToString());

            if (Removed == 1)
            {
                Response.Redirect("~/MyCart.aspx");
            }
          
        }

        protected bool IsFormValid()
        {
            if (rdCARD.Checked)
            {
                if (FullNameCard.Text == "" || CardNumber.Text == ""
                    || CardExpiry.Text == "" || CardCVV.Text == "")
                {
                    return false;
                }
            }

            else if (rdCOD.Checked)
            {
                if (FullName.Text == "" || Email.Text == ""
                   || Address.Text == "" || City.Text == "")
                {
                    return false;
                }
            }

            return true;
        }

        protected void Checkout_Click(object sender, EventArgs e)
        {
            if (IsFormValid())
            {
                // Display Products
                dal objMyDal = new dal();

                int Count = 0;

                DataTable dt = objMyDal.CartProducts(Session["Username"].ToString(), ref Count);

                int PID = 0, BID = 0;

                string PaymentType = "";

                if (rdCOD.Checked)
                {
                    PaymentType = "COD";
                }
                else if (rdCARD.Checked)
                {
                    PaymentType = "CARD";
                }

                for (int i = 0; i < Count; i++)
                {
                    BID = Int16.Parse(dt.Rows[i]["BuyerID"].ToString());
                    PID = Int16.Parse(dt.Rows[i]["ProductID"].ToString());

                    objMyDal.PlaceOrder(BID, PID, PaymentType);
                }

                Response.Write("<script> alert('Order Successfully Placed!'); </script>");

            }

            else
            {
                Response.Write("<script> alert('Please Fill out all Necessary Details!'); </script>");
            }
        }

        protected void SelectedPaymentType(object sender, EventArgs e)
        {
            if (rdCOD.Checked)
            {
                Response.Redirect("~/MyCart.aspx");
            }
            else if (rdCARD.Checked)
            {
                COD.Visible = false;
                CARD.Visible = true;
            }
        }
    }
}