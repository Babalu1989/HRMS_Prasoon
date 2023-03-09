using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;

/// <summary>
/// Summary description for mail
/// </summary>
public partial class mail
{
    DBCONNECTION dbcon = new DBCONNECTION();
    public void mail_send(string typ,string msg,string reqno,string statucode,string userid,string dept="")
    {
        DataSet ds = new DataSet();
        DataTable dtmail = new DataTable();
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        string SendTo = "";
        string SendCC = "";
        string SendBCC = "";
        string strSubject = "";
        string strMessage = "";
        string Sendfrm = "";
        Mail_WebReference_64_86.Service mail = new Mail_WebReference_64_86.Service();
        ds = dbcon.Exe_Proc_with_PROC_HRMS_MRF(typ, reqno, "", statucode, dept,userid);
        dtmail = ds.Tables[0];

        Sendfrm = dtmail.Rows[0]["MAIL_FROM"].ToString();
        strSubject = dtmail.Rows[0]["MAIL_SUB"].ToString();
        SendTo = dtmail.Rows[0]["MAIL_TO"].ToString(); //"prasoonanand@relianceada.com"; ////"
        SendCC = dtmail.Rows[0]["MAIL_CC"].ToString();
        SendBCC = dtmail.Rows[0]["MAIL_BCC"].ToString();

        strMessage = "<html><body><p><font face=Arial>Dear User, </font></p></p>";            
        strMessage = strMessage + "<p><font face=Arial>"+ msg + ".</p></p></p>";      
     

        strMessage = strMessage + "<font face=Arial>Regards, </font></br>";
        strMessage = strMessage + "<font face=Arial>MRF Team</font>";
        strMessage = strMessage + "<p style=color:blue><font face=Arial>Note:This is a System generated mail,Please do not reply.</font></p></body></html>";

        string success = mail.mail_service(Sendfrm, SendTo, SendCC, SendBCC, strSubject, strMessage, "", "MRF Requisition", "GISMAILSERVICE", "BRPLG!S@DM!N");
        
    }
}