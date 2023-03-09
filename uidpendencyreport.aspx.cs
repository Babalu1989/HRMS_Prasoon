using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.OracleClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class uidpendencyreport : System.Web.UI.Page
{
    static DataTable dtlogin = new DataTable();
    public static DBCONNECTION dbcon = new DBCONNECTION();    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            dtlogin = Session["fetchlogindetails"] as DataTable;
        }
        catch (Exception er)
        {
            Response.Redirect("Login");
        }
    }
    [WebMethod]
    public static IEnumerable bindata(string typ,string frmdate,string todate)
    {
        try
        {
            frmdate = frmdate == "" ? "0" : frmdate;
            todate = todate == "" ? "0" : todate;
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds = dbcon.Exe_Proc_with_PROC_HRMS_MRF(typ, "", dtlogin.Rows[0]["user_loginid"].ToString(), frmdate, todate);
            dt = ds.Tables[0];
            if (dt.Rows.Count > 0)
            {
                var result = dt.ToDataSetToJSON();
                var temp = result.Length;//500000000
                return result;
            }
            else
            {

                return "";
            }
        }
        catch (Exception er) {
            return er.Message;
        }

    }

    [WebMethod]
    public static IEnumerable download(string refno)
    {
        DataSet ds = new DataSet();
        ds = dbcon.Exe_Proc_with_PROC_HRMS_MRF("12", refno.Trim(), dtlogin.Rows[0]["user_loginid"].ToString());
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        var result = dt1.AsEnumerable().Select(c => new { SR_NO = c["SR_NO"], file_id = c["file_id"], TXT = c["TXT"] }).ToList();
        return result;
    }

    protected void pdfprint(object sender, EventArgs e)
    {
        string id = "";
        id = (Request.Form[pdfid.UniqueID] ?? "");
        id = (Request.Form[pdfid.UniqueID] ?? null);
        try
        {
            //Session["pdf_nm"] = id;
            Response.Redirect("ViewDocapp_dwn_pdf.aspx?pdf_nm=" + id);

        }
        catch (Exception er)
        {
            lbl_msg.Text = er.Message;
            string script = "window.onload = function() { popup(); };";
            ClientScript.RegisterStartupScript(this.GetType(), "popup", script, true);
        }

    }
    [WebMethod]
    public static string dnpdf(string refno)
    {
        var filePath = new System.IO.DirectoryInfo(pdfRootPath).ToString();
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
    }

    public static string pdfRootPath
    {
        get
        {
            return System.Configuration.ConfigurationManager.AppSettings["pdfRootPath"];
        }
    }

    [WebMethod]
    public static IEnumerable bindmoredata(string typ, string id)
    {
        try
        {
            DataSet ds = new DataSet();
            ds = dbcon.Exe_Proc_with_PROC_HRMS_MRF(typ, id, dtlogin.Rows[0]["user_loginid"].ToString());
            DataTable dt1 = new DataTable();
            dt1 = ds.Tables[0];
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
        catch (Exception er)
        {
            return er.Message;
        }

    }
}