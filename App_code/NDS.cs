using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data.OleDb;
using System.Text;

public class NDS
{
    // ASSING KEY TO CONNECT DATABASE.
    //private static string PW_KEY = "@KILLBILL" /*"@!*fdfsfd+}|@"*/;

    private static string BaseUrl = AppDomain.CurrentDomain.BaseDirectory;   
    private static string INI_DBUSERID = System.Configuration.ConfigurationManager.AppSettings["INI_DBUSERID"].ToString();
    private static string INI_DBPWD = System.Configuration.ConfigurationManager.AppSettings["INI_DBPWD"].ToString();
    private static string INI_DBCONNECTION = System.Configuration.ConfigurationManager.AppSettings["INI_DBCONNECTION"].ToString();
    public NDS()
    {

    }


    public static bool IsNumeric(object value)
    {
        try
        {
            Double i = Convert.ToDouble(value.ToString());
            return true;
        }
        catch (FormatException)
        {
            return false;
        }
    }

    public static void ClearControls(Control control)
    {
        for (int i = control.Controls.Count - 1; i >= 0; i--)
        {
            ClearControls(control.Controls[i]);
        }

        if (!(control is TableCell))
        {
            if (control.GetType().GetProperty("SelectedItem") != null)
            {
                LiteralControl literal = new LiteralControl();
                control.Parent.Controls.Add(literal);
                try
                {
                    literal.Text = (string)control.GetType().GetProperty("SelectedItem").GetValue(control, null);
                }
                catch
                {
                }
                control.Parent.Controls.Remove(control);
            }
            else
                if (control.GetType().GetProperty("Text") != null)
            {
                LiteralControl literal = new LiteralControl();
                control.Parent.Controls.Add(literal);
                literal.Text = (string)control.GetType().GetProperty("Text").GetValue(control, null);
                control.Parent.Controls.Remove(control);
            }
        }
        return;
    }

    public static string Connection()
    {
        try
        {
           Cryptograph crp = new Cryptograph();
           HttpServerUtility myServer = HttpContext.Current.Server;
            string FilePath = BaseUrl + System.Configuration.ConfigurationManager.AppSettings["INI_FILEPATH_1"].ToString();
            string sDBName = System.Configuration.ConfigurationManager.AppSettings["INI_DBNAME_1"].ToString();
            string PW_KEY = System.Configuration.ConfigurationManager.AppSettings["INI_PASSWORD"].ToString();
            string UserId = crp.Decrypt(NDSINI.GetINI(FilePath, sDBName, crp.Encrypt(INI_DBUSERID, PW_KEY), "?"), PW_KEY);
            string PWD = crp.Decrypt(NDSINI.GetINI(FilePath, sDBName, crp.Encrypt(INI_DBPWD, PW_KEY), "?"), PW_KEY);
            string DataBase = crp.Decrypt(NDSINI.GetINI(FilePath, sDBName, crp.Encrypt(INI_DBCONNECTION, PW_KEY), "?"), PW_KEY);
           return ("User ID=" + UserId + "; Password=" + PWD + "; Data Source=" + DataBase + ";");
           // return System.Configuration.ConfigurationManager.ConnectionStrings["connection"].ToString();
        }
        catch (Exception ex)
        {
            throw;
        }
    }
   
}




