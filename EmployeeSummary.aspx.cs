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
    OracleConnection oracon;
    static OracleConnection oraconstatic;
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public  DBCONNECTION dbcon = new DBCONNECTION();
    static DataSet ds = new DataSet();    
    protected void Page_Load(object sender, EventArgs e)
    {        
        oracon = new OracleConnection(NDS.Connection());     
        oraconstatic = new OracleConnection(NDS.Connection());
        if (!Page.IsPostBack)
        {
            string qry1 = "select division_name,division_code from TBL_DIVISION_MASTER where division_code not in ('KCC','EHV') order by division_name ";
            dbcon.FillDDL(ddl_div, qry1);             
        }
    }

    [WebMethod]
    public static IEnumerable bindata(string typ,string div,string subdiv)
    {
        DataSet ds1 = new DataSet();
        DataTable dt1 = new DataTable();
        OracleDataAdapter da = new OracleDataAdapter("proc_commonrpt_hrms", oraconstatic);
        da.SelectCommand.Parameters.Add("rprt_type", OracleType.VarChar).Value = typ;
        da.SelectCommand.Parameters.Add("p_report", OracleType.VarChar).Value = "Common";
        da.SelectCommand.Parameters.Add("p_text1", OracleType.VarChar).Value = div;
        da.SelectCommand.Parameters.Add("p_text2", OracleType.VarChar).Value = subdiv;
        da.SelectCommand.Parameters.Add("p_text3", OracleType.VarChar).Value = "0";
        da.SelectCommand.Parameters.Add("p_text4", OracleType.VarChar).Value = "0";
        da.SelectCommand.Parameters.Add("p_text5", OracleType.VarChar).Value = "0";
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.Add("v_refcur", OracleType.Cursor).Direction = ParameterDirection.Output;
        da.Fill(ds1);
        dt1 = ds1.Tables[0];
        DataTable subdivdt = new DataTable();
        string qry2 = "select sub_div,sub_div_code from HRMS_SUB_DIV where status = '0' and div = '" + div + "'";
        OracleDataAdapter oda = new OracleDataAdapter(qry2, oraconstatic);
        oda.Fill(subdivdt);
        ds1.Tables.Add(subdivdt);
        if (ds1.Tables[1].Rows.Count > 0)
        {
            var result = ds1.GetJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {

            return "1";
        }

    }

    protected void ddl_project_list_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable subdiv=new DataTable();
        string qry2 = "select sub_div,sub_div_code from HRMS_SUB_DIV where status = '0' and div = '" + ddl_div.SelectedValue + "'";
        OracleDataAdapter oda = new OracleDataAdapter(qry2, oraconstatic);
        oda.Fill(subdiv);
dbcon.FillDDL(ddl_subdivision, qry2);        
    }
   
}