using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Seperation : System.Web.UI.Page
{
   static DataSet ds; 
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public DBCONNECTION dbcon = new DBCONNECTION();
    static DataTable dtlogin = new DataTable(); 
    protected void Page_Load(object sender, EventArgs e)
    {
        dtlogin = Session["fetchlogindetails"] as DataTable;
    }
    [WebMethod]
    public static IEnumerable bindata(string typ)
    {
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, "", dtlogin.Rows[0]["user_loginid"].ToString(), "","", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];       
        if (dt1.Rows.Count > 0)
        {
            var result = dt1.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {

            return "1";
        }

    }
    [WebMethod]
    public static IEnumerable bindmoredata(string typ, string emp)
    {
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, "", dtlogin.Rows[0]["user_loginid"].ToString(),emp, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        if (dt1.Rows.Count > 0)
        {
            var result = dt1.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {

            return "1";
        }

    }


    [WebMethod]
    public static IEnumerable updatedetails(string empcode, string updationuser, UpdatedRight[] updatedRight)
    {
        DataTable role = new DataTable();
        foreach (UpdatedRight item in updatedRight)
        {
            ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("103", "", dtlogin.Rows[0]["USER_LOGINID"].ToString(), dtlogin.Rows[0]["DEPT_NM"].ToString(), item.Name, empcode, item.status, item.remarks, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
            role = ds.Tables[0];
        }
        if (role.Rows.Count > 0)
        {
            var result = role.AsEnumerable().Select(c => new
            {
                MSG_CODE = c["MSG_CODE"],
                TXT = c["TXT"]

            }).ToList();
            return result;
        }
        else
        {
            return "";
        }
    }

    public class UpdatedRight
    {
        public string Name { get; set; }
        public string status { get; set; }
        public string remarks { get; set; }
    }
}