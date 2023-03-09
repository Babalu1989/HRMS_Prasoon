using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UIDReturnreplace : System.Web.UI.Page
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
                    dt.DefaultView.RowFilter = "TXT ='DIV'";
                    dtdiv = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_division, dtdiv);

                    DataTable dtdept = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='DEPT'";
                    dtdept = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_department_popup, dtdept);

                    DataTable dtddl_vendor = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='VENDOR'";
                    dtddl_vendor = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_vendor_popup, dtddl_vendor);
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
        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, "", dtlogin.Rows[0]["user_loginid"].ToString());
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        dt1.Columns.Add("#", typeof(System.String));
        if (HttpContext.Current.Session["EMP_TYPE"].ToString() == "Security")
        {
            foreach (DataRow row in dt1.Rows)
            {
                //need to set value to NewColumn column
                row["#"] = "<div class='dropdown dropdown-action'><a href='#' class='action-icon dropdown-toggle' data-toggle='dropdown' aria-expanded='false'><i class='material-icons'>more_vert</i></a><div class='dropdown-menu dropdown-menu-right'><a class='dropdown-item'  href='javascript:void(0)' onclick=\"edit_employee('" + row["Aadhaar No"].ToString() + "," + row["Employee Name"].ToString() + "," + row["UID"].ToString() + "," + row["Request Type"].ToString() + "," + row["ID Card Validity"].ToString() + "');\"><i class='fa fa-pencil m-r-5'></i>Edit</a></div></div>";
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
    public static IEnumerable employeeterminate(string typ,string aadhar,string status,string UID,string txt_uidtype, string txtremarks,string  newuidno,string txt_validupto)
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, aadhar, dtlogin.Rows[0]["user_loginid"].ToString(), status, UID, txt_uidtype, txtremarks, newuidno, txt_validupto);
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
    [WebMethod]
    public static IEnumerable UIDRetunreplaceSave(string typ, string reqno, string name, string fname, string dob, string company, string department, string division, string aadhar, string reqtype)
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF("15", reqno, dtlogin.Rows[0]["user_loginid"].ToString(), name, fname, dob, company, department, division, aadhar, "", "", "", "", reqtype);
        dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            //DataSet dscandidate = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("101A", "", dtlogin.Rows[0]["user_loginid"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
            //string success = mailservice.mail_service("Brplgis.Helpdesk@relianceada.com", "", "", "Brplgis.Helpdesk@relianceada.com," + dscandidate.Tables[0].Rows[0]["Mail_ID"].ToString(), dscandidate.Tables[0].Rows[0]["MAIL_SUB"].ToString(), dscandidate.Tables[0].Rows[0]["MAIL_BODY"].ToString(), "", "HRMS IT CLEARANCE", "GISMAILSERVICE", "BRPLG!S@DM!N");
            var result = dt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {
            return "1";
        }

    }

    [WebMethod]
    public static string createpdf(string refno)
    {
       // var filePath = new System.IO.DirectoryInfo(pdfRootPath).ToString();
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
}