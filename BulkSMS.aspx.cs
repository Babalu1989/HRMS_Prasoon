using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Renci.SshNet;
using Renci.SshNet.Sftp;

public partial class Clearance : System.Web.UI.Page
{
    string FileName; 
    string msg = ""; 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {           
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
            }
        }
        catch (Exception er)
        {
        
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
            DataTable dt = new DataTable();
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
            oda.Fill(dt);
            connExcel.Close();
            gv_uploaddata.DataSource = dt;
            gv_uploaddata.DataBind();
            ViewState["gv_uploaddatadirState"] = dt;
        }
        catch (Exception er)
        {         
        }
    }


    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gv_uploaddata.EditIndex = e.NewEditIndex;
        gv_uploaddata.DataSource = ViewState["gv_uploaddatadirState"];
        gv_uploaddata.DataBind();
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = (GridViewRow)gv_uploaddata.Rows[e.RowIndex];
        TextBox sno = (TextBox)row.Cells[1].Controls[0];
        TextBox Mobile = (TextBox)row.Cells[2].Controls[0];
        TextBox Message = (TextBox)row.Cells[3].Controls[0];
        DataTable dt = ViewState["gv_uploaddatadirState"] as DataTable;
        gv_uploaddata.EditIndex = -1;
        dt.Rows[row.RowIndex]["SNo"] = sno.Text;
        dt.Rows[row.RowIndex]["Mobile"] = Mobile.Text;
        dt.Rows[row.RowIndex]["Message"] = Message.Text;

        ViewState["dtnew"] = dt;
        gv_uploaddata.EditIndex = -1;
        gv_uploaddata.DataSource = ViewState["dtnew"];
        gv_uploaddata.DataBind();

    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gv_uploaddata.EditIndex = -1;
        gv_uploaddata.DataSource = ViewState["gv_uploaddatadirState"];
        gv_uploaddata.DataBind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

        string txtFilename = "GISSMSTXT_" + DateTime.Now.ToString("ddMMyyyyHHmmss");
        for (int i = 0; i <= gv_uploaddata.Rows.Count - 1; i++)
        {
            string SNo = gv_uploaddata.Rows[i].Cells[1].Text;
            string Mobile = gv_uploaddata.Rows[i].Cells[2].Text;
            string Message = gv_uploaddata.Rows[i].Cells[3].Text.Replace("@","");

            msg = Mobile + "_12345" + "@" + Mobile + "@" + Message;
            bool exists = System.IO.Directory.Exists(ConfigurationManager.AppSettings["BULKSSMSGIS"].ToString() + DateTime.Now.ToString("ddMMyyyy"));

            if (!exists)
                System.IO.Directory.CreateDirectory(ConfigurationManager.AppSettings["BULKSSMSGIS"].ToString() + DateTime.Now.ToString("ddMMyyyy"));

            using (StreamWriter sw = System.IO.File.AppendText(ConfigurationManager.AppSettings["BULKSSMSGIS"].ToString() + DateTime.Now.ToString("ddMMyyyy") + "\\" + txtFilename + ".txt"))
            {
                sw.WriteLine("\n" + " " + msg);
                sw.Close();
            }

        }
       bool success= SFTP(txtFilename);
       if (success == true)
       {
           DataTable dtclear = new DataTable();
           gv_uploaddata.DataSource = dtclear;
           gv_uploaddata.DataBind();
           string script = "window.onload = function() { left('SMS Sent Successfully!!!') };";
           ClientScript.RegisterStartupScript(this.GetType(), "popup", script, true);
       }
       else {
           string script = "window.onload = function() { left('Please try after sometime') };";
           ClientScript.RegisterStartupScript(this.GetType(), "popup", script, true);
       }

    }

    public static bool SFTP(string Filename)
    {

        bool Status = false;
        try
        {
            string path;
            path = ConfigurationManager.AppSettings["BULKSSMSGIS"].ToString() + DateTime.Now.ToString("ddMMyyyy") + "\\" + Filename + ".txt";
            FileInfo f = new FileInfo(path);
            string uploadfile = f.FullName;
            Console.WriteLine(f.Name);
            Console.WriteLine("uploadfile" + uploadfile);
            //Passing the sftp host without the "sftp://"         
            var client = new SftpClient("103.250.30.21", 22, "bsesonm", "bse1234");
            client.Connect();
            if (client.IsConnected)
            {
                var fileStream = new FileStream(uploadfile, FileMode.Open);
                if (fileStream != null)
                {
                    //If you have a folder located at sftp://ftp.example.com/share
                    //then you can add this like:
                    client.UploadFile(fileStream, "/IN/" + f.Name, null);
                    client.Disconnect();
                    client.Dispose();
                    Status = true;
                }
            }

        }
        catch (Exception Ex)
        {

        }

        return Status;
    }

    protected void filedownload_Click(object sender, EventArgs e)
    {
        string filename = "SMSFormat.xlsx";
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

}