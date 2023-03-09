using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MRF : System.Web.UI.Page
{
    int errorcnt = 0;
    string FileName;
    static mail ms = new mail();
    DataTable Dt = new DataTable();
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public DBCONNECTION dbcon = new DBCONNECTION();
    static DataTable dtlogin = new DataTable();    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            dtlogin = Session["fetchlogindetails"] as DataTable;
            if (!IsPostBack)
            {
               // budgetcheck();

                ddl_Requisitioner.Text = dtlogin.Rows[0]["USER_NAME"].ToString() + " (" + dtlogin.Rows[0]["USER_LOGINID"].ToString() + " )";
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                ds = dbcon.Exe_proc_hrms_fill_data("DDL", "1", dtlogin.Rows[0]["USER_LOGINID"].ToString(), "", "", "", "");
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    DataTable dtven = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='VENDOR'";
                    dtven = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_venaddnew, dtven);

                    DataTable dtdept = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='MRFDEPT'";
                    dtdept = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_deptaddnew, dtdept);

                    DataTable dtcircle = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='CIRCLE'";
                    dtcircle = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_circle, dtcircle);

                    //DataTable dtdiv = new DataTable();
                    //dt.DefaultView.RowFilter = "TXT ='DIV'";
                    //dtdiv = (dt.DefaultView).ToTable();
                    //dbcon.FillDDLwithdt1(ddl_divaddnew, dtdiv);


                    DataTable dtposition = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='POSITION'";
                    dtposition = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_reqpostion, dtposition);

                    DataTable dtupdtreviwer = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='updateREVIEWER'";
                    dtupdtreviwer = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_Reviewerupdate, dtupdtreviwer);

                    DataTable dtupdtapprover = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='updateAPPROVER'";
                    dtupdtapprover = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_approverupdate, dtupdtapprover);

                    DataTable dtcostcenter = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='costcenter'";
                    dtcostcenter = (dt.DefaultView).ToTable();
                    if (dtcostcenter.Rows.Count > 0)
                    {
                        dbcon.FillDDLwithdt1(ddl_costcenter, dtcostcenter);
                    }

                    DataTable dtgl = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='GL'";
                    dtgl = (dt.DefaultView).ToTable();
                    if (dtgl.Rows.Count > 0)
                    {
                        dbcon.FillDDLwithdt1(ddl_gl, dtgl);
                    }

                     DataTable dtfuctioncode= new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='FUNCTIONCODE'";
                    dtfuctioncode = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_functioncode, dtfuctioncode);

                    

                }
            }
        }
        catch (Exception er)
        {
            Response.Redirect("Login");
        }
    }
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        try
        {
            if (FileUpload.HasFile)
            {
                FileName = Path.GetFileName(FileUpload.PostedFile.FileName);
                string Extension = Path.GetExtension(FileUpload.PostedFile.FileName);
                string FolderPath = ConfigurationManager.AppSettings["FolderPath"];

                string FilePath = Server.MapPath(FolderPath + FileName);
                FileUpload.SaveAs(FilePath);
                uploadtoserver(FilePath, Extension, "Yes");
            }
            else
            {
                lbl_msg.Text = "First Select Excel File";
                DataTable dtclear = new DataTable();
                gv_uploaddata.DataSource = dtclear;
                gv_uploaddata.DataBind();
            }
        }
        catch (Exception er)
        {
            //bool t = dbcon.UpdateDb("delete from EMP_MASTER_EXLUPL where status = '0' and trunc(INSRTDT)=  trunc(sysdate) and INSERT_BY ='" + user + "' and file_name='" + FileName + "'");
            //lbl_msg2.Text = "Data Not Uplaoded,Please try Again";
        }
    }
    private void uploadtoserver(string FilePath, string Extension, string isHDR)
    {
        try
        {
            string conStr = "";
            switch (Extension)
            {
                case ".xls": //Excel 97-03
                    conStr = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07
                    conStr = ConfigurationManager.ConnectionStrings["Excel07ConString"].ConnectionString;
                    break;
            }
            conStr = String.Format(conStr, FilePath, isHDR);
            OleDbConnection connExcel = new OleDbConnection(conStr);
            OleDbCommand cmdExcel = new OleDbCommand();
            OleDbDataAdapter oda = new OleDbDataAdapter();
            cmdExcel.Connection = connExcel;

            //Get the name of First Sheet
            connExcel.Open();
            DataTable dtExcelSchema;
            dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
            connExcel.Close();

            //Read Data from First Sheet
            connExcel.Open();
            cmdExcel.CommandText = "SELECT * From [" + SheetName + "]";
            oda.SelectCommand = cmdExcel;
            oda.Fill(Dt);
            connExcel.Close();
            if (Dt.Rows.Count > 0)
            {
                gv_uploaddata.DataSource = Dt;
                gv_uploaddata.DataBind();
                ViewState["gv_uploaddatadirState"] = Dt;
                 submit.Visible = true;

            }
            else
            {
                submit.Visible = false;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "InvalidArgs", "left('You have uploaded an Invalid format, Please refer Sample MRF Excel file');", true);
                return;
            }
        }
        catch (Exception er)
        {
            submit.Visible = false;
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "InvalidArgs", "left('You have uploaded an Invalid format, Please refer Sample MRF Excel file');", true);
            return;
        }
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gv_uploaddata.EditIndex = e.NewEditIndex;
        gv_uploaddata.DataSource = ViewState["gv_uploaddatadirState"];
        gv_uploaddata.DataBind();
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridViewRow row = (GridViewRow)gv_uploaddata.Rows[e.RowIndex];
        DataTable dt = ViewState["gv_uploaddatadirState"] as DataTable;
        dt.Rows.RemoveAt(row.RowIndex);
        dt.AcceptChanges();
        gv_uploaddata.DataSource = dt;
        gv_uploaddata.DataBind();

    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)gv_uploaddata.Rows[e.RowIndex];
            TextBox sno = (TextBox)row.Cells[1].Controls[0];
            TextBox MRFTYPE = (TextBox)row.Cells[2].Controls[0];
            TextBox CIRCLE = (TextBox)row.Cells[3].Controls[0];
            TextBox DIVISION = (TextBox)row.Cells[4].Controls[0];
            TextBox SUBDIVISION = (TextBox)row.Cells[5].Controls[0];
            TextBox POSITIONTERM = (TextBox)row.Cells[6].Controls[0];
            TextBox PERIOD = (TextBox)row.Cells[7].Controls[0];
            TextBox REQUIREMENT = (TextBox)row.Cells[8].Controls[0];
            TextBox REPLACEMENTAGAINST = (TextBox)row.Cells[9].Controls[0];
            TextBox DEPARTMENT = (TextBox)row.Cells[10].Controls[0];
            TextBox COSTCENTER = (TextBox)row.Cells[11].Controls[0];
            TextBox PLACEOFPOSTING = (TextBox)row.Cells[12].Controls[0];
            TextBox REQUIREDPOSTION = (TextBox)row.Cells[13].Controls[0];
            TextBox NOOFPOSITION = (TextBox)row.Cells[14].Controls[0];
            TextBox EMPID = (TextBox)row.Cells[15].Controls[0];
            TextBox EMPNAME = (TextBox)row.Cells[16].Controls[0];
            TextBox QUAL = (TextBox)row.Cells[17].Controls[0];
            TextBox CATEGORYOFWAGES = (TextBox)row.Cells[18].Controls[0];
            TextBox VENDOR = (TextBox)row.Cells[19].Controls[0];
            TextBox REQBUDGET = (TextBox)row.Cells[20].Controls[0];
            TextBox JUSTIFICATION = (TextBox)row.Cells[21].Controls[0];
            TextBox BUDGETAVAILABILITY = (TextBox)row.Cells[22].Controls[0];


            DataTable dt = ViewState["gv_uploaddatadirState"] as DataTable;
            gv_uploaddata.EditIndex = -1;
            dt.Rows[row.RowIndex]["MRFTYPE"] = MRFTYPE.Text;
            dt.Rows[row.RowIndex]["CIRCLE"] = CIRCLE.Text;
            dt.Rows[row.RowIndex]["DIVISION"] = DIVISION.Text;
            dt.Rows[row.RowIndex]["SUBDIVISION"] = SUBDIVISION.Text;
            dt.Rows[row.RowIndex]["POSITIONTERM"] = POSITIONTERM.Text;
            dt.Rows[row.RowIndex]["PERIOD"] = PERIOD.Text;
            dt.Rows[row.RowIndex]["REQUIREMENT"] = REQUIREMENT.Text;
            dt.Rows[row.RowIndex]["REPLACEMENTAGAINST"] = REPLACEMENTAGAINST.Text;
            dt.Rows[row.RowIndex]["DEPARTMENT"] = DEPARTMENT.Text;
            dt.Rows[row.RowIndex]["COSTCENTER"] = COSTCENTER.Text;
            dt.Rows[row.RowIndex]["PLACEOFPOSTING"] = PLACEOFPOSTING.Text;
            dt.Rows[row.RowIndex]["REQUIREDPOSTION"] = REQUIREDPOSTION.Text;
            dt.Rows[row.RowIndex]["NOOFPOSITION"] = NOOFPOSITION.Text;
            dt.Rows[row.RowIndex]["EMPID"] = EMPID.Text;
            dt.Rows[row.RowIndex]["EMPNAME"] = EMPNAME.Text;
            dt.Rows[row.RowIndex]["QUAL"] = QUAL.Text;
            dt.Rows[row.RowIndex]["CATEGORYOFWAGES"] = CATEGORYOFWAGES.Text;
            dt.Rows[row.RowIndex]["VENDOR"] = VENDOR.Text;
            dt.Rows[row.RowIndex]["REQBUDGET"] = REQBUDGET.Text;
            dt.Rows[row.RowIndex]["JUSTIFICATION"] = JUSTIFICATION.Text;
            dt.Rows[row.RowIndex]["BUDGETAVAILABILITY"] = BUDGETAVAILABILITY.Text;
            ViewState["dtnew"] = dt;
            gv_uploaddata.EditIndex = -1;
            gv_uploaddata.DataSource = ViewState["dtnew"];
            gv_uploaddata.DataBind();
        }
        catch (Exception er) { }

    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gv_uploaddata.EditIndex = -1;
        gv_uploaddata.DataSource = ViewState["gv_uploaddatadirState"];
        gv_uploaddata.DataBind();
    }

    protected void gv_uploaddata_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Access Cell values.
                string MRFTYPE = e.Row.Cells[2].Text;
                if (MRFTYPE == "&nbsp;" || MRFTYPE == "")
                {
                    e.Row.Cells[2].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44");
                    e.Row.Cells[2].ToolTip = "Please enter Manpower Requisition Type";
                    errorcnt++;
                }
                string CIRCLE = e.Row.Cells[3].Text;
                if (CIRCLE == "&nbsp;" || CIRCLE == "")
                {
                    e.Row.Cells[3].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44");
                    e.Row.Cells[3].ToolTip = "Please enter CIRCLE";
                    errorcnt++;
                }
                string DIVISION = e.Row.Cells[4].Text;
                if (DIVISION == "&nbsp;" || DIVISION == "")
                {
                    e.Row.Cells[4].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44");
                    e.Row.Cells[4].ToolTip = "Please enter DIVISION";
                    errorcnt++;
                }
                //string SUBDIVISION = e.Row.Cells[5].Text;
                //if (SUBDIVISION == "&nbsp;" || SUBDIVISION == "")
                //{
                //    e.Row.Cells[5].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44");
                //    e.Row.Cells[5].ToolTip = "Please enter SUBDIVISION";
                //    errorcnt++;
                //}
                string POSITIONTERM = e.Row.Cells[6].Text.Trim();

                if (POSITIONTERM == "&nbsp;" || POSITIONTERM == "")//ValidateDate(DOB) == false
                {
                    e.Row.Cells[6].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[6].ToolTip = "Please enter POSITIONTERM";
                    errorcnt++;
                }
                //else
                //{
                //    e.Row.Cells[6].Text = DateTime.ParseExact(DOB, "ddMMyyyy", CultureInfo.InvariantCulture).ToString("dd-MMM-yyyy");
                //}

                string PERIOD = e.Row.Cells[7].Text;
                if (PERIOD == "&nbsp;" || PERIOD == "")
                {
                    e.Row.Cells[7].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[7].ToolTip = "Please enter PERIOD";
                    errorcnt++;
                }
                string REQUIREMENT = e.Row.Cells[8].Text.Trim();
                if (REQUIREMENT == "&nbsp;" || REQUIREMENT == "")
                {
                    e.Row.Cells[8].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[8].ToolTip = "Wrong date format of REQUIREMENT";
                    errorcnt++;
                }

                string REPLACEMENTAGAINST = e.Row.Cells[9].Text;
                if (REPLACEMENTAGAINST == "&nbsp;" || REPLACEMENTAGAINST == "")
                {
                    e.Row.Cells[9].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[9].ToolTip = "Please enter REPLACEMENT AGAINST";
                    errorcnt++;
                }
                string DEPARTMENT = e.Row.Cells[10].Text;
                if (DEPARTMENT == "&nbsp;" || DEPARTMENT == "")
                {
                    e.Row.Cells[10].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[10].ToolTip = "Please enter DEPARTMENT";
                    errorcnt++;
                }
                string COSTCENTER = e.Row.Cells[11].Text.Trim();
                if (COSTCENTER == "&nbsp;" || COSTCENTER == "")
                {
                    e.Row.Cells[11].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[11].ToolTip = "Please enter COSTCENTER";
                    errorcnt++;
                }

                string PLACEOFPOSTING = e.Row.Cells[12].Text;
                if (PLACEOFPOSTING == "&nbsp;" || PLACEOFPOSTING == "")
                {
                    e.Row.Cells[12].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[12].ToolTip = "Please enter PLACE OF POSTING";
                    errorcnt++;
                }
                string REQUIREDPOSTION = e.Row.Cells[13].Text;
                if (REQUIREDPOSTION == "&nbsp;" || REQUIREDPOSTION == "")
                {
                    e.Row.Cells[13].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[13].ToolTip = "Please enter REQUIRED POSTION";
                    errorcnt++;
                }
                string NOOFPOSITION = e.Row.Cells[14].Text;
                if (NOOFPOSITION == "&nbsp;" || NOOFPOSITION == "")
                {
                    e.Row.Cells[14].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[14].ToolTip = "Please enter NO OF POSITION";
                    errorcnt++;
                }
                string EMPID = e.Row.Cells[15].Text;
                if (EMPID == "&nbsp;" || EMPID == "")
                {
                    e.Row.Cells[15].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[15].ToolTip = "Please enter Empid";
                    errorcnt++;
                }
                string EMPNAME = e.Row.Cells[16].Text;
                if (EMPNAME == "&nbsp;" || EMPNAME == "")
                {
                    e.Row.Cells[16].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[16].ToolTip = "Please enter Employee Name";
                    errorcnt++;
                }
                string QUAL = e.Row.Cells[17].Text;
                if (QUAL == "&nbsp;" || QUAL == "")
                {
                    e.Row.Cells[17].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[17].ToolTip = "Please enter QUALIFICATION";
                    errorcnt++;
                }
                string CATEGORYOFWAGES = e.Row.Cells[18].Text;
                if (CATEGORYOFWAGES == "&nbsp;" || CATEGORYOFWAGES == "")
                {
                    e.Row.Cells[18].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[18].ToolTip = "Please enter CATEGORY OF WAGES";
                    errorcnt++;
                }
                string VENDOR = e.Row.Cells[19].Text;
                if (VENDOR == "&nbsp;" || VENDOR == "")
                {
                    e.Row.Cells[19].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[19].ToolTip = "Please enter VENDOR";
                    errorcnt++;
                }

                string REQBUDGET = e.Row.Cells[20].Text;
                if (REQBUDGET == "&nbsp;" || REQBUDGET == "")
                {
                    e.Row.Cells[20].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[20].ToolTip = "Please enter REQUIRED BUDGET";
                    errorcnt++;
                }
                string JUSTIFICATION = e.Row.Cells[21].Text;
                if (JUSTIFICATION == "&nbsp;" || JUSTIFICATION == "")
                {
                    e.Row.Cells[21].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[21].ToolTip = "Please enter JUSTIFICATION";
                    errorcnt++;
                }
                string BUDGETAVAILABILITY = e.Row.Cells[22].Text;
                if (BUDGETAVAILABILITY == "&nbsp;" || BUDGETAVAILABILITY == "")
                {
                    e.Row.Cells[22].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[22].ToolTip = "Please enter BUDGET AVAILABILITY";
                    errorcnt++;
                }
                txt_errorcnt.Text = errorcnt.ToString();
            }

        }
        catch (Exception er)
        {
            lbl_msg.Text = er.Message;
        }
    }

    private bool ValidateDate(string date)
    {
        try
        {
            DateTime dt;
            string[] formats = { "ddMMyyyy" };
            if (!DateTime.TryParseExact(date, formats,
                            System.Globalization.CultureInfo.InvariantCulture, DateTimeStyles.None, out dt))
            {
                //your condition fail code goes here
                return false;
            }
            else
            {
                //success code
                return true;
            }
        }
        catch
        {
            return false;
        }
    }

    protected void filedownload_Click(object sender, EventArgs e)
    {
        string filename = "MRFForm.xlsx";
        string Filpath = Server.MapPath("~/Files/" + filename);
        DownLoad(Filpath);
    }
    public void DownLoad(string FName)
    {
        string path = FName;
        System.IO.FileInfo file = new System.IO.FileInfo(path);
        if (file.Exists)
        {
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
            Response.AddHeader("Content-Length", file.Length.ToString());
            Response.ContentType = "application/octet-stream"; // download […]

        }
    }


    protected void submit_Click(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        int cnt = 0;
        int gvcnt = gv_uploaddata.Rows.Count;
        if (gvcnt > 0)
        {
            if (Convert.ToInt32(txt_errorcnt.Text) > 0)
            {
                //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "InvalidArgs", "alert('Error in Sheet,Please Correct and Submit');", true); 
                string script = "window.onload = function() { left('Kindly Correct Highlited column in Sheet and Submit') };";
                ClientScript.RegisterStartupScript(this.GetType(), "left", script, true);
            }
            else
            {
                foreach (GridViewRow gr in gv_uploaddata.Rows)
                {
                    string sno = gv_uploaddata.Rows[gr.RowIndex].Cells[1].Text;
                    string MRFTYPE = gv_uploaddata.Rows[gr.RowIndex].Cells[2].Text;
                    string CIRCLE = gv_uploaddata.Rows[gr.RowIndex].Cells[3].Text;
                    string DIVISION = gv_uploaddata.Rows[gr.RowIndex].Cells[4].Text;
                    string SUBDIVISION = gv_uploaddata.Rows[gr.RowIndex].Cells[5].Text;
                    string POSITIONTERM = gv_uploaddata.Rows[gr.RowIndex].Cells[6].Text;
                    string PERIOD = gv_uploaddata.Rows[gr.RowIndex].Cells[7].Text;
                    string REQUIREMENT = gv_uploaddata.Rows[gr.RowIndex].Cells[8].Text;
                    string REPLACEMENTAGAINST = gv_uploaddata.Rows[gr.RowIndex].Cells[9].Text;
                    string DEPARTMENT = gv_uploaddata.Rows[gr.RowIndex].Cells[10].Text;
                    string COSTCENTER = gv_uploaddata.Rows[gr.RowIndex].Cells[11].Text;
                    string PLACEOFPOSTING = gv_uploaddata.Rows[gr.RowIndex].Cells[12].Text;
                    string REQUIREDPOSTION = gv_uploaddata.Rows[gr.RowIndex].Cells[13].Text;
                    string NOOFPOSITION = gv_uploaddata.Rows[gr.RowIndex].Cells[14].Text;
                    string EMPID = gv_uploaddata.Rows[gr.RowIndex].Cells[15].Text;
                    string EMPNAME = gv_uploaddata.Rows[gr.RowIndex].Cells[16].Text;
                    string QUAL = gv_uploaddata.Rows[gr.RowIndex].Cells[17].Text;
                    string CATEGORYOFWAGES = gv_uploaddata.Rows[gr.RowIndex].Cells[18].Text;
                    string VENDOR = gv_uploaddata.Rows[gr.RowIndex].Cells[19].Text;
                    string REQBUDGET = gv_uploaddata.Rows[gr.RowIndex].Cells[20].Text;
                    string JUSTIFICATION = gv_uploaddata.Rows[gr.RowIndex].Cells[21].Text;
                    string BUDGETAVAILABILITY = gv_uploaddata.Rows[gr.RowIndex].Cells[22].Text;
                    if (MRFTYPE != "" || MRFTYPE != "&nbsp;")                       
                    {
                        string status = "";
                        if (MRFTYPE == "MRF") {
                            status = "0";
                        }
                        else { status = "19"; }
                        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF("1", MRFTYPE, dtlogin.Rows[0]["user_loginid"].ToString(), "", POSITIONTERM, PERIOD, CIRCLE, DIVISION, REQUIREMENT, REPLACEMENTAGAINST, SUBDIVISION,
                  DEPARTMENT, dtlogin.Rows[0]["user_loginid"].ToString(), COSTCENTER, EMPNAME, PLACEOFPOSTING, VENDOR, REQUIREDPOSTION, JUSTIFICATION, NOOFPOSITION, CATEGORYOFWAGES, QUAL, REQBUDGET, BUDGETAVAILABILITY,
                   "", dtlogin.Rows[0]["user_loginid"].ToString(), "", "Anil Chilukuri,Sandeep Shrivastava,Sindhu Nair", "", dtlogin.Rows[0]["user_loginid"].ToString(), "UPLOAD", status, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
                        dt = ds.Tables[0];
                        cnt++;
                    }
                    else { }
                }
            }
            if (cnt > 0)
            {
                //DataSet dscandidate = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("101A", "", dtlogin.Rows[0]["user_loginid"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
                //string success = mailservice.mail_service("Brplgis.Helpdesk@relianceada.com", dscandidate.Tables[0].Rows[0]["Mail_ID_to"].ToString(), dscandidate.Tables[0].Rows[0]["Mail_ID_cc"].ToString(), dscandidate.Tables[0].Rows[0]["Mail_ID_bcc"].ToString(), dscandidate.Tables[0].Rows[0]["MAIL_SUB"].ToString(), dscandidate.Tables[0].Rows[0]["MAIL_BODY"].ToString(), "", "HRMS IT CLEARANCE", "GISMAILSERVICE", "BRPLG!S@DM!N");
                //DataTable dtclear = new DataTable();
                //gv_uploaddata.DataSource = dtclear;
                //gv_uploaddata.DataBind();
                string script = "window.onload = function() { left('" + ds.Tables[0].Rows[0]["TXT"].ToString() + "') };";
                ClientScript.RegisterStartupScript(this.GetType(), "left", script, true);
            }
        }
    }


    [WebMethod]
    public static IEnumerable getsubdiv(string typ, string ddlvalue)
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_proc_hrms_fill_data("DDL", typ, ddlvalue, "", "", "", "");
        dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            var result = dt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {
            return "1";
        }

    }

    [WebMethod]
    public static IEnumerable getdiv(string typ, string ddlvalue)
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_proc_hrms_fill_data("DDL", typ, ddlvalue, "", "", "", "");
        dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            var result = dt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {
            return "1";
        }

    }

    [WebMethod]
    public static IEnumerable costcenter(string typ, string ddlvalue)
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF("1JL", ddlvalue, dtlogin.Rows[0]["user_loginid"].ToString());
        dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            var result = dt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {
            return "1";
        }

    }


    [WebMethod]
    public static IEnumerable checkbrpluid(string empcode, string type)
    {
        DataSet resultds = new DataSet();
        resultds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(type, empcode, "", "");
        var result = resultds.GetJSON();
        var temp = result.Length;//500000000
        return result;

    }


    [WebMethod]
    public static IEnumerable MRFformsave(string typ, Saverecord[] Saverecord)
    {
        string dept="";
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        foreach (Saverecord item in Saverecord)
        {
            ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, item.mrftype, dtlogin.Rows[0]["user_loginid"].ToString(), "", item.positionrequirement, item.periodrequirement, item.circle, item.division, item.manpowerrequirement, item.replacementagainst, item.sudivision,
                   item.department, item.employeeid, item.costcenter, item.employeename, item.placeofposting, item.vendor, item.requiredposition, item.justification, item.requirednoofposition, item.categoryofwages, item.qualification, item.requiredbudget, item.budgetavailabilty,
                   item.jobroleid, item.requistioner, item.reviewer, item.interviewpanelmember, item.approver, dtlogin.Rows[0]["user_loginid"].ToString(), "ENTRYFORM", "0", item.reviwerinsrtdt, item.reviwerinsrtby, item.reviwerapprmrk, item.approverinsrtdt, item.approverinsrtby, item.approverapprmrk, item.auditinsrtdt,
                   item.auditinsrtby, item.auditrmrk, item.fnainsrtdt, item.fnainsrtby, item.fnarmrk, item.hrinsrtdt, item.hrinsrtby, item.hrrmrk, item.budgetinsrtdt, item.budgetinsrtby, item.budgetrmrk, item.chairmaninsrtdt, item.chairmaninsrtby, item.chairmanrmrk);
            dt = ds.Tables[0];
            dept = item.department;
        }
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["MSG_CODE"].ToString() == "0")
            {
                ms.mail_send("101A", dt.Rows[0]["TXT"].ToString(), "", "0", dtlogin.Rows[0]["user_loginid"].ToString(), dept);
            }
            var result = dt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {
            return "1";
        }
    }

    //added dated 29-oct-2020

    [WebMethod]
    public static IEnumerable checksapbudget(string cc, string gl)
    {     
        DataTable dt = new DataTable();       
        dt = budgetcheck(cc, gl);
        if (dt.Rows.Count > 0)
        {
            var result = dt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {
            return "1";
        }

    }
    public static DataTable budgetcheck(string cc, string gl)
    {
        bsesdelhi.bsespi_budget.SI_FUND_OMMSService srv1 = new bsesdelhi.bsespi_budget.SI_FUND_OMMSService();
        srv1.Credentials = new NetworkCredential("ssmsgis", "deld5501");
        //srv1.Credentials = new NetworkCredential("tmbsesdel", "deld5501");
        bsesdelhi.bsespi_budget.DT_FUND_REQ inp = new bsesdelhi.bsespi_budget.DT_FUND_REQ();
        inp.COMP_CODE = "BRPL";
        //inp.COST_CENTER = "0000032011";
        //inp.GL_ACCOUNT = "0007155300"; 
        //inp.COST_CENTER = "0000032101";//production 
        //inp.GL_ACCOUNT = "0007145035"; //production     
        inp.COST_CENTER = cc;
        inp.GL_ACCOUNT = gl;
        srv1.Timeout = 2000000000;
        bsesdelhi.bsespi_budget.DT_FUND_RES oup = new bsesdelhi.bsespi_budget.DT_FUND_RES();
        oup = srv1.SI_FUND_OMMS(inp);

        DataTable response = new DataTable();
        response.Columns.Add("FLAG"); response.Columns.Add("ACCOUNT_NUMBER"); response.Columns.Add("AVLE_BDGT"); response.Columns.Add("BUDGET_TYPE"); response.Columns.Add("COMMIT_ITEM"); response.Columns.Add("COMPANY_CODE"); response.Columns.Add("CONSUM_BDGT"); response.Columns.Add("COST_CENTER"); response.Columns.Add("FISCAL_YEAR"); response.Columns.Add("FUND"); response.Columns.Add("FUND_CENTER"); response.Columns.Add("TOTAL_BDGT"); response.Columns.Add("MESSAGE");

        if (oup.ZFUND_OMMS.Count() > 0)
        {
            response.Rows.Add("0", oup.ZFUND_OMMS[0].ACCOUNT_NUMBER, oup.ZFUND_OMMS[0].AVLE_BDGT, oup.ZFUND_OMMS[0].BUDGET_TYPE, oup.ZFUND_OMMS[0].COMMIT_ITEM, oup.ZFUND_OMMS[0].COMPANY_CODE, oup.ZFUND_OMMS[0].CONSUM_BDGT, oup.ZFUND_OMMS[0].COST_CENTER, oup.ZFUND_OMMS[0].FISCAL_YEAR, oup.ZFUND_OMMS[0].FUND, oup.ZFUND_OMMS[0].FUND_CENTER, oup.ZFUND_OMMS[0].TOTAL_BDGT, "");
        }
        else
        {
            response.Rows.Add("1", "", "", "", "", "", "", "", "", "", "", "", oup.RETURN[0].MESSAGE);
        }
        return response;

    }

    //added dated 29-oct-2020

    public class Saverecord
    {
        public string requisitionno { get; set; }
        public string mrftype { get; set; }
        public string positionrequirement { get; set; }
        public string periodrequirement { get; set; }
        public string circle { get; set; }
        public string division { get; set; }
        public string manpowerrequirement { get; set; }
        public string replacementagainst { get; set; }
        public string sudivision { get; set; }
        public string department { get; set; }
        public string employeeid { get; set; }
        public string costcenter { get; set; }
        public string employeename { get; set; }
        public string placeofposting { get; set; }
        public string vendor { get; set; }
        public string requiredposition { get; set; }
        public string justification { get; set; }
        public string requirednoofposition { get; set; }
        public string categoryofwages { get; set; }
        public string qualification { get; set; }
        public string requiredbudget { get; set; }
        public string budgetavailabilty { get; set; }
        public string jobroleid { get; set; }
        public string requistioner { get; set; }
        public string reviewer { get; set; }
        public string interviewpanelmember { get; set; }
        public string approver { get; set; }
        public string insrrtby { get; set; }
        public string insrtusing { get; set; }
        public string reviwerinsrtdt { get; set; }
        public string reviwerinsrtby { get; set; }
        public string reviwerapprmrk { get; set; }
        public string approverinsrtdt { get; set; }
        public string approverinsrtby { get; set; }
        public string approverapprmrk { get; set; }
        public string auditinsrtdt { get; set; }
        public string auditinsrtby { get; set; }
        public string auditrmrk { get; set; }
        public string fnainsrtdt { get; set; }
        public string fnainsrtby { get; set; }
        public string fnarmrk { get; set; }
        public string hrinsrtdt { get; set; }
        public string hrinsrtby { get; set; }
        public string hrrmrk { get; set; }
        public string budgetinsrtdt { get; set; }
        public string budgetinsrtby { get; set; }
        public string budgetrmrk { get; set; }
        public string chairmaninsrtdt { get; set; }
        public string chairmaninsrtby { get; set; }
        public string chairmanrmrk { get; set; }
    }
}