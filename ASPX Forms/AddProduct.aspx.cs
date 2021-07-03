using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ShopX.DAL;

namespace ShopX
{
    public partial class AddProduct : System.Web.UI.Page
    {
        string Guid = new Guid().ToString();

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
            }
        }

        private bool IsFormValid()
        {
            if (!rdFood.Checked && !rdFashion.Checked && !rdElectronics.Checked)
            {
                return false;
            }

            if (PName.Text == "" || PDescription.Text == "" || PPrice.Text == "")
            {
                return false;
            }

            return true;

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

        protected void AddProductbtn_Click(object sender, EventArgs e)
        {
            if (IsFormValid())
            {
                string SavePath = CheckImageUpload();

                dal objMyDal = new dal();

                String Category = string.Empty;
                String Email = Session["Username"].ToString();

                if (rdFashion.Checked)
                {
                    Category = "FASHION";
                }
                else if (rdElectronics.Checked)
                {
                    Category = "ELECTRONICS";
                }
                else if (rdFood.Checked)
                {
                    Category = "FOOD";
                }
                
                int Added = 0;

                if (SavePath == "")
                {
                    string DefaultImage = "WebImages\\Loading.png";
                    Added = objMyDal.AddProduct(PName.Text, PDescription.Text, Category, Email, PPrice.Text, DefaultImage);
                }
                else
                {
                    Added = objMyDal.AddProduct(PName.Text, PDescription.Text, Category, Email, PPrice.Text, SavePath);
                }
               

                if (Added == 1)
                {
                    Response.Redirect("~/SellerProfile.aspx");
                }
                else
                {
                    Response.Write("<script> alert('Product already exists!'); </script>");
                }
            }
            else
            {
                Response.Write("<script> alert('Please fill out all neccessary fields!'); </script>");
            }

            ClearForm();
            
        }

        private void ClearForm()
        {
            PName.Text = string.Empty;
            PDescription.Text = string.Empty;
            PPrice.Text = string.Empty;
        }

        private string CheckImageUpload()
        {
            string SavePath = "";

            // if a file was uploaded
            if (ImageUpload.HasFile)
            {
                string extension = System.IO.Path.GetExtension(ImageUpload.FileName);

                if (extension == ".jpg" || extension == ".png" || extension == ".jpeg")
                {
                    // Save Path
                    string path = Server.MapPath("ProductImages\\");

                    string imageName = Guid + ImageUpload.FileName;
                    // Save Image
                    ImageUpload.SaveAs(path + imageName);

                    SavePath = "ProductImages\\" + imageName;
                }
                else
                {
                    Response.Write("<script> alert('Please upload a valid image!'); </script>");
                }
            }

            return SavePath;
        }

    }
}