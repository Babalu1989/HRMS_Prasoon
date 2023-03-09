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
            string qry = "select ddl_desc, sr_no from hrms_rprt_typ where status = 1 order by sr_no "; //where USER_DEPARTMENT = 'IT'
            dbcon.FillDDL(ddl_based, qry);
        }
    }

    [WebMethod]
    public static IEnumerable bindata(string typ)
    {
        DataSet ds1 = new DataSet();
        DataTable dt1 = new DataTable();
        OracleDataAdapter da = new OracleDataAdapter("proc_deduping_hrms", oraconstatic);
        da.SelectCommand.Parameters.Add("rprt_type", OracleType.VarChar).Value = typ;
        da.SelectCommand.Parameters.Add("p_report", OracleType.VarChar).Value = "Common";
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.Add("v_refcur", OracleType.Cursor).Direction = ParameterDirection.Output;
        da.Fill(ds1);
        dt1 = ds1.Tables[0];      
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
}