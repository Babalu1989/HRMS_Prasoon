<%@ WebHandler Language="C#" Class="profilemodaldatasave" %>

using System;
using System.Web;
using System.Data;
using System.IO;

public class profilemodaldatasave : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    DBCONNECTION dbcon = new DBCONNECTION();
    DataSet ds = new DataSet();
    public void ProcessRequest(HttpContext context)
    {
        DataTable dt = context.Session["fetchlogindetails"] as DataTable;

        if (dt.Rows.Count > 0 || dt != null)
        {
            if (context.Request.Form.Keys.Count > 0)
            {
                string aadhar = context.Request.Form["aadhar"].ToString();
                string cano = context.Request.Form["files"].ToString();                
                //string folderPath = @"E:\HRMS_EMPLOYEE_IMAGES\PICS\";
                string folderPath = dbcon.NASPATH();
                Base64ToImage(cano).Save(folderPath + aadhar);
                string fname = context.Request.Form["fname"].ToString();
                string lname = context.Request.Form["lname"].ToString();
                string empid = context.Request.Form["empid"].ToString();
                string brplid = context.Request.Form["brplid"].ToString();
               
                string gender = context.Request.Form["gender"].ToString();
                string doj = context.Request.Form["doj"].ToString();
                string dob = context.Request.Form["dob"].ToString();
                string address = context.Request.Form["address"].ToString();
                string reportto = context.Request.Form["reportto"].ToString();
                string phone = context.Request.Form["phone"].ToString();
                string department = context.Request.Form["department"].ToString();
                string designation = context.Request.Form["designation"].ToString();
                string email = context.Request.Form["email"].ToString();
                string state = context.Request.Form["state"].ToString();
                string city = context.Request.Form["city"].ToString();

                string profilemodalpermanentaddress = context.Request.Form["profilemodalpermanentaddress"].ToString();
                string profilemodalpermanentstate = context.Request.Form["profilemodalpermanentstate"].ToString();
                string profilemodalpermanentcity = context.Request.Form["profilemodalpermanentcity"].ToString();
                
                
                string div = context.Request.Form["division"].ToString();
                string subdiv = context.Request.Form["subdivision"].ToString();
                string picname = context.Request.Form["picname"].ToString();// +".JPG";

                ds = dbcon.Exe_Proc_with_PROC_EMP_MASTER_MNG("1", aadhar, dt.Rows[0]["user_loginid"].ToString(), fname + " " + lname, empid, brplid, gender, doj, dob, address, city, state, reportto, phone, department, designation, email, div, subdiv, picname, profilemodalpermanentaddress, profilemodalpermanentstate, profilemodalpermanentcity,"", "", "", "", "", "", "", "", "", "", "", "", "", "", "");

            }

        }
        else
        {

        }
        //Send File details in a JSON Response.
        string json = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(
            new
            {
                name = ds.Tables[0].Rows[0]["TXT"].ToString()
            });
        context.Response.StatusCode = (int)System.Net.HttpStatusCode.OK;
        context.Response.ContentType = "text/json";
        context.Response.Write(json);
        context.Response.End();
    }

    public System.Drawing.Image Base64ToImage(string base64String)
    {
        base64String = base64String.Replace("data:image/jpeg;base64,", "");
        byte[] imageBytes = Convert.FromBase64String(base64String);
        MemoryStream ms = new MemoryStream(imageBytes, 0, imageBytes.Length);
        ms.Write(imageBytes, 0, imageBytes.Length);
        System.Drawing.Image image = System.Drawing.Image.FromStream(ms, true);
        return image;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}