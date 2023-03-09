using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using System.Collections;
using System.Web.Services;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Configuration;

public partial class mrfapprove : System.Web.UI.Page
{
   static DataTable dtlogin = new DataTable();
   static DataTable dtloginstatic = new DataTable();
    public DBCONNECTION dbcon = new DBCONNECTION();
    static mail ms = new mail();
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public static DataSet dsstatic = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            dtlogin = Session["fetchlogindetails"] as DataTable;
            dtloginstatic = Session["fetchlogindetails"] as DataTable;
            lbl_msg.Text = "";
            if (!this.IsPostBack)
            {
                Session["EMP_CODE"] = dtlogin.Rows[0]["USER_LOGINID"].ToString();
                Session["DIV_code"] = dtlogin.Rows[0]["DIVISION"].ToString();
                Session["EMP_TYPE"] = dtlogin.Rows[0]["MRFUSERTYP"].ToString();
                Session["MRFUSERDEPT"] = dtlogin.Rows[0]["MRFUSERDEPT"].ToString();
                DataSet resultds = new DataSet();
                resultds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF("1JM", Session["MRFUSERDEPT"].ToString(), "", "");
                DataTable revapp = new DataTable();
                revapp = resultds.Tables[0];
                if (revapp.Rows.Count > 0)
                {
                    dbcon.FillDDLwithoutdtmat(ddl_chairman, revapp);
                }
                DataTable dtclear = new DataTable();
                Session["dtVendor"] = dtclear;
                binddata();
            }
        }
        catch (Exception er)
        {
            Response.Redirect("Login");
        }
    }

    public void binddata()
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbcon.Exe_Proc_with_PROC_HRMS_MRF("2", "", dtlogin.Rows[0]["user_loginid"].ToString());
        dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            Session["dtVendor"] = dt;
            btn_Save.Visible = true;
            if (dtlogin.Rows[0]["MRFUSERTYP"].ToString() == "Approver")
            {
                interviewdiv.Visible = true;                
            }
            if (dtlogin.Rows[0]["MRFUSERTYP"].ToString() == "F&A")
            {

                costdiv.Visible = true;
            }
            if (dtlogin.Rows[0]["MRFUSERTYP"].ToString() == "Budget")
            {

                ddl_provisiondiv.Visible = true;
            }
            if (dtlogin.Rows[0]["MRFUSERTYP"].ToString() == "HR")
            {
                ddl_hrdiv.Visible = true;
            }
        }
        else
        {
            dt.Clear();
            Session["dtVendor"] = dt;
            interviewdiv.Visible = false;
            costdiv.Visible = false;
            ddl_provisiondiv.Visible = false;
            ddl_hrdiv.Visible = false;
            lbl_message.Text = "No Manpower Requsition Request Pending, No of Record:" +dt.Rows.Count;
        } 
    }

    [WebMethod]
    public static IEnumerable Save(approveReject[] approveReject)
    {
        string empname = "";
        string empid = "";
        string[] splitst;
        List<Result> result = new List<Result>();
        DataSet ds = new DataSet();
        if (approveReject != null)
        {
            //foreach (approveReject item in approveReject)
            for (int item =0;item<(approveReject.Length)/2;item++)
            {
                string Reqid = approveReject[item].reqid;
                string emp_code = approveReject[item].emp_code;
                string status = approveReject[item].status;
                string rejectRemarks = approveReject[item].rejectRemarks;
                string emptype = approveReject[item].emp_typ;
                string ApproveRemarks = approveReject[item].ApproveRemarks;
                string interviewmember = approveReject[item].interviewmember;
                if (interviewmember == null) {
                    interviewmember = "";
                }
                if (emptype == "HR")
                {
                   splitst= interviewmember.Split(new Char[]{'&'});

                   interviewmember = splitst[0];
                   empid = splitst[1];
                   empname = splitst[2];                   
                
                }

                DataTable dt = new DataTable();
                ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF("4", Reqid, emp_code, emptype, rejectRemarks, status, ApproveRemarks, interviewmember, empid, empname);
                dt = ds.Tables[0];

                if (dt.Rows[0]["MSG_CODE"].ToString() == "0")
                {
                    ms.mail_send("101A", ds.Tables[0].Rows[0]["TXT"].ToString(), Reqid, status, emp_code, "");
                }
                Result res = new Result();
                result = dt.AsEnumerable().Select(c => new Result
                {
                    MSG_CODE = c["MSG_CODE"].ToString(),
                    TXT = c["TXT"].ToString(),

                }).ToList();
            }
        }
        return result;
    }


    [WebMethod]
    public static string createpdf(string refno)
    {
        mrfapprove nq = new mrfapprove();
        nq.creat_new_pdf(refno);
       //var filePath = new System.IO.DirectoryInfo(pdfRootPath).ToString();
        string filePath = dbconStatic.NASPATH();
        string fileName = refno+".pdf";
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

    private void creat_new_pdf(string refno)
    {
        var filePath = "";
        DataTable dt = new DataTable();
        dsstatic = dbcon.Exe_Proc_with_PROC_HRMS_MRF("5", "", "",refno);
        dt = dsstatic.Tables[0];
        Document pdfDoc = new Document(PageSize.A4, 15f, 15f, 25f, 25f);
        string msg;
        string msg2;
        string msg3;
        string msg4;
        string printdate = DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss");
        DataSet ds = new DataSet();
        try
        {

            msg = File.ReadAllText(Server.MapPath("~/Files/ApprovalNote.html"));
            msg2 = File.ReadAllText(Server.MapPath("~/Files/JD.html"));
            msg3 = File.ReadAllText(Server.MapPath("~/Files/Committejustification.html"));
            msg4 = File.ReadAllText(Server.MapPath("~/Files/MRFFormformat.html"));
            if (dt.Rows.Count > 0)
            {
                msg = msg.Replace("{Division}", dt.Rows[0]["DIVISION"].ToString());
                msg = msg.Replace("{app_date}", dt.Rows[0]["INSRTDT"].ToString());
                msg = msg.Replace("{ref_no}", refno);
                //Added 11-Aug-2020
                msg = msg.Replace("{hod}", dt.Rows[0]["APPROVERINSRTBY"].ToString());
                msg = msg.Replace("{app}", dt.Rows[0]["REVIWERINSRTBY"].ToString());
                msg = msg.Replace("{noposition}", dt.Rows[0]["REQUIREDNOOFPOSITION"].ToString());
                msg = msg.Replace("{position}", dt.Rows[0]["REQUIREDPOSITION"].ToString());
                msg = msg.Replace("{dept}", dt.Rows[0]["DEPARTMENT"].ToString());
                msg = msg.Replace("{reqtype}", dt.Rows[0]["MANPOWERREQUIREMENT"].ToString());
                msg = msg.Replace("{period}", dt.Rows[0]["POSITIONREQUIREMENT"].ToString());
                msg = msg.Replace("{qual}", dt.Rows[0]["QUALIFICATION"].ToString());
                msg = msg.Replace("{wages}", dt.Rows[0]["CATEGORYOFWAGES"].ToString());
                msg = msg.Replace("{costcenter}", dt.Rows[0]["COSTCENTER"].ToString());
                msg = msg.Replace("{cost}", dt.Rows[0]["cost"].ToString());
                
                //Added 11-Aug-2020

                //msg = msg.Replace("{ONMDetail}", dt.Rows[0]["ONMINSRTBY"].ToString());              removed on 18 march due to 17 march 2021 UAT point
                //msg = msg.Replace("{BUSINESSDetail}", dt.Rows[0]["BUSINESSINSRTBY"].ToString());   removed on 18 march due to 17 march 2021 UAT point
                msg = msg.Replace("{AUDITDetail}", dt.Rows[0]["AUDITINSRTBY"].ToString());
                msg = msg.Replace("{HRDetail}", dt.Rows[0]["HRINSRTBY"].ToString());
                msg = msg.Replace("{BUDGETDetail}", dt.Rows[0]["BUDGETINSRTBY"].ToString());
                msg = msg.Replace("{FNADetail}", dt.Rows[0]["FNAINSRTBY"].ToString());
                msg = msg.Replace("{CHAIRMANDetail}", dt.Rows[0]["CHAIRMANINSRTBY"].ToString());




                msg = msg.Replace("{printdate}", printdate);                          
                var imgDir = HttpContext.Current.Request.Url.AbsoluteUri.Split('/');
                var imagepath = HttpContext.Current.Request.Url.AbsoluteUri.Replace(imgDir[imgDir.Length - 2], "files/BSES-Rajdhani.png");
                msg = msg.Replace("{ImgLogo}", imagepath.Replace("/createpdf", ""));

                StringReader sr = new StringReader(msg);
                Rectangle pageSize = new Rectangle(720.0f, 216.0f);

              // var directoryInfo = new DirectoryInfo(pdfRootPath);
                
               var directoryInfo = dbcon.NASPATH(); 

                filePath = directoryInfo + refno + ".pdf";

                HTMLWorker htmlparser = new HTMLWorker(pdfDoc);

                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, new FileStream(filePath, FileMode.Create));
                pdfDoc.Open();
                PdfContentByte cb;
                iTextSharp.text.pdf.PdfTemplate headerTemplate, footerTemplate;
                BaseFont bf = null;
                //DateTime PrintTime = DateTime.Now;   
                bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                cb = writer.DirectContent;
                headerTemplate = cb.CreateTemplate(100, 100);
                footerTemplate = cb.CreateTemplate(50, 50);

                cb.BeginText();
                cb.SetFontAndSize(bf, 6);
                cb.SetTextMatrix(pdfDoc.PageSize.GetLeft(10), pdfDoc.PageSize.GetBottom(10));
                cb.ShowText("");

                cb.EndText();
                float len = bf.GetWidthPoint("REGISTERED", 12);
                cb.AddTemplate(footerTemplate, pdfDoc.PageSize.GetRight(180) + len, pdfDoc.PageSize.GetBottom(30));
                iTextSharp.text.html.simpleparser.StyleSheet styles = new iTextSharp.text.html.simpleparser.StyleSheet();
                iTextSharp.text.html.simpleparser.HTMLWorker hws = new iTextSharp.text.html.simpleparser.HTMLWorker(pdfDoc);
                hws.Parse(new StringReader(msg));


                // for JD
                pdfDoc.NewPage();
                msg2 = msg2.Replace("{Division}", dt.Rows[0]["DIVISION"].ToString());
                msg2 = msg2.Replace("{app_date}", dt.Rows[0]["INSRTDT"].ToString());
                msg2 = msg2.Replace("{ref_no}", refno);
                msg2 = msg2.Replace("{JOBDESCRIPTION}", dt.Rows[0]["JOBROLEID"].ToString());
                msg2 = msg2.Replace("{noposition}", dt.Rows[0]["REQUIREDNOOFPOSITION"].ToString());
                msg2 = msg2.Replace("{position}", dt.Rows[0]["REQUIREDPOSITION"].ToString());
                msg2 = msg2.Replace("{dept}", dt.Rows[0]["DEPARTMENT"].ToString());

                msg2 = msg2.Replace("{printdate}", printdate);
                var imgDir2 = HttpContext.Current.Request.Url.AbsoluteUri.Split('/');
                var imagepath2 = HttpContext.Current.Request.Url.AbsoluteUri.Replace(imgDir2[imgDir2.Length - 2], "files/BSES-Rajdhani.png");
                msg2 = msg2.Replace("{ImgLogo}", imagepath2.Replace("/createpdf", ""));
                            
                hws.Parse(new StringReader(msg2));
                //For JD

                // for MRF Form
                pdfDoc.NewPage();

                msg4 = msg4.Replace("{Division}", dt.Rows[0]["DIVISION"].ToString());
                msg4 = msg4.Replace("{app_date}", dt.Rows[0]["INSRTDT"].ToString());
                msg4 = msg4.Replace("{ref_no}", refno);
               
                
                msg4 = msg4.Replace("{noposition}", dt.Rows[0]["REQUIREDNOOFPOSITION"].ToString());
                msg4 = msg4.Replace("{position}", dt.Rows[0]["REQUIREDPOSITION"].ToString());
                msg4 = msg4.Replace("{dept}", dt.Rows[0]["DEPARTMENT"].ToString());

                msg4 = msg4.Replace("{mrftype}", dt.Rows[0]["MRFTYPE"].ToString());
                msg4 = msg4.Replace("{period}", dt.Rows[0]["PERIODREQUIREMENT"].ToString());
                msg4 = msg4.Replace("{circle}", dt.Rows[0]["CIRCLE"].ToString());
                msg4 = msg4.Replace("{reqtype}", dt.Rows[0]["POSITIONREQUIREMENT"].ToString());
                msg4 = msg4.Replace("{Replacement}", dt.Rows[0]["REPLACEMENTAGAINST"].ToString());
                msg4 = msg4.Replace("{subdiv}", dt.Rows[0]["SUDIVISION"].ToString());
                msg4 = msg4.Replace("{empid}", dt.Rows[0]["EMPLOYEEID"].ToString());
                msg4 = msg4.Replace("{costcenter}", dt.Rows[0]["COSTCENTER"].ToString());
                msg4 = msg4.Replace("{empname}", dt.Rows[0]["EMPLOYEENAME"].ToString());
                msg4 = msg4.Replace("{posting}", dt.Rows[0]["PLACEOFPOSTING"].ToString());
                msg4 = msg4.Replace("{vendor}", dt.Rows[0]["VENDOR"].ToString());
                msg4 = msg4.Replace("{justification}", dt.Rows[0]["JUSTIFICATION"].ToString());
                msg4 = msg4.Replace("{wages}", dt.Rows[0]["CATEGORYOFWAGES"].ToString());
                msg4 = msg4.Replace("{qualification}", dt.Rows[0]["QUALIFICATION"].ToString());
                msg4 = msg4.Replace("{budget}", dt.Rows[0]["REQUIREDBUDGET"].ToString());
                msg4 = msg4.Replace("{budgetavail}", dt.Rows[0]["BUDGETAVAILABILTY"].ToString());
                msg4 = msg4.Replace("{requisitioner}", dt.Rows[0]["REQUISTIONER"].ToString());
                msg4 = msg4.Replace("{Reviewer}", dt.Rows[0]["REVIWERINSRTBY"].ToString());
                msg4 = msg4.Replace("{Approver}", dt.Rows[0]["APPROVERINSRTBY"].ToString());
                msg4 = msg4.Replace("{printdate}", printdate);
                var imgDir4 = HttpContext.Current.Request.Url.AbsoluteUri.Split('/');
                var imagepath4 = HttpContext.Current.Request.Url.AbsoluteUri.Replace(imgDir4[imgDir4.Length - 2], "files/BSES-Rajdhani.png");
                msg4 = msg4.Replace("{ImgLogo}", imagepath4.Replace("/createpdf", ""));


                hws.Parse(new StringReader(msg4));
                // for MRF Form


                // for commite justification
                pdfDoc.NewPage();
                msg3 = msg3.Replace("{Division}", dt.Rows[0]["DIVISION"].ToString());
                msg3 = msg3.Replace("{app_date}", dt.Rows[0]["INSRTDT"].ToString());
                msg3 = msg3.Replace("{ref_no}", refno);              
                msg3 = msg3.Replace("{noposition}", dt.Rows[0]["REQUIREDNOOFPOSITION"].ToString());
                msg3 = msg3.Replace("{position}", dt.Rows[0]["REQUIREDPOSITION"].ToString());
                msg3 = msg3.Replace("{dept}", dt.Rows[0]["DEPARTMENT"].ToString());

                msg3 = msg3.Replace("{auditremarks}", dt.Rows[0]["AUDITRMRK"].ToString());
                msg3 = msg3.Replace("{hrremarks}", dt.Rows[0]["HRRMRK"].ToString());
                msg3 = msg3.Replace("{hrdd}", dt.Rows[0]["PROVISION_HR"].ToString());
                msg3 = msg3.Replace("{budgetremarks}", dt.Rows[0]["BUDGETRMRK"].ToString());
                msg3 = msg3.Replace("{budgetdd}", dt.Rows[0]["PROVISION_BUDGET"].ToString());
                msg3 = msg3.Replace("{fnaremarks}", dt.Rows[0]["FNARMRK"].ToString());
                msg3 = msg3.Replace("{fnadd}", dt.Rows[0]["FNACOSTBENEFIT"].ToString());
                msg3 = msg3.Replace("{chairmanremarks}", dt.Rows[0]["CHAIRMANRMRK"].ToString());


                msg3 = msg3.Replace("{ONMDetail}", dt.Rows[0]["ONMINSRTBY"].ToString());
                msg3 = msg3.Replace("{BUSINESSDetail}", dt.Rows[0]["BUSINESSINSRTBY"].ToString());
                msg3 = msg3.Replace("{AUDITDetail}", dt.Rows[0]["AUDITINSRTBY"].ToString());
                msg3 = msg3.Replace("{HRDetail}", dt.Rows[0]["HRINSRTBY"].ToString());
                msg3 = msg3.Replace("{BUDGETDetail}", dt.Rows[0]["BUDGETINSRTBY"].ToString());
                msg3 = msg3.Replace("{FNADetail}", dt.Rows[0]["FNAINSRTBY"].ToString());
                msg3 = msg3.Replace("{CHAIRMANDetail}", dt.Rows[0]["CHAIRMANINSRTBY"].ToString());


                msg3 = msg3.Replace("{printdate}", printdate);
                var imgDir3 = HttpContext.Current.Request.Url.AbsoluteUri.Split('/');
                var imagepath3 = HttpContext.Current.Request.Url.AbsoluteUri.Replace(imgDir3[imgDir3.Length - 2], "files/BSES-Rajdhani.png");
                msg3 = msg3.Replace("{ImgLogo}", imagepath3.Replace("/createpdf", ""));

                
                hws.Parse(new StringReader(msg3));
                // for commite justification


                
                
                
                pdfDoc.Close();
                if (File.Exists(filePath))
                {
                    if (File.Exists(Server.MapPath("Files/" + refno + ".pdf")))
                    {
                        File.Delete(Server.MapPath("Files/" + refno + ".pdf"));
                    }

                    File.Copy(filePath, Server.MapPath("Files/" + refno + ".pdf"));

                }

            }
           
        }

        catch (Exception er)
        {
            pdfDoc.Close();
            //  return ds;
        }
    }

    [WebMethod]
    public static IEnumerable bindmoredata(string typ, string id)
    {
        try
        {
            DataSet ds = new DataSet();
            ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, id, dtlogin.Rows[0]["user_loginid"].ToString());
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


    [WebMethod]
    public static IEnumerable checkbrpluid(string empcode, string type)
    {
        DataSet resultds = new DataSet();
        resultds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(type, empcode, "", "");
        var result = resultds.GetJSON();
        var temp = result.Length;//500000000
        return result;

    }



    public class Result
    {
        public string MSG_CODE { get; set; }
        public string TXT { get; set; }
    }

    public class approveReject
    {
        public string reqid { get; set; }
        public string emp_typ { get; set; }
        public string emp_code { get; set; }
        public string status { get; set; }
        public string rejectRemarks { get; set; }
        public string ApproveRemarks { get; set; }
        public string interviewmember { get; set; }
        
    }


    public static string pdfRootPath
    {
        get
        {
            return System.Configuration.ConfigurationManager.AppSettings["pdfRootPath"];
        }
    }
}