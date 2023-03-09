using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class POCreation : System.Web.UI.Page
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
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                ds = dbcon.Exe_proc_hrms_fill_data("DDL", "1", "", "", "", "", "");
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    DataTable dtdiv = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='BUYER'";
                    dtdiv = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_buyer, dtdiv);
                    
                }
            }
        }
        catch (Exception er)
        {
            Response.Redirect("Login");
        }
    }
    [WebMethod]
    public static IEnumerable bindata(string typ)
    {
        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, "", dtlogin.Rows[0]["user_loginid"].ToString(),dtlogin.Rows[0]["MRFUSERTYP"].ToString());
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        dt1.Columns.Add("#", typeof(System.String));
        if (HttpContext.Current.Session["EMP_TYPE"].ToString() == "HC" || HttpContext.Current.Session["EMP_TYPE"].ToString() == "Buyer")
        {
            foreach (DataRow row in dt1.Rows)
            {
                //need to set value to NewColumn column
                row["#"] = "<div class='dropdown dropdown-action'><a href='#' class='action-icon dropdown-toggle' data-toggle='dropdown' aria-expanded='false'><i class='material-icons'>more_vert</i></a><div class='dropdown-menu dropdown-menu-right'><a class='dropdown-item'  href='javascript:void(0)' onclick=\"edit_employee('" + row["Requisition No"].ToString() + "," + row["Status"].ToString() + "," + row["Department"].ToString() + "," + row["Buyer Name"].ToString() + "," + row["Number of POs"].ToString() + "');\"><i class='fa fa-pencil m-r-5'></i>Edit</a></div></div>";
            }
        }
        else {
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
    public static IEnumerable update(string typ, string req, buyerpo[] buyerpo, string pono, string wono, string fromdt, string todt)
    {
        DataSet ds = new DataSet();  
        DataTable dt = new DataTable();
        foreach (buyerpo item in buyerpo)
        {
            ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, req, dtlogin.Rows[0]["user_loginid"].ToString(), dtlogin.Rows[0]["MRFUSERTYP"].ToString(), item.buyer, item.noofpo, pono, wono, fromdt, todt);
            dt = ds.Tables[0];
        }
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

    public class buyerpo
    {
        public string buyer { get; set; }
        public string noofpo { get; set; }
    }

    [WebMethod]
    public static IEnumerable getpodetails(string POnumber)
    {
        DataTable dt = new DataTable();
      //  ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, "", dtlogin.Rows[0]["user_loginid"].ToString(), dtlogin.Rows[0]["MRFUSERTYP"].ToString());
        dt = getpodetailssap(POnumber);
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

    public static DataTable getpodetailssap(string PO)
    {
        //bsespi_SI_PGPO.SI_PGPOService srv1 = new bsespi_SI_PGPO.SI_PGPOService();
        //srv1.Credentials = new NetworkCredential("ssmsgis", "deld5501");      
        //bsespi_SI_PGPO.DT_PGPO_REQ inp = new bsespi_SI_PGPO.DT_PGPO_REQ();        
        //inp.AEDAT_LOW = "20200101";
        //inp.AEDAT_HIGH = "20200102";
        //inp.BUKRS = "BRPL";
        //inp.EBELN = "";
        //inp.EKGRP = "";
        //inp.LIFNR = "";
        //srv1.Timeout = 2000000000;
        //bsespi_SI_PGPO.DT_PGPO_RES oup = new bsespi_SI_PGPO.DT_PGPO_RES();
        //oup = srv1.SI_PGPO(inp);
        
        //relsrmcipmdcc.SI_941Service srv1 = new relsrmcipmdcc.SI_941Service();
        //srv1.Credentials = new NetworkCredential("tmbsesdel", "deld5501");
        //relsrmcipmdcc.DT_941_Req inp = new relsrmcipmdcc.DT_941_Req();
        //inp.BAPIINPUT = new relsrmcipmdcc.DT_941_ReqBAPIINPUT();
        //inp.BAPIINPUT.BAPI_MBLNR = "0023086433";// "4907654158";//material document number
        //inp.BAPIINPUT.BAPI_MJAHR = "2020";
        //inp.BAPIINPUT.BAPI_WERKS = "D021";
        //srv1.Timeout = 2000000000;
        //relsrmcipmdcc.DT_941_Res oup1 = new relsrmcipmdcc.DT_941_Res();
        //relsrmcipmdcc.DT_941_ResIT_ITEM oup2 = new relsrmcipmdcc.DT_941_ResIT_ITEM();
        //oup1 = srv1.SI_941(inp);

        PO_Fetch_mdcc.SI_PGMDCCService srv1 = new PO_Fetch_mdcc.SI_PGMDCCService();
        srv1.Credentials = new NetworkCredential("tmbsesdel", "deld5501");
        PO_Fetch_mdcc.DT_PGMDCC_req inp = new PO_Fetch_mdcc.DT_PGMDCC_req();
        inp.PO_NUMBER = "0023086433";       
        srv1.Timeout = 2000000000;
        PO_Fetch_mdcc.DT_PGMDCC_res oup1 = new PO_Fetch_mdcc.DT_PGMDCC_res();
        PO_Fetch_mdcc.DT_PGMDCC_resIT_ITEM oup2 = new PO_Fetch_mdcc.DT_PGMDCC_resIT_ITEM();
        PO_Fetch_mdcc.DT_PGMDCC_resIT_ITEM1 oup3 = new PO_Fetch_mdcc.DT_PGMDCC_resIT_ITEM1();
        oup1 = srv1.SI_PGMDCC(inp);
        //oup2 = srv1.SI_PGMDCC(inp);
        //oup3 = srv1.SI_PGMDCC(inp);


        DataTable response = new DataTable();
       // response.Columns.Add("FLAG"); response.Columns.Add("ACCOUNT_NUMBER"); response.Columns.Add("AVLE_BDGT"); response.Columns.Add("BUDGET_TYPE"); response.Columns.Add("COMMIT_ITEM"); response.Columns.Add("COMPANY_CODE"); response.Columns.Add("CONSUM_BDGT"); response.Columns.Add("COST_CENTER"); response.Columns.Add("FISCAL_YEAR"); response.Columns.Add("FUND"); response.Columns.Add("FUND_CENTER"); response.Columns.Add("TOTAL_BDGT"); response.Columns.Add("MESSAGE");
        return response;

    }

    [WebMethod]
    public static string createpdf(string refno)
    {
        //var filePath = new System.IO.DirectoryInfo(pdfRootPath).ToString();
        string filePath = dbconStatic.NASPATH();
        string fileName = refno;
        string extension = System.IO.Path.GetExtension(filePath + "\\" + fileName);
        Byte[] bytes = File.ReadAllBytes(filePath + "\\" + fileName);
        var base64 = Convert.ToBase64String(bytes);
        DataTable dt = new DataTable();
        dt.Columns.Add("STATUS");
        dt.Columns.Add("FileName");
        dt.Columns.Add("FileBase64");
        dt.Columns.Add("extension");
        dt.Rows.Add(1, fileName, base64, extension);
        return dt.ToDataSetToJSON();
        // return("ViewDocapp_dwn_pdf.aspx?pdf_nm=" + refno);
    }


    public static string pdfRootPath
    {
        get
        {
            return System.Configuration.ConfigurationManager.AppSettings["pdfRootPath"];
        }
    }
    [WebMethod]
    public static IEnumerable download(string refno)
    {
        DataSet ds = new DataSet();
        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF("12", refno.Trim(), dtlogin.Rows[0]["user_loginid"].ToString());
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        var result = dt1.AsEnumerable().Select(c => new { SR_NO = c["SR_NO"], file_id = c["file_id"], TXT = c["TXT"] }).ToList();
        return result;
    }
}