<%@ WebHandler Language="C#" Class="cardlost" %>

using System;
using System.Web;
using System.Data;
public class cardlost : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    DBCONNECTION dbcon = new DBCONNECTION();
    static Mail_WebReference_64_86.Service mailservice = new Mail_WebReference_64_86.Service();
    DataSet ds = new DataSet();
    public void ProcessRequest(HttpContext context)
    {
        DataTable dtlogin = context.Session["fetchlogindetails"] as DataTable;

        if (dtlogin.Rows.Count > 0 || dtlogin != null)
        {
            string billname = "NA";
            string fileName = "";
            string extension = "";
            if (context.Request.Files.Count > 0)
            {
                String[] doctypeArray;
                String[] docArray;
                string s = context.Request.Form["doctype"];
                doctypeArray = s.Split(',');
                string sdoc = context.Request.Form["doc"];
                docArray = sdoc.Split(',');


                string reqno = context.Request.Form["reqno"];
                string name = context.Request.Form["name"];
                string fname = context.Request.Form["fname"];
                string dob = context.Request.Form["dob"];
                string company = context.Request.Form["company"];
                string department = context.Request.Form["department"];
                string division = context.Request.Form["division"];

                string aadhar = context.Request.Form["aadhar"];
                string reqtype = context.Request.Form["reqtype"];                
                string typ = context.Request.Form["typ"];

          
                //Check if Request is to Upload the File.                           
                HttpFileCollection SelectedFiles = context.Request.Files;
                int cnt = SelectedFiles.Count;

                for (int i = 0; i < SelectedFiles.Count; i++)
                {
                    //Fetch the Uploaded File.
                    HttpPostedFile postedFile = context.Request.Files[i];

                    //Set the Folder Path.
                    var folderPath = new System.IO.DirectoryInfo(pdfRootPath).ToString();
//                    string folderPath = dbcon.NASPATHvendor();
                    //string folderPath = dbcon.NASPATH();

                    //Set the File Name.
                    fileName = System.IO.Path.GetFileNameWithoutExtension(postedFile.FileName);
                    extension = System.IO.Path.GetExtension(postedFile.FileName);
                    //Save the File in Folder.            
                    billname = fileName + "_" + aadhar + "_" + doctypeArray[i].ToString();
                    postedFile.SaveAs(folderPath + billname);
                    ds = dbcon.Exe_Proc_with_PROC_HRMS_MRF("15", reqno, dtlogin.Rows[0]["user_loginid"].ToString(), name, fname, dob, company, department, division, aadhar, "", "", "", "", reqtype, billname);
                }
            }
            //Send File details in a JSON Response.
            string json = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(
                new
                {
                    name = ds.Tables[0].Rows[0]["TXT"].ToString(),
                });
            context.Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            context.Response.ContentType = "text/json";
            context.Response.Write(json);
            context.Response.End();
        }
        else
        {
            //Send File details in a JSON Response.
            string json = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(
                new
                {
                    name = "Session Out !!!"
                });
            context.Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
            context.Response.ContentType = "text/json";
            context.Response.Write(json);
            context.Response.End();
        }
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    public static string pdfRootPath
    {
        get
        {
            return System.Configuration.ConfigurationManager.AppSettings["pdfRootPath"];
        }
    }
}