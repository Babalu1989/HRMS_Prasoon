using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Message : System.Web.UI.Page
{
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public DBCONNECTION dbcon = new DBCONNECTION();
    static DataSet ds = new DataSet();
    static DataTable dtlogin = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                dtlogin = Session["fetchlogindetails"] as DataTable;
            }
        }
        catch (Exception er)
        {
            Response.Redirect("login");
        }
    }

    [WebMethod]
    public static IEnumerable chatmessage(string empcode, string type)
    {
        DataSet resultds = new DataSet();
        resultds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(type, empcode, dtlogin.Rows[0]["user_loginid"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        if (resultds.Tables[0].Rows.Count > 0)
        {
            var result = resultds.GetJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else {
            return "No Message Sent";
        }

    }
    
    [WebMethod]
    public static IEnumerable smssend(string empcode, string type, string mobile,string message)
    {
        DataSet resultds = new DataSet();
        resultds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(type,empcode, dtlogin.Rows[0]["user_loginid"].ToString(), mobile, message,"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        if (resultds.Tables[0].Rows.Count > 0)
        {
            var result = resultds.GetJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else {
            return "No Message Sent";
        }

    }
}