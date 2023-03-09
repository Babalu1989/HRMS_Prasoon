using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class empdt : System.Web.UI.Page
{    
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public  DBCONNECTION dbcon = new DBCONNECTION();
    static DataSet ds = new DataSet();
    static DataTable dtlogin = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            dtlogin = Session["fetchlogindetails"] as DataTable;
            if (dtlogin.Rows.Count > 0)
            {
                if (!Page.IsPostBack)
                {
                    DataSet ds = new DataSet();
                    DataTable dt = new DataTable();
                    ds = dbcon.Exe_proc_hrms_fill_data("DDL", "1", "", "", "", "", "");
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        DataTable dtven = new DataTable();
                        dt.DefaultView.RowFilter = "TXT ='VENDOR'";
                        dtven = (dt.DefaultView).ToTable();
                        dbcon.FillDDLwithdt1(ddl_venaddnew, dtven);

                        DataTable dtdept = new DataTable();
                        dt.DefaultView.RowFilter = "TXT ='DEPT'";
                        dtdept = (dt.DefaultView).ToTable();
                        dbcon.FillDDLwithdt1(ddl_deptaddnew, dtdept);
                        dbcon.FillDDLwithdt1(ddl_profileinfodepartment, dtdept);

                        DataTable dtdesg = new DataTable();
                        dt.DefaultView.RowFilter = "TXT ='DESG'";
                        dtdesg = (dt.DefaultView).ToTable();
                        dbcon.FillDDLwithdt1(ddl_desgaddnew, dtdesg);
                        dbcon.FillDDLwithdt1(ddl_profileinfodesignation, dtdesg);

                        DataTable dtdiv = new DataTable();
                        dt.DefaultView.RowFilter = "TXT ='DIV'";
                        dtdiv = (dt.DefaultView).ToTable();
                        dbcon.FillDDLwithdt1(ddl_divaddnew, dtdiv);
                        dbcon.FillDDLwithdt1(profilemodaldivision, dtdiv);

                        DataTable dtstate = new DataTable();
                        dt.DefaultView.RowFilter = "TXT ='STATE'";
                        dtstate = (dt.DefaultView).ToTable();
                        dbcon.FillDDLwithdt1(ddl_stateaddnew, dtstate);
                        dbcon.FillDDLwithdt1(profilemodalstate, dtstate);
                        dbcon.FillDDLwithdt1(profilemodalpermanentstate, dtstate);

                        DataTable dtL1 = new DataTable();
                        dt.DefaultView.RowFilter = "TXT ='L1'";
                        dtL1 = (dt.DefaultView).ToTable();
                        dbcon.FillDDLwithdt1(ddl_profileinforeport, dtL1); 
                        dbcon.FillDDLwithdt1(ddl_reportingaddnewmodal, dtL1);

                        DataTable dtempstatus = new DataTable();
                        dt.DefaultView.RowFilter = "TXT ='EMPSTATUS'";
                        dtempstatus = (dt.DefaultView).ToTable();
                        dbcon.FillDDLwithdt1(ddl_terminationtype, dtempstatus);

                        DataTable dtddl_noj = new DataTable();
                        dt.DefaultView.RowFilter = "TXT ='NATJOB'";
                        dtddl_noj = (dt.DefaultView).ToTable();
                        dbcon.FillDDLwithdt1(personal_info_modal_ddl_noj, dtddl_noj);
                        dbcon.FillDDLwithdt1(ddl_nojaddnewmodal, dtddl_noj);

                        DataTable dtddl_vendor = new DataTable();
                        dt.DefaultView.RowFilter = "TXT ='VENDOR'";
                        dtddl_vendor = (dt.DefaultView).ToTable();
                        dbcon.FillDDLwithdt1(personal_info_modal_ddl_vendor, dtddl_vendor);

                        DataTable dtddl_document = new DataTable();
                        dt.DefaultView.RowFilter = "TXT ='DOC'";
                        dtddl_document = (dt.DefaultView).ToTable();
                        dbcon.FillDDLwithdt1(ddl_doctype, dtddl_document);

                    }
                }
            }
            else {
                Response.Redirect("Login");
            }
        }
        catch (Exception er)
        {
            Response.Redirect("Login");
        }
    }
    [WebMethod]
    public static IEnumerable bindata(string typ)
    {
        ds = dbconStatic.Exe_proc_emp_search("", typ);
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        dt1.Columns.Add("#", typeof(System.String));

        foreach (DataRow row in dt1.Rows)
        {
            //need to set value to NewColumn column
            row["#"] = "<div class='dropdown dropdown-action'><a href='#' class='action-icon dropdown-toggle' data-toggle='dropdown' aria-expanded='false'><i class='material-icons'>more_vert</i></a><div class='dropdown-menu dropdown-menu-right'><a class='dropdown-item'  href='javascript:void(0)' onclick=\"edit_employee('" + row["aadhar"].ToString() + "," + row["Emp.Name"].ToString() + "," + row["Status_CD"].ToString() + "');\"><i class='fa fa-pencil m-r-5'></i>Edit</a></div></div>";   // or set it to some other value   <a class='dropdown-item' href='#' data-toggle='modal' data-target='#delete_employee'><i class='fa fa-trash-o m-r-5'></i>Delete</a>
        }
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
    public static IEnumerable bindatasalary(string typ, string aadhar)
    {
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, aadhar, dtlogin.Rows[0]["user_loginid"].ToString(), "","", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
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
    public static IEnumerable binalldata(string typ ,string aadhar)
    {
        ds = dbconStatic.Exe_proc_emp_search(aadhar, typ);
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];       
        if (dt1.Rows.Count > 0)
        {
            var result1 = ds.GetJSON();
          //  var result = dt1.ToDataSetToJSON();
            var temp = result1.Length;//500000000
            return result1;
        }
        else
        {

            return "1";
        }

    }


    [WebMethod]
    public static IEnumerable getadata(string typ,string ddlvalue)
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
    public static IEnumerable employeeterminate(string typ, string aadhar,string status,string lastdate,string reason)
    {

        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, aadhar, dtlogin.Rows[0]["user_loginid"].ToString(), status, reason, lastdate, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
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
    public static IEnumerable employeefamily(string typ, string aadhar, string name, string relation, string dob, string phone, string srno, string ty)
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, aadhar, dtlogin.Rows[0]["user_loginid"].ToString(), name, relation, dob, phone, srno, "", "", "", "", ty, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
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
    public static IEnumerable contract_update(string typ, string aadhar, string mode, string from, string to)
    {

        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, aadhar, dtlogin.Rows[0]["user_loginid"].ToString(), mode, from, to, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
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
    public static IEnumerable other_update(string typ, string aadhar, string uan, string emergencycontact, string categorywage, string subcategorywage)
    {
        if (categorywage == "Special")
        {
            subcategorywage = "";
        }
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, aadhar, dtlogin.Rows[0]["user_loginid"].ToString(), uan, emergencycontact, categorywage, subcategorywage, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
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
    public static IEnumerable employeepersonalinfo(string typ, string aadhar, string ano, string fathername, string esic, string voterid, string noj, string vendor)
    {

        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
       ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, aadhar, dtlogin.Rows[0]["user_loginid"].ToString(), ano,fathername,esic,voterid,noj,vendor, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
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
    public static IEnumerable employeebanksave(string typ, string aadhar, string modalbankname, string modalaccountno, string modalifsc, string modalpanno, string modalmicr, string modalpf)
    {

        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, aadhar, dtlogin.Rows[0]["user_loginid"].ToString(), modalbankname, modalaccountno, modalifsc, modalpanno, modalmicr, modalpf, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
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
    public static IEnumerable updateeducation(string empcode, string updationuser, updatededucation[] updatededucation)
    {
        DataSet resultds = new DataSet();
        DataTable resultdt = new DataTable();      
        foreach (updatededucation item in updatededucation)
        {
            resultds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("1E", updationuser, dtlogin.Rows[0]["user_loginid"].ToString(), item.Institute.Trim(), item.Subject.Trim(), item.startingdate.Trim(), item.completiondate.Trim(), item.degree.Trim(), item.grade.Trim(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
            resultdt = resultds.Tables[0];

        }
        if (resultdt.Rows.Count > 0)
        {
            var result = resultdt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {
            return "1";
        }
       
    }
  [WebMethod]
    public static IEnumerable updateexperiencemethod(string empcode, string updationuser, updateexperience[] updateexperience)
    {
        DataSet resultds = new DataSet();
        DataTable resultdt = new DataTable();    
        foreach (updateexperience item in updateexperience)
        {
            resultds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("1F", updationuser, dtlogin.Rows[0]["user_loginid"].ToString(), item.company.Trim(), item.location.Trim(), item.position.Trim(), item.startingdate.Trim(), item.completiondate.Trim(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
            resultdt = resultds.Tables[0];

        }
        if (resultdt.Rows.Count > 0)
        {
            var result = resultdt.ToDataSetToJSON();
            var temp = result.Length;//500000000
            return result;
        }
        else
        {
            return "1";
        }
    }

  [WebMethod]
  public static IEnumerable checkbrpluid(string empcode,string type)
  {
      DataSet resultds = new DataSet();
      resultds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(type, empcode, dtlogin.Rows[0]["user_loginid"].ToString(), "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
      var result = resultds.GetJSON();
       var temp = result.Length;//500000000
       return result;
      
  }

  [WebMethod]
  public static IEnumerable salarydata(string dropdown, string type)
  {
      DataSet resultds = new DataSet();
      resultds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(type, "", dtlogin.Rows[0]["user_loginid"].ToString(), dropdown, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
      var result = resultds.GetJSON();
      var temp = result.Length;//500000000
      return result;

  }


  [WebMethod]
  public static IEnumerable data(string aadhar)
  {
      ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG("14", aadhar, dtlogin.Rows[0]["user_loginid"].ToString(), "", "","","","","","","","","","","","","","","","","","","", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
      DataTable dt1 = new DataTable();
      dt1 = ds.Tables[0];
      var result = dt1.AsEnumerable().Select(c => new { SR_NO = c["#"], file_id = c["file_id"], TXT = c["TXT"] }).ToList();
      return result;
  }

  [WebMethod]
  public static IEnumerable employeesalarysave(string typ, string aadhar, string wages, string subwages, string basic, string hra, string otherallowance, string gross, string pf, string esic, string bonus, string leave, string insurance, string statuaory, string agency, string totalpermonth, string costperannum, string gpa, string totalcost, string totalcostgst, string mobile, string Conveyance)
  {

      DataSet ds = new DataSet();
      DataTable dt = new DataTable();
      ds = dbconStatic.Exe_Proc_with_PROC_EMP_MASTER_MNG(typ, aadhar, dtlogin.Rows[0]["user_loginid"].ToString(),wages,subwages,basic,hra,otherallowance,gross,pf, esic,bonus,leave,insurance,statuaory,agency,totalpermonth,costperannum,gpa,totalcost,totalcostgst,Conveyance,mobile, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
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


    public class updatededucation
    {
        public string Institute { get; set; }
        public string Subject { get; set; }
        public string startingdate { get; set; }
        public string completiondate { get; set; }
        public string degree { get; set; }
        public string grade { get; set; }        
    }

    public class updateexperience
    {
        public string company { get; set; }
        public string location { get; set; }
        public string position { get; set; }
        public string startingdate { get; set; }
        public string completiondate { get; set; }       
    }


}