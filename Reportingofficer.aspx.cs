using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OracleClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Common_report : System.Web.UI.Page
{
    static DataTable dtlogin = new DataTable();
    OracleConnection oracon;
    static OracleConnection oraconstatic;
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public  DBCONNECTION dbcon = new DBCONNECTION();
    static DataSet ds = new DataSet();    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                dtlogin = Session["fetchlogindetails"] as DataTable;
                string qry1 = "select division_name,division_code from TBL_DIVISION_MASTER where division_code not in ('KCC','EHV') order by division_name ";
                dbcon.FillDDL(ddl_division, qry1);
            }
            catch (Exception er)
            { }
        }
    }

    [WebMethod]
    public static IEnumerable bindata(string typ,string div,string subdiv)
    {
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, "", dtlogin.Rows[0]["USER_LOGINID"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        dt1.Columns.Add("#", typeof(System.String));

        foreach (DataRow row in dt1.Rows)
        {
            //need to set value to NewColumn column
            row["#"] = "<div class='dropdown dropdown-action'><a href='#' class='action-icon dropdown-toggle' data-toggle='dropdown' aria-expanded='false'><i class='material-icons'>more_vert</i></a><div class='dropdown-menu dropdown-menu-right'><a class='dropdown-item'  href='javascript:void(0)' onclick=\"edit_employee('" + row["ID"].ToString() + "," + row["Mobile"].ToString() + "," + row["E-Mail"].ToString() + "," + row["Emp Name"].ToString() + "," + row["HRMS_DIVISION"].ToString() + "," + row["HRMS_SUB_DIV"].ToString() + "');\"><i class='fa fa-pencil m-r-5'></i>Edit</a></div></div>";   // or set it to some other value   <a class='dropdown-item' href='#' data-toggle='modal' data-target='#delete_employee'><i class='fa fa-trash-o m-r-5'></i>Delete</a>
        }
        if (ds.Tables[0].Rows.Count > 0)
        {
            var result = ds.GetJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {

            return "1";
        }

    }


    [WebMethod]
    public static IEnumerable l1_update(string typ, string empid, string mobile, string ddl_division, string subdivision, string email)
    {       
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, "", dtlogin.Rows[0]["user_loginid"].ToString(), empid, mobile, ddl_division, subdivision, email, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
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
    public class subdivision
    {
    }

}