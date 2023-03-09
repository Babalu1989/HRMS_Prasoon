<%@ WebHandler Language="C#" Class="vendorregistration" %>

using System;
using System.Web;
using System.Data;
public class vendorregistration : IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
                string vendor = context.Request.Form["vendor"];
                string status = context.Request.Form["status"];
                string fromdate = context.Request.Form["fromdate"];
                string todate = context.Request.Form["todate"];
                string orderno = context.Request.Form["orderno"];
                string person = context.Request.Form["person"];
                string contact = context.Request.Form["contact"];
                string email = context.Request.Form["email"];
                string reason = context.Request.Form["reason"]; 
                string timedate = DateTime.Now.ToString("ddMMyyHHmmss");

                string vendorname =  context.Request.Form["vendorname"];
                string vendorshort =  context.Request.Form["vendorshort"];
                string type =  context.Request.Form["type"];

          
                //Check if Request is to Upload the File.                           
                HttpFileCollection SelectedFiles = context.Request.Files;
                int cnt = SelectedFiles.Count;

                for (int i = 0; i < SelectedFiles.Count; i++)
                {
                    //Fetch the Uploaded File.
                    HttpPostedFile postedFile = context.Request.Files[i];

                    //Set the Folder Path.
                    //string folderPath = @"E:\HrmsPDf\";
//                    string folderPath = dbcon.NASPATHvendor();
                    string folderPath = dbcon.NASPATH();

                    //Set the File Name.
                    fileName = System.IO.Path.GetFileNameWithoutExtension(postedFile.FileName);
                    extension = System.IO.Path.GetExtension(postedFile.FileName);
                    //Save the File in Folder.            
                    billname = fileName + "_" + vendor + "_" + doctypeArray[i].ToString() + "_" + timedate;
                    postedFile.SaveAs(folderPath + billname);
                    ds = dbcon.Exe_Proc_with_PROC_EMP_MASTER_MNG(type, vendor, dtlogin.Rows[0]["user_loginid"].ToString(), orderno, fromdate, todate, person, contact, email, billname, status, vendorname, vendorshort, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
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

}