using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace ShopX.DAL
{
    public class dal
    {
        private static readonly string connString = ""; // Add your connection string here
 
        public int SearchUser(String Email, String pass)
        {
            int Found = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("Login_Check", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@email", SqlDbType.VarChar, 30);
                cmd.Parameters.Add("@password", SqlDbType.VarChar, 10);

                cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;

                // set parameter values
                cmd.Parameters["@email"].Value = Email;

                cmd.Parameters["@password"].Value = pass;


                cmd.ExecuteNonQuery();

                // read output value 
                Found = Convert.ToInt32(cmd.Parameters["@flag"].Value); //convert to output parameter to interger format

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return Found;

        }

        public int SignupCheck(String firstname, String lastname,
            String email, String Password, String City,
            String Phone, String Type)
        {
            int Found = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("Signup_Check", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@firstaname", SqlDbType.VarChar, 30);
                cmd.Parameters.Add("@lastaname", SqlDbType.VarChar, 30);
                cmd.Parameters.Add("@email", SqlDbType.VarChar, 30);
                cmd.Parameters.Add("@password", SqlDbType.VarChar, 10);
                cmd.Parameters.Add("@City", SqlDbType.VarChar, 30);
                cmd.Parameters.Add("@Phone", SqlDbType.VarChar, 15);
                cmd.Parameters.Add("@type", SqlDbType.VarChar, 10);

                cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;

                // set parameter values
                cmd.Parameters["@firstaname"].Value = firstname;
                cmd.Parameters["@lastaname"].Value = lastname;
                cmd.Parameters["@email"].Value = email;
                cmd.Parameters["@password"].Value = Password;
                cmd.Parameters["@City"].Value = City;
                cmd.Parameters["@Phone"].Value = Phone;
                cmd.Parameters["@type"].Value = Type;


                cmd.ExecuteNonQuery();

                // read output value 
                Found = Convert.ToInt32(cmd.Parameters["@flag"].Value); //convert to output parameter to interger format

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return Found;
        }

        public void ShowExistingProductDetails(int ProductID, ref string PName, ref string PDesc, ref int PPrice)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("ProductDetails", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@PID", SqlDbType.VarChar, 30);


                cmd.Parameters.Add("@PName", SqlDbType.VarChar, 20).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@PDesc", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@PPrice", SqlDbType.Int).Direction = ParameterDirection.Output;

                // set parameter values
                cmd.Parameters["@PID"].Value = ProductID;

                cmd.ExecuteNonQuery();

                // read output value 
                PName = Convert.ToString(cmd.Parameters["@PName"].Value); //convert to output parameter to interger format
                PDesc = Convert.ToString(cmd.Parameters["@PDesc"].Value); //convert to output parameter to interger format
                PPrice = Convert.ToInt32(cmd.Parameters["@PPrice"].Value); //convert to output parameter to interger format
                
                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
        }

        public void GetUserInfo(ref String firstname, ref String lastname, String Email,
            ref String Type, ref String Phone, ref String City, ref String TotalOrders)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("Select FirstName,LastName,City,Phone,Type,TotalOrders from [USERS] where Email=@email", con); //name of your procedure

                cmd.Parameters.AddWithValue("@email", Email);

                SqlDataReader da = cmd.ExecuteReader();

                while (da.Read())
                {
                    firstname = da.GetValue(0).ToString();
                    lastname = da.GetValue(1).ToString();
                    City = da.GetValue(2).ToString();
                    Phone = da.GetValue(3).ToString();
                    Type = da.GetValue(4).ToString();
                    TotalOrders = da.GetValue(5).ToString();

                }

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

        }


        public void GiveProductRating(int ProductID, String Email, int Ranking)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                int BID = GetBuyerID(Email);

                if (BID != 0)
                {
                    cmd = new SqlCommand("GiveRanking", con); //name of your procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@PID", SqlDbType.Int);

                    cmd.Parameters.Add("@BID", SqlDbType.Int);

                    cmd.Parameters.Add("@RANK", SqlDbType.Int);

                    // set parameter values
                    cmd.Parameters["@PID"].Value = ProductID;
                    cmd.Parameters["@BID"].Value = BID;
                    cmd.Parameters["@RANK"].Value = Ranking;

                    cmd.ExecuteNonQuery();

                    con.Close();
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

        }

        public int GetProductCount(String Email)
        {
            int Count = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("GetProductCount", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@email", SqlDbType.VarChar, 30);


                cmd.Parameters.Add("@Count", SqlDbType.Int).Direction = ParameterDirection.Output;

                // set parameter values
                cmd.Parameters["@email"].Value = Email;

                cmd.ExecuteNonQuery();

                // read output value 
                Count = Convert.ToInt32(cmd.Parameters["@Count"].Value); //convert to output parameter to interger format

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return Count;
        }

        public DataTable ShowSearchQueuryProducts(String Query)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {

                cmd = new SqlCommand("ShowProducts", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@PName", SqlDbType.VarChar, 30);


                // set parameter values
                cmd.Parameters["@PName"].Value = Query;

                cmd.ExecuteNonQuery();
                dt = new DataTable();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }

        public DataTable DisplaySellerProducts(String Email)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                int SID = GetSellerID(Email);
                cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from Products where SellerID=" + SID.ToString();

                cmd.ExecuteNonQuery();
                dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }

        public DataTable ShowExistingProductDetails(int ProductID)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from Products where ProductID=" + ProductID.ToString();

                cmd.ExecuteNonQuery();
                dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;
        }

        public DataTable DisplayElectronicsProducts()
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from Products where CatogeryID=2";

                cmd.ExecuteNonQuery();
                dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }

        public DataTable GetProductRating(int ProductID)
        {

            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select Ranking from Products where ProductID=" + ProductID.ToString();

                cmd.ExecuteNonQuery();
                dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;
        }

        public DataTable GetUserProductRating(int ProductID, String Email)
        {

            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                int BID = GetBuyerID(Email);

                if (BID != 0)
                {
                    cmd = con.CreateCommand();
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select Ranking from RANKING where ProductID=" + ProductID.ToString() + " and BuyerID=" + BID.ToString();

                    cmd.ExecuteNonQuery();
                    dt = new DataTable();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);

                    if(dt.Rows.Count == 0)
                    {
                        cmd.CommandText = "select Ranking from Products where ProductID=" + ProductID.ToString();

                        cmd.ExecuteNonQuery();
                        dt = new DataTable();
                        da = new SqlDataAdapter(cmd);
                        da.Fill(dt);

                    }

                    con.Close();
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;
        }

        public DataTable DisplayFashionProducts()
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from Products where CatogeryID=1";

                cmd.ExecuteNonQuery();
                dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }

        public DataTable DisplayFoodProducts()
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from Products where CatogeryID=3";

                cmd.ExecuteNonQuery();
                dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }

        public DataTable CartProducts(String Email, ref int Count)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                int BID = GetBuyerID(Email);

                if (BID != 0)
                {
                    cmd = con.CreateCommand();
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "select * from MyCart where BuyerID=" + BID.ToString();

                    cmd.ExecuteNonQuery();
                    dt = new DataTable();
          
                    SqlDataAdapter da = new SqlDataAdapter(cmd);

                    da.Fill(dt);

                    Count = dt.Rows.Count;

                    con.Close();
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }


        public DataTable ShowConversation(String Email, int BID=0, int SID=0)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                if (SID == 0)
                {
                    SID = GetSellerID(Email);
                }
                else if (BID == 0)
                {
                    BID = GetBuyerID(Email);
                }

                if (BID != 0 && SID != 0)
                {
                    cmd = new SqlCommand("ShowConversation", con); //name of your procedure
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.Add("@SID", SqlDbType.Int);
                    cmd.Parameters.Add("@BID", SqlDbType.Int);

                    // set parameter values
                    cmd.Parameters["@SID"].Value = SID;
                    cmd.Parameters["@BID"].Value = BID;

                    cmd.ExecuteNonQuery();
                    dt = new DataTable();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);

                    da.Fill(dt);

                    con.Close();
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }


        public DataTable ShowConversationBuyerSide(String Email, int ProductID)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                int BID = GetBuyerID(Email);
                int SID = GetSellerID(ProductID);

                if (BID != 0 && SID != 0)
                {
                    cmd = new SqlCommand("ShowConversation", con); //name of your procedure
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.Add("@SID", SqlDbType.Int);
                    cmd.Parameters.Add("@BID", SqlDbType.Int);

                    // set parameter values
                    cmd.Parameters["@SID"].Value = SID;
                    cmd.Parameters["@BID"].Value = BID;

                    cmd.ExecuteNonQuery();
                    dt = new DataTable();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);

                    da.Fill(dt);

                    con.Close();
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }

        public DataTable ShowOrders(String Email, char UserType)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd = null; DataTable dt = null;

            try
            {
                int SID = 0, BID = 0;

                if (UserType == 'S')
                {
                    SID = GetSellerID(Email);
                }
                else if (UserType == 'B')
                {
                    BID = GetBuyerID(Email);
                }

                if (SID != 0)
                {
                    cmd = new SqlCommand("GetOrdersForSeller", con); //name of your procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@SID", SqlDbType.Int);

                    cmd.Parameters["@SID"].Value = SID;
                }
                else if (BID != 0)
                {
                    cmd = new SqlCommand("GetOrdersForBuyer", con); //name of your procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@BID", SqlDbType.Int);

                    cmd.Parameters["@BID"].Value = BID;
                }

                cmd.ExecuteNonQuery();

                dt = new DataTable();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);

                con.Close();
            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }
        public void UpdateOrderStatus(int OID, string Status)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("UpdateOrderStatus", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@OID", SqlDbType.Int);


                cmd.Parameters.Add("@Status", SqlDbType.VarChar, 15);

                // set parameter values
                cmd.Parameters["@OID"].Value = OID;

                cmd.Parameters["@Status"].Value = Status;

                cmd.ExecuteNonQuery();

                        
                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

        }

        public DataTable DisplayBuyerNamesChatBox(String Email)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                int SID = GetSellerID(Email);

                if (SID != 0)
                {
                    cmd = new SqlCommand("ShowAllBuyerNames", con); //name of your procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@SID", SqlDbType.Int);

                    cmd.Parameters["@SID"].Value = SID;

                    cmd.ExecuteNonQuery();

                    dt = new DataTable();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);

                    da.Fill(dt);

                    con.Close();
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }


        public DataTable DisplaySellerNamesChatBox(String Email)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {
                int BID = GetBuyerID(Email);

                if (BID != 0)
                {
                    cmd = new SqlCommand("ShowAllSellerNames", con); //name of your procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@BID", SqlDbType.Int);

                    cmd.Parameters["@BID"].Value = BID;

                    cmd.ExecuteNonQuery();

                    dt = new DataTable();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);

                    da.Fill(dt);

                    con.Close();
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }


        public DataTable GetSelectedBuyerNameChatBox(int BuyerID)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {

                cmd = new SqlCommand("ShowBuyerName", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@BID", SqlDbType.Int);

                cmd.Parameters["@BID"].Value = BuyerID;

                cmd.ExecuteNonQuery();

                dt = new DataTable();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }


        public DataTable GetSelectedSellerNameChatBox(int SellerID)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd; DataTable dt = null;

            try
            {

                cmd = new SqlCommand("ShowSellerName", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@SID", SqlDbType.Int);

                cmd.Parameters["@SID"].Value = SellerID;

                cmd.ExecuteNonQuery();

                dt = new DataTable();

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return dt;

        }

        public void PlaceOrder(int BID, int PID, string PaymentType)
        {
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("PlaceOrder", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@BID", SqlDbType.Int);
                cmd.Parameters.Add("@PID", SqlDbType.Int);
                cmd.Parameters.Add("@PType", SqlDbType.VarChar, 5);

                // set parameter values
                cmd.Parameters["@BID"].Value = BID;
                cmd.Parameters["@PID"].Value = PID;
                cmd.Parameters["@PType"].Value = PaymentType;

                cmd.ExecuteNonQuery();

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }
        }

        public int GetSellerID(String Email)
        {
            int SID = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("Get_SellerID", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@email", SqlDbType.VarChar, 30);


                cmd.Parameters.Add("@SID", SqlDbType.Int).Direction = ParameterDirection.Output;

                // set parameter values
                cmd.Parameters["@email"].Value = Email;

                cmd.ExecuteNonQuery();

                // read output value 
                SID = Convert.ToInt32(cmd.Parameters["@SID"].Value); //convert to output parameter to interger format

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return SID;
        }

        public int GetSellerID(int ProductID)
        {
            int SID = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = con.CreateCommand();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select SellerID from Products where ProductID=" + ProductID.ToString();

                SqlDataReader dr = cmd.ExecuteReader();

                while(dr.Read())
                {
                    SID = Int16.Parse(dr.GetValue(0).ToString());
                }
               
                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return SID;
        }

        public int GetBuyerID(String Email)
        {
            int BID = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {

                cmd = new SqlCommand("Get_BuyerID", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@email", SqlDbType.VarChar, 30);


                cmd.Parameters.Add("@BID", SqlDbType.Int).Direction = ParameterDirection.Output;

                // set parameter values
                cmd.Parameters["@email"].Value = Email;

                cmd.ExecuteNonQuery();

                // read output value 
                BID = Convert.ToInt32(cmd.Parameters["@BID"].Value); //convert to output parameter to interger format

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return BID;
        }

        public int AddProduct(String PName, String PDescription, String Category, String Email, String Price, string Picture)
        {
            int SellerID = GetSellerID(Email);
            
            int Added = 0;

            if (SellerID != 0)
            {
                SqlConnection con = new SqlConnection(connString);
                con.Open();
                SqlCommand cmd;
                try
                {

                    cmd = new SqlCommand("Add_Product", con); //name of your procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@PName", SqlDbType.VarChar, 30);

                    cmd.Parameters.Add("@PDesc", SqlDbType.VarChar, 100);

                    cmd.Parameters.Add("@PPrice", SqlDbType.Int);

                    cmd.Parameters.Add("@PCat", SqlDbType.VarChar, 30);

                    cmd.Parameters.Add("@SID", SqlDbType.Int);

                    cmd.Parameters.Add("@PPicture", SqlDbType.VarChar, 100);

                    cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;

                    // set parameter values
                    cmd.Parameters["@PName"].Value = PName;
                    cmd.Parameters["@PDesc"].Value = PDescription;
                    cmd.Parameters["@PPrice"].Value = Price;
                    cmd.Parameters["@PCat"].Value = Category;
                    cmd.Parameters["@SID"].Value = SellerID;
                    cmd.Parameters["@PPicture"].Value = Picture;

                    cmd.ExecuteNonQuery();

                    // read output value 
                    Added = Convert.ToInt32(cmd.Parameters["@flag"].Value); //convert to output parameter to interger format

                    con.Close();

                }
                catch (SqlException ex)
                {
                    Console.WriteLine("SQL Error" + ex.Message.ToString());
                }
                finally
                {
                    con.Close();
                }
            }

            return Added;
        }

        public int RemoveProduct(int ProductID, ref string PrevPicture)
        {
            int Removed = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("Remove_Product", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@id", SqlDbType.Int);

                cmd.Parameters.Add("@PrevPicture", SqlDbType.VarChar, 100).Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;

                // set parameter values
                cmd.Parameters["@id"].Value = ProductID;
        
                cmd.ExecuteNonQuery();

                // read output value 
                Removed = Convert.ToInt32(cmd.Parameters["@flag"].Value); //convert to output parameter to interger format
                PrevPicture = Convert.ToString(cmd.Parameters["@PrevPicture"].Value);

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return Removed;
        }

        public int UpdateProduct(int ProductID, String PName, String PDescription, String Category, String Email, String Price, string Picture, ref string PrevPicture)
        {
            int Updated = 0;
 
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                cmd = new SqlCommand("Update_Product", con); //name of your procedure
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@id", SqlDbType.Int);

                cmd.Parameters.Add("@PName", SqlDbType.VarChar, 30);

                cmd.Parameters.Add("@PDesc", SqlDbType.VarChar, 100);

                cmd.Parameters.Add("@PPrice", SqlDbType.Int);

                cmd.Parameters.Add("@PCat", SqlDbType.VarChar, 30);

                cmd.Parameters.Add("@PPicture", SqlDbType.VarChar, 100);

                cmd.Parameters.Add("@PrevPicture", SqlDbType.VarChar,100).Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;

                // set parameter values
                cmd.Parameters["@id"].Value = ProductID;
                cmd.Parameters["@PName"].Value = PName;
                cmd.Parameters["@PDesc"].Value = PDescription;
                cmd.Parameters["@PPrice"].Value = Price;
                cmd.Parameters["@PCat"].Value = Category;
                cmd.Parameters["@PPicture"].Value = Picture;

                cmd.ExecuteNonQuery();

                // read output value 
                Updated = Convert.ToInt32(cmd.Parameters["@flag"].Value); //convert to output parameter to interger format
                PrevPicture = Convert.ToString(cmd.Parameters["@PrevPicture"].Value);

                con.Close();

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return Updated;
        }

        public int RemoveFromCart(int ProductID, String Email)
        {
            int Removed = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                int BID = GetBuyerID(Email);

                if (BID != 0)
                {
                    cmd = new SqlCommand("RemoveFromCart", con); //name of your procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@PID", SqlDbType.Int);

                    cmd.Parameters.Add("@BID", SqlDbType.Int);


                    cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;

                    // set parameter values
                    cmd.Parameters["@PID"].Value = ProductID;
                    cmd.Parameters["@BID"].Value = BID;

                    cmd.ExecuteNonQuery();

                    // read output value 
                    Removed = Convert.ToInt32(cmd.Parameters["@flag"].Value); //convert to output parameter to interger format

                    con.Close();
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return Removed;
        }

        public int AddToCart(int ProductID, String Email)
        {
            int Added = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                int BID = GetBuyerID(Email);

                if (BID != 0)
                {
                    cmd = new SqlCommand("Add_TO_Cart", con); //name of your procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@PID", SqlDbType.Int);

                    cmd.Parameters.Add("@BID", SqlDbType.Int);


                    cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;

                    // set parameter values
                    cmd.Parameters["@PID"].Value = ProductID;
                    cmd.Parameters["@BID"].Value = BID;

                    cmd.ExecuteNonQuery();

                    // read output value 
                    Added = Convert.ToInt32(cmd.Parameters["@flag"].Value); //convert to output parameter to interger format

                    con.Close();
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return Added;
        }

        public int SendMessage(String Message, string SentBy, String Email = "", int ProductID = 0, int BuyerID=0, int SellerID=0)
        {
            int Delivered = 0;
            SqlConnection con = new SqlConnection(connString);
            con.Open();
            SqlCommand cmd;
            try
            {
                int BID = 0;
                int SID = 0;

                if (SentBy == "Buyer")
                {
                    BID = GetBuyerID(Email);

                    if (SellerID == 0)
                    {
                        SID = GetSellerID(ProductID);
                    }
                    else
                    {
                        SID = SellerID;
                    }
                }
                else if (SentBy == "Seller")
                {
                    BID = BuyerID;
                    SID = GetSellerID(Email);

                }
                if (BID != 0 && SID !=0)
                {
                    cmd = new SqlCommand("SendMessage", con); //name of your procedure
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@Message", SqlDbType.VarChar, 100);

                    cmd.Parameters.Add("@BID", SqlDbType.Int);

                    cmd.Parameters.Add("@SID", SqlDbType.Int);

                    cmd.Parameters.Add("@SentBy", SqlDbType.VarChar, 20);

                    cmd.Parameters.Add("@flag", SqlDbType.Int).Direction = ParameterDirection.Output;

                    // set parameter values
                    cmd.Parameters["@Message"].Value = Message;
                    cmd.Parameters["@BID"].Value = BID;
                    cmd.Parameters["@SID"].Value = SID;
                    cmd.Parameters["@SentBy"].Value = SentBy;

                    cmd.ExecuteNonQuery();

                    // read output value 
                    Delivered = Convert.ToInt32(cmd.Parameters["@flag"].Value); //convert to output parameter to interger format

                    con.Close();
                }

            }
            catch (SqlException ex)
            {
                Console.WriteLine("SQL Error" + ex.Message.ToString());
            }
            finally
            {
                con.Close();
            }

            return Delivered;
        }
    }
}
