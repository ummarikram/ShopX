using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ShopX.DAL;

namespace ShopX
{
    public partial class Orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                SearchBar.Attributes.Add("autocomplete", "off");

                dal objMyDal = new dal();

                if (Session["Username"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
                else if (Session["UserType"].ToString() == "SELLER")
                {
                    Cart.Visible = false;
                    Login.Visible = false;
             
                    DataTable dt = objMyDal.ShowOrders(Session["Username"].ToString(), 'S');


                    if (dt != null)
                    {
                        if (dt.Rows.Count > 0)
                        {
                            UserOrders.DataSource = dt;

                            UserOrders.DataBind();
                        }
                    }

                    if (dt.Rows.Count == 0)
                    {
                        OrderedProductsContainer.Visible = false;
                    }
                }
                else
                {
                    Login.Visible = false;

                    DataTable dt = objMyDal.ShowOrders(Session["Username"].ToString(), 'B');

                    if (dt != null)
                    {
                        if (dt.Rows.Count > 0)
                        {
                            UserOrders.DataSource = dt;

                            UserOrders.DataBind();
                        }
                    }

                    if (dt.Rows.Count == 0)
                    {
                        OrderedProductsContainer.Visible = false;
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

        protected void UserOrders_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (Session["UserType"].ToString() == "SELLER")
                {
                    Label StatusLabel = (Label)e.Item.FindControl("DisplayStatusForBuyer");
                    StatusLabel.Visible = false;

                    DataRowView row = (DataRowView)e.Item.DataItem;

                    DropDownList StatusLabelSelected = (DropDownList)e.Item.FindControl("DisplayStatusForSeller");

                    int Value = 0;

                    if (row["OrderStatus"].ToString() == "Processing")
                    {
                        Value = 1;
                    }
                    else if (row["OrderStatus"].ToString() == "Shipped")
                    {
                        Value = 2;
                    }
                    else if (row["OrderStatus"].ToString() == "Delivered")
                    {
                        Value = 3;
                    }

                    StatusLabelSelected.SelectedValue = Value.ToString();
                }
                else
                {
                    DropDownList StatusLabel = (DropDownList)e.Item.FindControl("DisplayStatusForSeller");
                    StatusLabel.Visible = false;
                }

            }
        }

        protected void DisplayStatusForSeller_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList StatusLabel = sender as DropDownList;

            int OID = Int32.Parse(StatusLabel.DataMember);

            string Status = StatusLabel.SelectedItem.Text;

            dal objMyDal = new dal();

            objMyDal.UpdateOrderStatus(OID, Status);
        }
    }
}