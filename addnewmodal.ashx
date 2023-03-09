<%@ WebHandler Language="C#" Class="addnewmodal" %>

using System;
using System.Web;
using System.Data;
using System.IO;

public class addnewmodal :IHttpHandler, System.Web.SessionState.IRequiresSessionState
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
                string cano = context.Request.Form["files"].ToString();
                string aadhar = context.Request.Form["aadhar"].ToString();               
               // string folderPath = @"E:\\HRMS_EMPLOYEE_IMAGES\\PICS\\";
                string folderPath = dbcon.NASPATH();
                Base64ToImage(cano).Save(folderPath +aadhar);
                string name = context.Request.Form["Ename"].ToString();
                string fathername = context.Request.Form["father"].ToString();
                string brplid = context.Request.Form["brplid"].ToString();
                string empid = context.Request.Form["empid"].ToString();               
                string email = context.Request.Form["email"].ToString();
                string doj = context.Request.Form["doj"].ToString();
                string dob = context.Request.Form["dob"].ToString();
                string phone = context.Request.Form["phone"].ToString();
                string alternatenumber = context.Request.Form["alternate"].ToString();
                string vendorname = context.Request.Form["vendor"].ToString();
                string department = context.Request.Form["department"].ToString();
                string designation = context.Request.Form["designation"].ToString();
                string reportto = context.Request.Form["reportto"].ToString();
                string gender = context.Request.Form["gender"].ToString();
                string country = context.Request.Form["country"].ToString();
                string div = context.Request.Form["division"].ToString();
                string subdiv = context.Request.Form["subdivision"].ToString();
                string state = context.Request.Form["state"].ToString();
                string city = context.Request.Form["city"].ToString();
                string address = context.Request.Form["address"].ToString();
                string landmark = context.Request.Form["landmark"].ToString();
                string pincode = context.Request.Form["pincode"].ToString();
                string contractmode = context.Request.Form["contractmode"].ToString();
                string contractfrom = context.Request.Form["contractfrom"].ToString();
                string contractto = context.Request.Form["contractto"].ToString();
                string uan = context.Request.Form["uan"].ToString();
                string emergency = context.Request.Form["emergency"].ToString();
                string wage = context.Request.Form["wage"].ToString();
                string voterid = context.Request.Form["voterid"].ToString();
                string noj = context.Request.Form["noj"].ToString();
                string replacementid = context.Request.Form["replacementid"].ToString(); 
                string jointype = context.Request.Form["jointype"].ToString();
                string approvalno = context.Request.Form["approvalno"].ToString();
                string workorderno = context.Request.Form["workorderno"].ToString();

                string picname = context.Request.Form["picname"].ToString();// +".JPG";
                ds = dbcon.Exe_Proc_with_PROC_EMP_MASTER_MNG("1G", aadhar, dt.Rows[0]["user_loginid"].ToString(), name, empid, brplid, gender, doj, dob, address, city, state, reportto, phone, department, designation, email, div, subdiv, picname, alternatenumber, fathername, voterid, noj, vendorname, contractmode, contractfrom, contractto, uan, emergency, wage, pincode, landmark, country, replacementid, jointype, approvalno, workorderno);

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
        base64String = base64String.Replace("data:image/png;base64,", "");
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