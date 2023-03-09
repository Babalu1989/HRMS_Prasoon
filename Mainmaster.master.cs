using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Mainmaster : System.Web.UI.MasterPage
{
    DataTable dtlogin = new DataTable();
    StringBuilder str = new StringBuilder();
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    DataTable dt_parent = new DataTable();
    int j, k = 0;
    public DBCONNECTION dbcon = new DBCONNECTION();
    int hrmsRecords, dtclearRecords, hrreport = 0, mrfcount = 0, uidcount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            dtlogin = Session["fetchlogindetails"] as DataTable;
            loginname.InnerText = dtlogin.Rows[0]["USER_NAME"].ToString() + " (" + dtlogin.Rows[0]["USER_LOGINID"].ToString() + " )";
            if (!IsPostBack)
            {
                chart_bind();
            }
        }
        catch (Exception er)
        {
           Response.Redirect("login");
          
        }
    }

    private void chart_bind()
    {

        try
        {    
            ds = dbcon.Exe_Proc_with_PROC_EMP_MASTER_MNG("9E", "", dtlogin.Rows[0]["USER_LOGINID"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
            DataTable dt = new DataTable();
            dt = ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                DataTable dthrms = new DataTable();
                dt.DefaultView.RowFilter = "parentid = '51'";
                dthrms = (dt.DefaultView).ToTable();
                DataTable dtclear = new DataTable();
                dt.DefaultView.RowFilter = "parentid = '61'";
                dtclear = (dt.DefaultView).ToTable();

                DataTable dthrreport = new DataTable();
                dt.DefaultView.RowFilter = "parentid = '81'";
                dthrreport = (dt.DefaultView).ToTable();

                DataTable mrf = new DataTable();
                dt.DefaultView.RowFilter = "parentid = '136'";
                mrf = (dt.DefaultView).ToTable();

                DataTable UID = new DataTable();
                dt.DefaultView.RowFilter = "parentid = '137'";
                UID = (dt.DefaultView).ToTable();


                hrmsRecords = dt.Select("parentid = '51'").Length;
                dtclearRecords = dt.Select("parentid = '61'").Length;
                hrreport = dt.Select("parentid = '81'").Length;
                mrfcount = dt.Select("parentid = '136'").Length;
                uidcount = dt.Select("parentid = '137'").Length;

                str.Append("");
                if (hrmsRecords > 0)
                {

                    for (int i = 0; i <= dthrms.Rows.Count - 1; i++)
                    {
                        if (dthrms.Rows[i]["pagename"].ToString() == "Dashboard")
                        {
                            str.AppendLine("<li class='v " + dthrms.Rows[i]["pagename"].ToString() + "'><a href=" + dthrms.Rows[i]["pagename"].ToString() + " class='noti-dot'><i class='" + dthrms.Rows[i]["ICON"].ToString() + "'></i><span>" + dthrms.Rows[i]["Menu_name"].ToString() + "</span></a></li>");
                        }
                        else
                        {
                            str.AppendLine("<li class='v " + dthrms.Rows[i]["pagename"].ToString() + "'><a href=" + dthrms.Rows[i]["pagename"].ToString() + "><i class='" + dthrms.Rows[i]["ICON"].ToString() + "'></i><span>" + dthrms.Rows[i]["Menu_name"].ToString() + "</span></a></li>");

                        }

                    }
                }
                //if (mrfcount > 0)
                //{

                //    str.AppendLine("<li class='v submenu'><a href='v #'><i class='la la-building'></i><span>MRF </span><span class='menu-arrow'></span></a><ul>");
                //    //for (int i = 0; i <= dtclear.Rows.Count - 1; i++)
                //    //{

                //        str.AppendLine("<li class='v MRF'><a href=MRF><i class=''></i><span>MRF Request</span></a></li>");
                //        str.AppendLine("<li class='v MRFapprove'><a href=MRFapprove><i class=''></i><span>MRF Approval</span></a></li>");
                //        str.AppendLine("<li class='v mrfreport'><a href=mrfreport><i class=''></i><span>MRF Report</span></a></li>");
                //        str.AppendLine("<li class='v POCreation'><a href=POCreation><i class=''></i><span>PO Creation </span></a></li>");
                //        // }
                //    str.AppendLine("</ul></li>");
                //}
                //if (mrfcount > 0)
                //{

                //    str.AppendLine("<li class='v submenu'><a href='v #'><i class='la la-building'></i><span>UID </span><span class='menu-arrow'></span></a><ul>");
                //    //for (int i = 0; i <= dtclear.Rows.Count - 1; i++)
                //    //{                   
                //    str.AppendLine("<li class='v UIDGeneration'><a href=UIDGeneration><i class=''></i><span>ID Creation</span></a></li>");
                //    str.AppendLine("<li class='v UIDTermination'><a href=UIDTermination><i class=''></i><span>Seperation</span></a></li>");
                //    str.AppendLine("<li class='v UIDRenewal'><a href=UIDRenewal><i class=''></i><span>Renewal</span></a></li>");
                //    str.AppendLine("<li class='v UIDReturnreplace'><a href=UIDReturnreplace><i class=''></i><span>R&R /Lost</span></a></li>");
                //    str.AppendLine("<li class='v uidpendencyreport'><a href=uidpendencyreport><i class='uidpendencyreport'></i><span>UID Report</span></a></li>");
                //    // }
                //    str.AppendLine("</ul></li>");
                //}
                if (mrfcount > 0)
                {

                    str.AppendLine("<li class='v submenu'><a href='v #'><i class='la la-building'></i><span>MRF </span><span class='menu-arrow'></span></a><ul>");
                    for (int i = 0; i <= mrf.Rows.Count - 1; i++)
                    {

                        str.AppendLine("<li class='v " + mrf.Rows[i]["pagename"].ToString() + "'><a href=" + mrf.Rows[i]["pagename"].ToString() + "><i class='" + mrf.Rows[i]["ICON"].ToString() + "'></i><span>" + mrf.Rows[i]["Menu_name"].ToString() + "</span></a></li>");
                    }
                    str.AppendLine("</ul></li>");
                }

                if (uidcount > 0)
                {

                    str.AppendLine("<li class='v submenu'><a href='v #'><i class='la la-building'></i><span>UID </span><span class='menu-arrow'></span></a><ul>");
                    for (int i = 0; i <= UID.Rows.Count - 1; i++)
                    {

                        str.AppendLine("<li class='v " + UID.Rows[i]["pagename"].ToString() + "'><a href=" + UID.Rows[i]["pagename"].ToString() + "><i class='" + UID.Rows[i]["ICON"].ToString() + "'></i><span>" + UID.Rows[i]["Menu_name"].ToString() + "</span></a></li>");
                    }
                    str.AppendLine("</ul></li>");
                }


                if (dtclearRecords > 0)
                {

                    str.AppendLine("<li class='v submenu'><a href='v #'><i class='la la-building'></i><span>Clearance </span><span class='menu-arrow'></span></a><ul>");
                    for (int i = 0; i <= dtclear.Rows.Count - 1; i++)
                    {

                        str.AppendLine("<li class='v " + dtclear.Rows[i]["pagename"].ToString() + "'><a href=" + dtclear.Rows[i]["pagename"].ToString() + "><i class='" + dtclear.Rows[i]["ICON"].ToString() + "'></i><span>" + dtclear.Rows[i]["Menu_name"].ToString() + "</span></a></li>");
                    }
                    str.AppendLine("</ul></li>");
                }

                if (hrreport > 0)
                {

                    str.AppendLine("<li class='v submenu'><a href='v #'><i class='la la-building'></i><span>HR Report </span><span class='menu-arrow'></span></a><ul>");
                    for (int i = 0; i <= dthrreport.Rows.Count - 1; i++)
                    {

                        str.AppendLine("<li class='v " + dthrreport.Rows[i]["pagename"].ToString() + "'><a href=" + dthrreport.Rows[i]["pagename"].ToString() + "><i class='" + dthrreport.Rows[i]["ICON"].ToString() + "'></i><span>" + dthrreport.Rows[i]["Menu_name"].ToString() + "</span></a></li>");
                    }
                    str.AppendLine("</ul></li>");
                }
            }
            else
            {
                string script = "window.onload = function() { right('No Rights Available at this Point,Kindly Contact to Admin Team'); };";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "popup", script, true);
            }        
            lt.Text = str.ToString().TrimEnd(',').Replace('*', '"');
        }
        catch
        {
        }
    }    
}
