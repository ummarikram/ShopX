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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SearchBar.Attributes.Add("autocomplete", "off");

            if (Session["Username"] != null)
            {
                Response.Redirect("~/Profile.aspx");
            }
            else
            {
                Profiler.Visible = false;
                Cart.Visible = false;
            }

            if (!IsPostBack)
            {
                if (Request.Cookies["UNAME"] != null && Request.Cookies["UPWD"] != null)
                {
                    EmailTxt.Text = Request.Cookies["UNAME"].Value;
                    PasswordTxt.Text = Request.Cookies["UPWD"].Value;
                    RememberCheck.Checked = true;
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
        protected void Loginbtn_Click(object sender, EventArgs e)
        {
            if (isFormValid())
            {
                dal objMyDal = new dal();

                int Found = objMyDal.SearchUser(EmailTxt.Text, PasswordTxt.Text);

                if (Found == 1)
                {
                    if (RememberCheck.Checked)
                    {
                        Response.Cookies["UNAME"].Value = EmailTxt.Text;
                        Response.Cookies["UPWD"].Value = PasswordTxt.Text;

                        Response.Cookies["UNAME"].Expires = DateTime.Now.AddDays(10);
                        Response.Cookies["UPWD"].Expires = DateTime.Now.AddDays(10);
                    }
                    else
                    {
                        Response.Cookies["UNAME"].Expires = DateTime.Now.AddDays(-1);
                        Response.Cookies["UPWD"].Expires = DateTime.Now.AddDays(-1);
                    }

                    Session["Username"] = EmailTxt.Text;
              
                    Response.Redirect("~/Profile.aspx");
                }
                else
                {
                    Response.Write("<script> alert('Invalid Email or Password!'); </script>");
                }
            }
           
            else
            {
                Response.Write("<script> alert('Please fill out all fields!'); </script>");
            }
         
           

            ClearForm();

        }


        private void ClearForm()
        {
            EmailTxt.Text = string.Empty;
            PasswordTxt.Text = string.Empty;
        }


        private bool isFormValid()
        {
            if (EmailTxt.Text == "" || PasswordTxt.Text == "")
            {
                return false;
            }

            return true;
        }

        protected void Signupbtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Signup.aspx");
        }
    }
}