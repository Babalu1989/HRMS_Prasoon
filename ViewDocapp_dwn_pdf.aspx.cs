using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class _Default : System.Web.UI.Page
{
    DBCONNECTION dbcon = new DBCONNECTION();   
    String[] allfiles;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string strDocName = "";
            var sessionValue = Session["pdf_nm"] ?? Request.QueryString["pdf_nm"];
            string strSLDDocName = sessionValue.ToString();
            if (!Page.IsPostBack)
            {
                if (!string.IsNullOrEmpty(strSLDDocName))
                {
                    //fpath = @"E:\HrmsPDf\";
                   // fpath = dbcon.NASPATH();  // for production changes required
                    string fpath = new System.IO.DirectoryInfo(pdfRootPath).ToString();
                    strDocName = strSLDDocName;
                    string[] orginalFileName = strSLDDocName.Split('.');
                    if (orginalFileName.Length > 0)
                    {
                        strDocName = orginalFileName[0];
                    }


                    allfiles = System.IO.Directory.GetFiles(fpath, strSLDDocName, System.IO.SearchOption.AllDirectories);
                }               
                if (allfiles.Length > 0)
                {
                    //Collect Bytes from database and write in Webpage
                    WebClient client = new WebClient();
                    Byte[] buffer = client.DownloadData(allfiles[0]);
                    Response.ContentType = "Application/pdf";
                    Response.AddHeader("content-length", buffer.Length.ToString());
                    Response.BinaryWrite(buffer);
                }
                else
                {
                    Response.Write("PDF File Not Available.");
                    return;
                }

            }
            Response.AddHeader("content-disposition", "attachment;filename=" + strSLDDocName);     // to open file prompt Box open or Save file        

            Response.Charset = "";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Response.TransmitFile(allfiles[0]);
            Response.Flush();
        }
        catch (Exception ex)
        {
            Response.Redirect(ex.Message);
        }

    }

    public string pdfRootPath
    {
        get
        {
            return System.Configuration.ConfigurationManager.AppSettings["pdfRootPath"];
        }
    }
}

