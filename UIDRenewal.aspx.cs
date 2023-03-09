using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UIDRenewal : System.Web.UI.Page
{
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public DBCONNECTION dbcon = new DBCONNECTION();
    static DataSet ds = new DataSet();
    static DataTable dtlogin = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            dtlogin = Session["fetchlogindetails"] as DataTable;
            if (!Page.IsPostBack)
            {
                Session["EMP_CODE"] = dtlogin.Rows[0]["USER_LOGINID"].ToString();
                Session["DIV_code"] = dtlogin.Rows[0]["DIVISION"].ToString();
                Session["EMP_TYPE"] = dtlogin.Rows[0]["MRFUSERTYP"].ToString();

            }

        }
        catch (Exception er) {
            Response.Redirect("Login");
        }
    }
    [WebMethod]
    public static IEnumerable bindata(string typ)
    {
        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, "", dtlogin.Rows[0]["user_loginid"].ToString());
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        dt1.Columns.Add("#", typeof(System.String));
        if (HttpContext.Current.Session["EMP_TYPE"].ToString() == "Security")
        {

            foreach (DataRow row in dt1.Rows)
            {
                //need to set value to NewColumn column
                row["#"] = "<div class='dropdown dropdown-action'><a href='#' class='action-icon dropdown-toggle' data-toggle='dropdown' aria-expanded='false'><i class='material-icons'>more_vert</i></a><div class='dropdown-menu dropdown-menu-right'><a class='dropdown-item'  href='javascript:void(0)' onclick=\"edit_employee('" + row["Aadhaar No"].ToString() + "," + row["Employee Name"].ToString() + "," + row["UID"].ToString() + "," + row["ID Card Validity"].ToString() + "');\"><i class='fa fa-pencil m-r-5'></i>Edit</a></div></div>";
            }
        }
        else
        {
            foreach (DataRow row in dt1.Rows)
            {
                row["#"] = "<div class='dropdown dropdown-action'><a href='#' class='action-icon dropdown-toggle' data-toggle='dropdown' aria-expanded='false'><i class='material-icons'>more_vert</i></a></div>";
            }
        }
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
    public static IEnumerable employeeidvalidity(string typ, string aadhar, string newvalidity, string UID)
    {

        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, aadhar, dtlogin.Rows[0]["user_loginid"].ToString(),UID, newvalidity);
        dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            var result = dt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {
            return "1";
        }

    }
}