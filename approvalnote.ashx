<%@ WebHandler Language="C#" Class="approvalnote" %>

using System;
using System.Web;
using System.Data;


public class approvalnote : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
                string s = context.Request.Form["doctype"];
                doctypeArray = s.Split(',');
                string requestNo = context.Request.Form["requestNo"];
                string mgmntrmrk = context.Request.Form["Managementrmrk"];
                string mgmntdt = context.Request.Form["ManagementDt"];
                              
                string timedate = DateTime.Now.ToString("ddMMyyHHmmss");
                //Check if Request is to Upload the File.                           
                HttpFileCollection SelectedFiles = context.Request.Files;
                int cnt = SelectedFiles.Count;

                for (int i = 0; i < SelectedFiles.Count; i++)
                {
                    //Fetch the Uploaded File.
                    HttpPostedFile postedFile = context.Request.Files[i];

                    //Set the Folder Path.                   
                  // var folderPath = new System.IO.DirectoryInfo(pdfRootPath);
                     string folderPath = dbcon.NASPATH();

                    //Set the File Name.
                    fileName = System.IO.Path.GetFileNameWithoutExtension(postedFile.FileName);
                    extension = System.IO.Path.GetExtension(postedFile.FileName);
                    //Save the File in Folder.            
                    billname = fileName + "_" + doctypeArray[i].ToString() + extension;
                    postedFile.SaveAs(folderPath + billname);
                    if (doctypeArray[i].ToString() == "17")
                    {
                        ds = dbcon.Exe_Proc_with_PROC_HRMS_MRF("6", requestNo, dtlogin.Rows[0]["user_loginid"].ToString(), doctypeArray[i].ToString(), billname, mgmntrmrk, mgmntdt);

                    }
                    else {
                        ds = dbcon.Exe_Proc_with_PROC_HRMS_MRF("7", requestNo, dtlogin.Rows[0]["user_loginid"].ToString(), doctypeArray[i].ToString(), billname);
                    }
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
    public string pdfRootPath
    {
        get
        {
            return System.Configuration.ConfigurationManager.AppSettings["pdfRootPath"];
        }
    }



    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
