using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Termination : System.Web.UI.Page
{
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public DBCONNECTION dbcon = new DBCONNECTION();
    static DataSet ds = new DataSet();
    static DataTable dtlogin = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        dtlogin = Session["fetchlogindetails"] as DataTable;
        if (!Page.IsPostBack)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds = dbcon.Exe_proc_hrms_fill_data("DDL", "1", "", "", "", "", "");
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {               
                DataTable dtempstatus = new DataTable();
                dt.DefaultView.RowFilter = "TXT ='EMPSTATUS'";
                dtempstatus = (dt.DefaultView).ToTable();
                dbcon.FillDDLwithdt1termination(ddl_terminationtype, dtempstatus);

            }
        }
    }

    [WebMethod]
    public static IEnumerable bindata(string typ,string from,string todate)
    {
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, "", "",from,todate, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        dt1.Columns.Add("#", typeof(System.String));

        foreach (DataRow row in dt1.Rows)
        {
            //need to set value to NewColumn column
            row["#"] = "<div class='dropdown dropdown-action'><a href='#' class='action-icon dropdown-toggle' data-toggle='dropdown' aria-expanded='false'><i class='material-icons'>more_vert</i></a><div class='dropdown-menu dropdown-menu-right'><a class='dropdown-item'  href='javascript:void(0)' onclick=\"edit_employee('" + row["aadhar"].ToString() + "," + row["Emp.Name"].ToString() + "');\"><i class='fa fa-pencil m-r-5'></i>Edit</a></div></div>";   // or set it to some other value   <a class='dropdown-item' href='#' data-toggle='modal' data-target='#delete_employee'><i class='fa fa-trash-o m-r-5'></i>Delete</a>
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
    public static IEnumerable binalldata(string typ, string aadhar)
    {
        ds = dbconStatic.Exe_proc_emp_search(aadhar, typ);
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        if (dt1.Rows.Count > 0)
        {
            var result1 = ds.GetJSON();
            //  var result = dt1.ToDataSetToJSON();
            var temp = result1.Length;//500000000
            return result1;
        }
        else
        {

            return "1";
        }

    }

    [WebMethod]
    public static IEnumerable employeeterminate(string typ, string aadhar, string status, string lastdate, string reason)
    {

        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, aadhar, dtlogin.Rows[0]["user_loginid"].ToString(), status, reason, lastdate, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
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