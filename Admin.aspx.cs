using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.OracleClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin : System.Web.UI.Page
{
    static DataTable dtlogin = new DataTable();  
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public DBCONNECTION dbcon = new DBCONNECTION();
    static DataSet ds = new DataSet();    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                dtlogin = Session["fetchlogindetails"] as DataTable;
                bindtree();
            }
            catch (Exception er)
            { Response.Redirect("login"); }
        }
    }

    void bindtree()
    {
        ds = dbcon.Exe_Proc_with_PROC_EMP_MASTER_MNG("9", "", dtlogin.Rows[0]["USER_LOGINID"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        DataTable dt = new DataTable();
        dt = ds.Tables[0]; 
        int count = 0;
        string[,] ParentNode = new string[100, 2];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            ParentNode[count, 0] = dt.Rows[i]["MENUID"].ToString();
            ParentNode[count++, 1] = dt.Rows[i]["MENU_NAME"].ToString();
        }
        for (int loop = 0; loop < count; loop++)
        {
            TreeNode root = new TreeNode();
            DataTable dtchild = new DataTable();
            root.Text = ParentNode[loop, 1];
            root.Value = ParentNode[loop, 0];
            ds = dbcon.Exe_Proc_with_PROC_EMP_MASTER_MNG("9A", "", dtlogin.Rows[0]["USER_LOGINID"].ToString(), ParentNode[loop, 0], "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");         
            dtchild = ds.Tables[0];

            for (int k = 0; k < dtchild.Rows.Count; k++)
            {
                TreeNode child = new TreeNode();
                child.Value = dtchild.Rows[k]["MENUID"].ToString();
                child.Text = dtchild.Rows[k]["MENU_NAME"].ToString();
                root.ChildNodes.Add(child);
            }
            TreeView1.Nodes.Add(root);
        }
    }

    [WebMethod]
    public static IEnumerable rolesearch(string empcode)
    {        
        DataTable dt = new DataTable();     
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("9B", "", dtlogin.Rows[0]["USER_LOGINID"].ToString(), empcode, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
        dt = ds.Tables[0];
        if (dt.Rows[0]["MSG_CODE"].ToString() == "0")
        {

            DataTable role = new DataTable();           
            ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("9C", "", dtlogin.Rows[0]["USER_LOGINID"].ToString(), empcode, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
            role = ds.Tables[0];

            var result = dt.AsEnumerable().Select(c => new
            {
                EMPNAME = c["Employee Name"],  
                EmployeeID = c["Employee ID"],
                Role = role.AsEnumerable().Select(f => new
                {
                    SUBMENU = f["SUB-MENU"],
                    SUBMENUID = f["MENUID"],
                    PARENTMENU = f["PARENT MENU"],
                }).ToList(),

            }).ToList();
            return result;
        }
        else
        {
            var result = dt.AsEnumerable().Select(c => new
            {
                TXT = c["TXT"]

            }).ToList();
            return result;
        }
    }

    [WebMethod]
    public static IEnumerable updaterole(string empcode, string updationuser, UpdatedRight[] updatedRight)
    {
        DataTable role = new DataTable();        
        foreach (UpdatedRight item in updatedRight)
        {
            ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("9D", "", dtlogin.Rows[0]["USER_LOGINID"].ToString(), empcode, item.SubmenuId, dtlogin.Rows[0]["USER_LOGINID"].ToString(), item.Status, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");          
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
    public class UpdatedRight
    {
        public string Status { get; set; }
        public string SubmenuId { get; set; }
    }

}