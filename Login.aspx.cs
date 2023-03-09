using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    static DataSet ds = new DataSet();
    static DBCONNECTION dbconstatic = new DBCONNECTION();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static IEnumerable fetchlogindetails(string empid, string pass)
    {
      //  HttpContext.Current.Response.Redirect("MRF.aspx");
        DataTable dt = new DataTable();
        ds = dbconstatic.Exe_proc_FETCH_login_details(empid, pass);
        dt = ds.Tables[0];

        if (dt.Rows.Count > 0)
        {
            var result = dt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            HttpContext.Current.Session["fetchlogindetails"] = dt;
            HttpContext.Current.Session["fetchlogindetailsresult"] = result;
            return result;
        }
        else
        {

            DataRow dr = dt.NewRow();
            dr["USER_LOGINID"] = "1";
            dt.Rows.Add(dr);
            var result = dt.ToDataSetToJSON();
            return result;
        }       
    }
}