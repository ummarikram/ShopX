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
    public partial class Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
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
        protected void SignUpbtn_Click(object sender, EventArgs e)
        {
            if (isFormValid())
            {
                string Type = "NONE";

                if (rdSeller.Checked)
                {
                    Type = "SELLER";
                }
                else if (rdBuyer.Checked)
                {
                    Type = "BUYER";
                }

                dal objMyDal = new dal();

                int Found = objMyDal.SignupCheck(FnameTxt.Text, LnameTxt.Text, EmailTxt.Text, PassTxt.Text, CityTxt.Text, PhoneTxt.Text, Type);

                if (Found == 0)
                {
                    Response.Write("<script> alert('User already Registered!'); </script>");
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }

            ClearForm();
        }

        private void ClearForm()
        {
            FnameTxt.Text = string.Empty;
            LnameTxt.Text = string.Empty;
            EmailTxt.Text = string.Empty;
            CityTxt.Text = string.Empty;
            PassTxt.Text = string.Empty;
            CPassTxt.Text = string.Empty;
            PhoneTxt.Text = string.Empty;
        }

        private bool isFormValid()
        {
            if (FnameTxt.Text == "" || LnameTxt.Text == "" ||
               EmailTxt.Text == "" || PassTxt.Text == "" ||
               CPassTxt.Text == "" || PhoneTxt.Text == "")
            {
                Response.Write("<script> alert('Please fill out all neccessary fields!'); </script>");
                return false;
            }

            if (!rdSeller.Checked && !rdBuyer.Checked)
            {
                Response.Write("<script> alert('Type Not Selected!'); </script>");
                return false;
            }
            
           
            if (PassTxt.Text != CPassTxt.Text)
            {
                // Password mismatch
                CPassTxt.Focus();
                Response.Write("<script> alert('Password Mismatch'); </script>");
                return false;
            }

            return true;
        }
    }
}