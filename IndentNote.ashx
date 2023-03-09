<%@ WebHandler Language="C#" Class="approvalnote" %>

using System;
using System.Web;
using System.Data;


public class approvalnote : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    DBCONNECTION dbcon = new DBCONNECTION();    
    DataSet ds = new DataSet();
    static mail ms = new mail();
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
                //String[] docArray;
                string s = context.Request.Form["doctype"];
                doctypeArray = s.Split(',');
                string timedate = DateTime.Now.ToString("ddMMyyHHmmss");
                //Check if Request is to Upload the File.                           
                HttpFileCollection SelectedFiles = context.Request.Files;
                int cnt = SelectedFiles.Count;

                string requisitionno = context.Request.Form["requisitionno"];
                string mrftype = context.Request.Form["mrftype"];
                string positionrequirement = context.Request.Form["positionrequirement"];
                string periodrequirement = context.Request.Form["periodrequirement"];
                string circle = context.Request.Form["circle"];
                string division = context.Request.Form["division"];
                string manpowerrequirement = context.Request.Form["manpowerrequirement"];
                string replacementagainst = context.Request.Form["replacementagainst"];
                string sudivision = context.Request.Form["sudivision"];
                string department = context.Request.Form["department"];
                string employeeid = context.Request.Form["employeeid"];
                string costcenter = context.Request.Form["costcenter"];
                string employeename = context.Request.Form["employeename"];
                string placeofposting = context.Request.Form["placeofposting"];
                string vendor = context.Request.Form["vendor"];
                string requiredposition = context.Request.Form["requiredposition"];
                string justification = context.Request.Form["justification"];
                string requirednoofposition = context.Request.Form["requirednoofposition"];
                string categoryofwages = context.Request.Form["categoryofwages"];
                string qualification = context.Request.Form["qualification"];
                string requiredbudget = context.Request.Form["requiredbudget"];
                string budgetavailabilty = context.Request.Form["budgetavailabilty"];
                string jobroleid = context.Request.Form["jobroleid"];
                string requistioner = context.Request.Form["requistioner"];
                string reviewer = context.Request.Form["reviewer"];
                string interviewpanelmember = context.Request.Form["interviewpanelmember"];
                string approver = context.Request.Form["approver"];
                string insrtusing = context.Request.Form["insrtusing"];
                string reviwerinsrtdt = context.Request.Form["reviwerinsrtdt"];//for uid function code
                



                for (int i = 0; i < SelectedFiles.Count; i++)
                {
                    //Fetch the Uploaded File.
                    HttpPostedFile postedFile = context.Request.Files[i];

                    //Set the Folder Path.                   
                  //  var folderPath = new System.IO.DirectoryInfo(pdfRootPath);
                       string folderPath = dbcon.NASPATH();

                    //Set the File Name.
                    fileName = System.IO.Path.GetFileNameWithoutExtension(postedFile.FileName);
                    extension = System.IO.Path.GetExtension(postedFile.FileName);
                    //Save the File in Folder.            
                    billname = fileName + "_" + doctypeArray[i].ToString() + extension;
                    postedFile.SaveAs(folderPath + billname);
                    if (doctypeArray[i].ToString() == "19")
                    {
                        ds = dbcon.Exe_Proc_with_PROC_HRMS_MRF("1", mrftype, dtlogin.Rows[0]["user_loginid"].ToString(), requisitionno, positionrequirement, periodrequirement, circle, division, manpowerrequirement, replacementagainst, sudivision,
                        department, employeeid, costcenter, employeename, placeofposting, vendor, requiredposition, justification, requirednoofposition, categoryofwages, qualification, requiredbudget, budgetavailabilty,
                        jobroleid, requistioner, "123", interviewpanelmember, "456", dtlogin.Rows[0]["user_loginid"].ToString(), "ENTRYFORM", doctypeArray[i].ToString(), reviwerinsrtdt, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", billname);
                    }
                    if (ds.Tables[0].Rows[0]["MSG_CODE"].ToString() == "0")
                    {
                        ms.mail_send("101A", ds.Tables[0].Rows[0]["TXT"].ToString(), "", "0", dtlogin.Rows[0]["user_loginid"].ToString(), department);
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
