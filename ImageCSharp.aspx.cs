using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO; 

public partial class CSharp : System.Web.UI.Page
{
    DBCONNECTION dbcon = new DBCONNECTION();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["FileName"] != null)
            {
                // Read the file and convert it to Byte Array                
                //  string filePath = "E:\\HRMS_EMPLOYEE_IMAGES\\PICS\\";
                string filePath = dbcon.NASPATH();
                string filename = Request.QueryString["FileName"];
                string contenttype = "image/" + Path.GetExtension(filename).Replace(".", "");
                FileStream fs = new FileStream(filePath + filename, FileMode.Open, FileAccess.Read);
                BinaryReader br = new BinaryReader(fs);
                Byte[] bytes = br.ReadBytes((Int32)fs.Length);
                br.Close();
                fs.Close();

                //Write the file to response Stream
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = contenttype;
                Response.AddHeader("content-disposition", "attachment;filename=" + filename);
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.End();
            }
        }
        catch (Exception er)
        {
            
        }
    }
}
