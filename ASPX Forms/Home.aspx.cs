using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using ShopX.DAL;
using System.Web.UI.HtmlControls;

namespace ShopX
{
    public partial class Home : System.Web.UI.Page
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

                dal objMyDal = new dal();

                DataTable dt = objMyDal.DisplayFashionProducts();

                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        FashionProducts.DataSource = dt;
                        FashionProducts.DataBind();
                    }
                }

                dt = objMyDal.DisplayElectronicsProducts();

                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        ElectronicsProducts.DataSource = dt;
                        ElectronicsProducts.DataBind();
                    }
                }

                dt = objMyDal.DisplayFoodProducts();

                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        FoodProducts.DataSource = dt;
                        FoodProducts.DataBind();
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
    }
}