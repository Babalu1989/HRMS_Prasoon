using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UIDGeneration : System.Web.UI.Page
{
    string FileName;
    int errorcnt = 0;
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public DBCONNECTION dbcon = new DBCONNECTION();
    static DataTable dtlogin = new DataTable();
    DataTable Dt = new DataTable();
    static Mail_WebReference_64_86.Service mailservice = new Mail_WebReference_64_86.Service();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            dtlogin = Session["fetchlogindetails"] as DataTable;
            if (!IsPostBack)
            {
                Session["EMP_CODE"] = dtlogin.Rows[0]["USER_LOGINID"].ToString();
                Session["DIV_code"] = dtlogin.Rows[0]["DIVISION"].ToString();
                Session["EMP_TYPE"] = dtlogin.Rows[0]["MRFUSERTYP"].ToString();
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                ds = dbcon.Exe_proc_hrms_fill_data("DDL", "1", "", "", "", "", "");
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    DataTable dtdiv = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='DIV'";
                    dtdiv = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_division, dtdiv);

                    DataTable dtdept = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='DEPT'";
                    dtdept = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_department_popup, dtdept);

                    DataTable dtddl_vendor = new DataTable();
                    dt.DefaultView.RowFilter = "TXT ='VENDOR'";
                    dtddl_vendor = (dt.DefaultView).ToTable();
                    dbcon.FillDDLwithdt1(ddl_vendor_popup, dtddl_vendor);
                }

            }
        }
        catch (Exception er) {
            Response.Redirect("login");
        }
    }
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        try
        {
            //if (FileUpload.HasFile)
            //{
            //    FileName = Path.GetFileName(FileUpload.PostedFile.FileName);
            //    string Extension = Path.GetExtension(FileUpload.PostedFile.FileName);
            //    string FolderPath = ConfigurationManager.AppSettings["FolderPath"];

            //    string FilePath = Server.MapPath(FolderPath + FileName);
            //    FileUpload.SaveAs(FilePath);
            //    uploadtoserver(FilePath, Extension, "Yes");
            //}
            //else
            //{
            //    lbl_msg.Text = "First Select Excel File";
            //    DataTable dtclear = new DataTable();
            //    gv_uploaddata.DataSource = dtclear;
            //    gv_uploaddata.DataBind();
            //}
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
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "InvalidArgs", "alert('No File Selected');", true);
                return;
            }
        }
        catch (Exception er)
        {
            //bool t = dbcon.UpdateDb("delete from EMP_MASTER_EXLUPL where status = '0' and trunc(INSRTDT)=  trunc(sysdate) and INSERT_BY ='" + user + "' and file_name='" + FileName + "'");
            //lbl_msg2.Text = er.Message;
        }
    }

    private bool ValidateDate(string date)
    {
        try
        {
            DateTime dt;
            string[] formats = { "ddMMyyyy" };
            if (!DateTime.TryParseExact(date, formats,
                            System.Globalization.CultureInfo.InvariantCulture,
                            DateTimeStyles.None, out dt))
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
            TextBox EmpId = (TextBox)row.Cells[2].Controls[0];
            TextBox Name = (TextBox)row.Cells[3].Controls[0];
            TextBox Roles = (TextBox)row.Cells[4].Controls[0];
            TextBox Company = (TextBox)row.Cells[5].Controls[0];
            TextBox DOB = (TextBox)row.Cells[6].Controls[0];
            TextBox Aadhaar = (TextBox)row.Cells[7].Controls[0];
            TextBox DOJ = (TextBox)row.Cells[8].Controls[0];
            TextBox Department = (TextBox)row.Cells[9].Controls[0];
            TextBox Location = (TextBox)row.Cells[10].Controls[0];
            TextBox DOS = (TextBox)row.Cells[11].Controls[0];
            TextBox rofseperation = (TextBox)row.Cells[12].Controls[0];
            TextBox Mobile = (TextBox)row.Cells[13].Controls[0];
            TextBox Email = (TextBox)row.Cells[14].Controls[0];
            TextBox LIempid = (TextBox)row.Cells[15].Controls[0];
            TextBox Liname = (TextBox)row.Cells[16].Controls[0];
            TextBox Limobile = (TextBox)row.Cells[17].Controls[0];
            TextBox Liemail = (TextBox)row.Cells[18].Controls[0];
            DataTable dt = ViewState["gv_uploaddatadirState"] as DataTable;
            gv_uploaddata.EditIndex = -1;
            dt.Rows[row.RowIndex]["EmpId"] = EmpId.Text;
            dt.Rows[row.RowIndex]["Name"] = Name.Text;

            dt.Rows[row.RowIndex]["Roles"] = Roles.Text;
            dt.Rows[row.RowIndex]["Company"] = Company.Text;
            dt.Rows[row.RowIndex]["DOB"] = DOB.Text;
            dt.Rows[row.RowIndex]["Aadhaar"] = Aadhaar.Text;
            dt.Rows[row.RowIndex]["DOJ"] = DOJ.Text;
            dt.Rows[row.RowIndex]["Department"] = Department.Text;
            dt.Rows[row.RowIndex]["Location"] = Location.Text;
            dt.Rows[row.RowIndex]["DOS"] = DOS.Text;
            dt.Rows[row.RowIndex]["Reason for Seperation"] = rofseperation.Text;
            dt.Rows[row.RowIndex]["Mobile"] = Mobile.Text;
            dt.Rows[row.RowIndex]["Email"] = Email.Text;
            dt.Rows[row.RowIndex]["L1 Empid"] = LIempid.Text;
            dt.Rows[row.RowIndex]["L1 Name"] = Liname.Text;
            dt.Rows[row.RowIndex]["L1 Mobile"] = Limobile.Text;
            dt.Rows[row.RowIndex]["L1 Email"] = Liemail.Text;

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
                string EmpId = e.Row.Cells[2].Text;
                if (EmpId == "&nbsp;" || EmpId == "")
                {
                    e.Row.Cells[2].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44");
                    e.Row.Cells[2].ToolTip = "Please enter EmpId";
                    errorcnt++;
                }
                string Name = e.Row.Cells[3].Text;
                if (Name == "&nbsp;" || Name == "")
                {
                    e.Row.Cells[3].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44");
                    e.Row.Cells[3].ToolTip = "Please enter Name";
                    errorcnt++;
                }
                string Roles = e.Row.Cells[4].Text;
                if (Roles == "&nbsp;" || Roles == "")
                {
                    e.Row.Cells[4].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44");
                    e.Row.Cells[4].ToolTip = "Please enter Roles";
                    errorcnt++;
                }
                string Company = e.Row.Cells[5].Text;
                if (Company == "&nbsp;" || Company == "")
                {
                    e.Row.Cells[5].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44");
                    e.Row.Cells[5].ToolTip = "Please enter Company";
                    errorcnt++;
                }
                string DOB = e.Row.Cells[6].Text.Trim();

                if (ValidateDate(DOB) == false)
                {
                    e.Row.Cells[6].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[6].ToolTip = "Wrong date format of DOB";
                    errorcnt++;
                }
                else
                {
                    e.Row.Cells[6].Text = DateTime.ParseExact(DOB, "ddMMyyyy", CultureInfo.InvariantCulture).ToString("dd-MMM-yyyy");
                }

                string Aadhaar = e.Row.Cells[7].Text;
                if (Aadhaar == "&nbsp;" || Aadhaar == "")
                {
                    e.Row.Cells[7].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[7].ToolTip = "Please enter Aadhaar";
                    errorcnt++;
                }
                string DOJ = e.Row.Cells[8].Text.Trim();
                if (ValidateDate(DOJ) == false)
                {
                    e.Row.Cells[8].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[8].ToolTip = "Wrong date format of DOJ";
                    errorcnt++;
                }
                else
                {
                    e.Row.Cells[8].Text = DateTime.ParseExact(DOJ, "ddMMyyyy", CultureInfo.InvariantCulture).ToString("dd-MMM-yyyy");
                }

                string Department = e.Row.Cells[9].Text;
                if (Department == "&nbsp;" || Department == "")
                {
                    e.Row.Cells[9].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[9].ToolTip = "Please enter Department";
                    errorcnt++;
                }
                string Location = e.Row.Cells[10].Text;
                if (Location == "&nbsp;" || Location == "")
                {
                    e.Row.Cells[10].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[10].ToolTip = "Please enter Location";
                    errorcnt++;
                }
                string DOS = e.Row.Cells[11].Text.Trim();
                if (ValidateDate(DOS) == false)
                {
                    e.Row.Cells[11].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[11].ToolTip = "Wrong date format of DOS";
                    errorcnt++;
                }
                else
                {
                    e.Row.Cells[11].Text = DateTime.ParseExact(DOS, "ddMMyyyy", CultureInfo.InvariantCulture).ToString("dd-MMM-yyyy");
                }
                string ReasonforSeperation = e.Row.Cells[12].Text;
                if (ReasonforSeperation == "&nbsp;" || ReasonforSeperation == "")
                {
                    e.Row.Cells[12].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[12].ToolTip = "Please enter Reason for Seperation";
                    errorcnt++;
                }
                string Mobile = e.Row.Cells[13].Text;
                if (Mobile == "&nbsp;" || Mobile == "")
                {
                    e.Row.Cells[13].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[13].ToolTip = "Please enter Mobile";
                    errorcnt++;
                }
                string Email = e.Row.Cells[14].Text;
                if (Email == "&nbsp;" || Email == "")
                {
                    e.Row.Cells[14].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[14].ToolTip = "Please enter Email";
                    errorcnt++;
                }
                string L1Empid = e.Row.Cells[15].Text;
                if (L1Empid == "&nbsp;" || L1Empid == "")
                {
                    e.Row.Cells[15].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[15].ToolTip = "Please enter L1 Empid";
                    errorcnt++;
                }
                string L1Name = e.Row.Cells[16].Text;
                if (L1Name == "&nbsp;" || L1Name == "")
                {
                    e.Row.Cells[16].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[16].ToolTip = "Please enter L1 Name";
                    errorcnt++;
                }
                string L1Mobile = e.Row.Cells[17].Text;
                if (L1Mobile == "&nbsp;" || L1Mobile == "")
                {
                    e.Row.Cells[17].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[17].ToolTip = "Please enter L1 Mobile";
                    errorcnt++;
                }
                string L1Email = e.Row.Cells[18].Text;
                if (L1Email == "&nbsp;" || L1Email == "")
                {
                    e.Row.Cells[18].BackColor = System.Drawing.ColorTranslator.FromHtml("#ff9b44"); ;
                    e.Row.Cells[18].ToolTip = "Please enter L1 Email";
                    errorcnt++;
                }
                txt_errorcnt.Text = errorcnt.ToString();
            }

        }
        catch (Exception er)
        {
        }
    }

    [WebMethod]
    public static IEnumerable bindata(string typ)
    {
        DataSet ds = new DataSet();
        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, "", dtlogin.Rows[0]["user_loginid"].ToString());
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        if (dt1.Rows.Count > 0)
        {
            var result = dt1.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {

            return "1";
        }

    }

    [WebMethod]
    public static IEnumerable UIDGenerationSave(string typ, string reqno, string name, string fname, string dob, string company, string department, string division, string aadhar)
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF("8", reqno, dtlogin.Rows[0]["user_loginid"].ToString(), name, fname, dob, company, department, division, aadhar);
        dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            //DataSet dscandidate = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("101A", "", dtlogin.Rows[0]["user_loginid"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
            //string success = mailservice.mail_service("Brplgis.Helpdesk@relianceada.com", "", "", "Brplgis.Helpdesk@relianceada.com," + dscandidate.Tables[0].Rows[0]["Mail_ID"].ToString(), dscandidate.Tables[0].Rows[0]["MAIL_SUB"].ToString(), dscandidate.Tables[0].Rows[0]["MAIL_BODY"].ToString(), "", "HRMS IT CLEARANCE", "GISMAILSERVICE", "BRPLG!S@DM!N");
            var result = dt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {
            return "1";
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
                    string empid = gv_uploaddata.Rows[gr.RowIndex].Cells[2].Text;
                    string name = gv_uploaddata.Rows[gr.RowIndex].Cells[3].Text;
                    string roles = gv_uploaddata.Rows[gr.RowIndex].Cells[4].Text;
                    string company = gv_uploaddata.Rows[gr.RowIndex].Cells[5].Text;
                    string dob = gv_uploaddata.Rows[gr.RowIndex].Cells[6].Text;
                    string aadhar = gv_uploaddata.Rows[gr.RowIndex].Cells[7].Text;
                    string doj = gv_uploaddata.Rows[gr.RowIndex].Cells[8].Text;
                    string department = gv_uploaddata.Rows[gr.RowIndex].Cells[9].Text;
                    string location = gv_uploaddata.Rows[gr.RowIndex].Cells[10].Text;
                    string dos = gv_uploaddata.Rows[gr.RowIndex].Cells[11].Text;
                    string dosreason = gv_uploaddata.Rows[gr.RowIndex].Cells[12].Text;
                    string mobile = gv_uploaddata.Rows[gr.RowIndex].Cells[13].Text;
                    string email = gv_uploaddata.Rows[gr.RowIndex].Cells[14].Text;
                    string liempid = gv_uploaddata.Rows[gr.RowIndex].Cells[15].Text;
                    string liname = gv_uploaddata.Rows[gr.RowIndex].Cells[16].Text;
                    string limobile = gv_uploaddata.Rows[gr.RowIndex].Cells[17].Text;
                    string liemail = gv_uploaddata.Rows[gr.RowIndex].Cells[18].Text;
                    if (empid != "" || empid != "&nbsp;")
                    {
                        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("101", aadhar, dtlogin.Rows[0]["user_loginid"].ToString(), empid, name, roles, company, dob, aadhar, doj, department, location, dos, dosreason, mobile, email, liempid, liname, limobile, liemail, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
                        cnt++;
                    }
                    else { }
                }
            }
            if (cnt > 0)
            {
                DataSet dscandidate = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("101A", "", dtlogin.Rows[0]["user_loginid"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
                string success = mailservice.mail_service("Brplgis.Helpdesk@relianceada.com", dscandidate.Tables[0].Rows[0]["Mail_ID_to"].ToString(), dscandidate.Tables[0].Rows[0]["Mail_ID_cc"].ToString(), dscandidate.Tables[0].Rows[0]["Mail_ID_bcc"].ToString(), dscandidate.Tables[0].Rows[0]["MAIL_SUB"].ToString(), dscandidate.Tables[0].Rows[0]["MAIL_BODY"].ToString(), "", "HRMS IT CLEARANCE", "GISMAILSERVICE", "BRPLG!S@DM!N");
                DataTable dtclear = new DataTable();
                gv_uploaddata.DataSource = dtclear;
                gv_uploaddata.DataBind();
                string script = "window.onload = function() { left('" + ds.Tables[0].Rows[0]["TXT"].ToString() + "') };";
                ClientScript.RegisterStartupScript(this.GetType(), "left", script, true);
            }
        }
    }
    protected void filedownload_Click(object sender, EventArgs e)
    {
        string filename = "candidatelist.xlsx";
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


    [WebMethod]
    public static IEnumerable checkreqno(string reqno, string type)
    {
        DataTable dt = new DataTable();
        DataSet resultds = new DataSet();
        resultds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF("9", reqno, dtlogin.Rows[0]["user_loginid"].ToString());
        dt = resultds.Tables[0];
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
    public static IEnumerable bindmoredata(string typ, string emp,string name,string fname,string dob)
    {
        DataSet ds = new DataSet();
        ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, emp, dtlogin.Rows[0]["user_loginid"].ToString(), name,fname,dob);
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        if (dt1.Rows.Count > 0)
        {
            var result = dt1.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {

            return "1";
        }

    }

    [WebMethod]
    public static IEnumerable updatedetails(string empcode, string typ, UpdatedRight[] updatedRight)
    {
        DataTable role = new DataTable();
        foreach (UpdatedRight item in updatedRight)
        {
            DataSet ds = new DataSet();
            ds = dbconStatic.Exe_Proc_with_PROC_HRMS_MRF(typ, item.reqno, dtlogin.Rows[0]["user_loginid"].ToString(), item.uidno, item.Name, item.remarks, "", item.cname, item.fname, item.dob, item.validupto, item.uidtype);
            role = ds.Tables[0];
        }
        if (role.Rows.Count > 0)
        {
            var result = role.AsEnumerable().Select(c => new
            {
                MSG_CODE = c["MSG_CODE"],
                TXT = c["TXT"]

            }).ToList();
            return result;
        }
        else
        {
            return "";
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


    public class UpdatedRight
    {
        public string Name { get; set; }
        public string status { get; set; }
        public string remarks { get; set; }
        public string reqno { get; set; }
        public string uidno { get; set; }
        public string cname { get; set; }
        public string fname { get; set; }
        public string dob { get; set; }
        public string validupto{ get; set;}
        public string uidtype { get; set; }
    }
}