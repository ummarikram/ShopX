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
    public partial class UpdateProduct : System.Web.UI.Page
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

                    dal objMyDal = new dal();

                    string Name = "", Desc = ""; int Price = 0;
                    string Sid = Request.QueryString["Product"].ToString();
                    int ProductID = Int16.Parse(Sid);
                    objMyDal.ShowExistingProductDetails(ProductID, ref Name, ref Desc, ref Price);
                    
                    PName.Text = Name;
                    PDescription.Text = Desc;
                    PPrice.Text = Price.ToString();

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
        private bool IsFormValid()
        {
            if (!rdFood.Checked && !rdFashion.Checked && !rdElectronics.Checked)
            {
                return false;
            }

            if (PName.Text == "" || PDescription.Text == "")
            {
                return false;
            }

            return true;

        }

        protected void UpdProductbtn_Click(object sender, EventArgs e)
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

                int Updated = 0;

                string PrevPicture = "";
                string Sid = Request.QueryString["Product"].ToString();
                int ProductID = Int16.Parse(Sid);

                if (SavePath == "")
                {
                    string DefaultImage = "WebImages\\Loading.png";
                    Updated = objMyDal.UpdateProduct(ProductID,PName.Text, PDescription.Text, Category, Email, PPrice.Text, DefaultImage, ref PrevPicture);
                }
                else
                {
                    Updated = objMyDal.UpdateProduct(ProductID,PName.Text, PDescription.Text, Category, Email, PPrice.Text, SavePath, ref PrevPicture);
                }

                if (PrevPicture != "" && PrevPicture != "WebImages\\Loading.png")
                {
                    string path = Server.MapPath(PrevPicture);
                    FileInfo file = new FileInfo(path);

                    if (file.Exists)//check file exsit or not  
                    {
                        file.Delete();
                    }

                }


                if (Updated == 1)
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


        private void ClearForm()
        {
            PName.Text = string.Empty;
            PDescription.Text = string.Empty;
            PPrice.Text = string.Empty;
        }

    }
}