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

public partial class LIbulkupdate : System.Web.UI.Page
{
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    static OracleConnection oraconstatic;
    public DBCONNECTION dbcon = new DBCONNECTION();
    static DataTable dtlogin = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        dtlogin = Session["fetchlogindetails"] as DataTable;
        oraconstatic = new OracleConnection(NDS.Connection());
        if (!Page.IsPostBack)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds = dbcon.Exe_proc_hrms_fill_data("DDL", "1", "", "", "", "", "");
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                DataTable dtven = new DataTable();
                dt.DefaultView.RowFilter = "TXT ='L1'";
                dtven = (dt.DefaultView).ToTable();
                dbcon.FillDDLwithdt1(ddl_li, dtven);
                dbcon.FillDDLwithdt1(ddl_updateLI, dtven);               
            }
        }
    }

    [WebMethod]
    public static IEnumerable bindsubdiv(string div)
    {
        DataTable subdiv = new DataTable();
        string qry2 = "select sub_div,sub_div_code from HRMS_SUB_DIV where status = '0' and div = '" + div + "'";
        OracleDataAdapter oda = new OracleDataAdapter(qry2, oraconstatic);
        oda.Fill(subdiv);
        return subdiv.ToDataSetToJSON();
    }

    [WebMethod]
    public static IEnumerable oldemplist(string report)
    {
        DataTable value = new DataTable();
        string qry2 = "select EMP_NM,AADHAR,UIDNO,DIV_CODE,SUB_DIV from HRMS_FULL_EMP_DETAIL where status = 0 ";
        qry2 = qry2 + "and L1_reporting='" + report + "' order by EMP_NM";
        OracleDataAdapter oda = new OracleDataAdapter(qry2, oraconstatic);
        oda.Fill(value);
        return value.ToDataSetToJSON();
    }

    [WebMethod]
    public static IEnumerable updatelist(newlist[] newlist)
    {
        DataSet resultds = new DataSet();
        DataTable resultdt = new DataTable();
        foreach (newlist item in newlist)
        {
            resultds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(item.typ, item.aadhar.Trim(), dtlogin.Rows[0]["user_loginid"].ToString(), item.updateli.Trim(), "", "", item.effectivedate, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
            resultdt = resultds.Tables[0];

        }
        if (resultdt.Rows.Count > 0)
        {
            var result = resultdt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {
            return "1";
        }
    }

    public class newlist
    {
        public string typ { get; set; }
        public string aadhar { get; set; }
        public string updateli { get; set; }
        public string effectivedate { get; set; }
    }
}