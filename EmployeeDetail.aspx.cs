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

public partial class EmployeeDetail : System.Web.UI.Page
{
    static string jsondata = "";
    static OracleConnection oraconstatic;
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public DBCONNECTION dbcon = new DBCONNECTION();
    static DataSet ds = new DataSet();
    static DataTable dtlogin = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {       
        oraconstatic = new OracleConnection(NDS.Connection());
        if (!Page.IsPostBack)
        {
            try
            {
                dtlogin = Session["fetchlogindetails"] as DataTable;
                if (dtlogin.Rows[0]["USERTYPE"].ToString() == "L3")
                {
                    ddl_division.Enabled = true;
                }
                else
                {
                    ddl_division.Enabled = false;
                }
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                ds = dbcon.Exe_proc_hrms_fill_data("DDL", "1", "", "", "", "", "");
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    DataTable dtdiv = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='DIV'";
                    dtdiv = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdtmat(ddl_division, dtdiv);
                    ddl_division.SelectedValue = dtlogin.Rows[0]["DIVISION"].ToString();


                    string qry = "SELECT DISTINCT trim(regexp_substr('" + dtlogin.Rows[0]["SUB_DIV_NM"].ToString() + "','[^,]+', 1, level) )AS a FROM dual CONNECT BY regexp_substr('" + dtlogin.Rows[0]["SUB_DIV_NM"].ToString() + "', '[^,]+', 1, level) IS NOT NULL";
                    dbcon.FillDDLwithonecolumn(ddl_subdiv, qry);

                }
            }
            catch (Exception er)
            {
            }
        }

    }
    [WebMethod]
    public static IEnumerable bindata(string typ, string subdivvalue, string div)
    {
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, "", dtlogin.Rows[0]["USER_LOGINID"].ToString(), div, subdivvalue, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];

        DataTable subdivdt = new DataTable();
        string qry2 = "select sub_div,sub_div_code from HRMS_SUB_DIV where status = '0' and div = '" + div + "'";
        OracleDataAdapter oda = new OracleDataAdapter(qry2, oraconstatic);
        oda.Fill(subdivdt);
        ds.Tables.Add(subdivdt);

        if (dt1.Rows.Count > 0)
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
    public static IEnumerable bindatasubdivwise(string typ, string subdivvalue, string div)
    {
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, "", dtlogin.Rows[0]["USER_LOGINID"].ToString(), div, subdivvalue, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        if (dt1.Rows.Count > 0)
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
    protected void ddl_division_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable subdiv = new DataTable();
        string qry2 = "select sub_div,sub_div_code from HRMS_SUB_DIV where status = '0' and div = '" + ddl_division.SelectedValue + "'";
        OracleDataAdapter oda = new OracleDataAdapter(qry2, oraconstatic);
        oda.Fill(subdiv);
        dbcon.FillDDL(ddl_subdiv, qry2);        
    }
}