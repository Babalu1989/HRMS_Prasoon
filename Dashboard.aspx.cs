using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Dashboard : System.Web.UI.Page
{
    public static DBCONNECTION dbconStatic = new DBCONNECTION();
    public  DBCONNECTION dbcon = new DBCONNECTION();
    static DataSet ds = new DataSet();
    string value;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            ds = dbcon.Select_data_indataset("select emp_nm,(select division_name from TBL_DIVISION_MASTER where division_code = a.div) as div from emp_master a where dob is not null and to_char(to_date(dob,'dd-Mon-rr'),'dd-mm') = to_char(trunc(sysdate),'dd-mm') order by div desc");

            for (int i = 0; i <= ds.Tables[0].Rows.Count - 1; i++)
            {
                value = ds.Tables[0].Rows[i]["emp_nm"].ToString().Trim() + " (" + ds.Tables[0].Rows[i]["div"].ToString().Trim() + "), " + value;
            }
            value = value.Substring(0, (value.Length - 2));

            lbl_birth.Text = "Today's birthday : " + value;
            lbl_birth.ForeColor = System.Drawing.Color.OrangeRed;

            if (!Page.IsPostBack)
            {
                getdata();
            }
        }
        catch (Exception er)
        {

        }

    }

    public void getdata() 
    {
        ds = dbcon.Exe_proc_proc_deduping_hrms("Graph", "2");
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];
        lbl_auhtnenticate.Text = dt1.Rows[0]["CNT"].ToString();
        lbl_notauthenticate.Text = dt1.Rows[2]["CNT"].ToString();
        lbl_vendor.Text = dt1.Rows[3]["CNT"].ToString();
        lbl_employee.Text = dt1.Rows[1]["CNT"].ToString();

    }


    [WebMethod]
    public static IEnumerable getvendormethod(string typ)
    {
        ds = dbconStatic.Exe_proc_proc_deduping_hrms("Graph", typ);
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
    public static IEnumerable getageing(string typ)
    {
        ds = dbconStatic.Exe_proc_proc_deduping_hrms("Graph", typ);
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
    public static IEnumerable divionwisevendordata(string typ)
    {
        ds = dbconStatic.Exe_proc_proc_deduping_hrms("Graph", typ);
        DataTable dt1 = new DataTable();
        dt1 = ds.Tables[0];

        if (dt1.Rows.Count > 0)
        {
            var data = dt1.AsEnumerable().Select(c => new
            {
                VENDOR_NAME = c["VENDOR_NAME"],
                COLOR = c["COLOR"],
                DIV_CODE = c["DIV_CODE"],
                CNT = c["CNT"],
            }).ToList();

            //var d = string.Join(data.Select(k => k.CNT.ToString()).ToList(), ",");

            //List<string> ls = new List<string>();
            //ls.Add("ss");
            //var dss = string.Join(",",ls).Split(",");

            //var SelectedValues = dt.AsEnumerable().Select(s => s.Field<string>("Division_C")).ToArray();
            //divlist = "'" + string.Join("','", SelectedValues) + "'";

            //var dd= string.Join(",", data.Where(k=>k.VENDOR_NAME.ToString()=="").Select(c=>c.CNT).ToArray()).Split(',');

            //var ss = data.FirstOrDefault(c => c.VENDOR_NAME.ToString() == "").COLOR;
            var div_Code = string.Join(",", data.GroupBy(k=>k.DIV_CODE).Select(c => c.Key.ToString()).ToList());

            var result = data.GroupBy(d => d.VENDOR_NAME).Select(c => new item()
            {
            label=c.Key.ToString(),
            data = string.Join(",", data.Where(k=>k.VENDOR_NAME.ToString()==c.Key.ToString()).Select(z=>z.CNT).ToArray()).Split(','),
            backgroundColor = data.FirstOrDefault(d => d.VENDOR_NAME.ToString() == c.Key.ToString()).COLOR.ToString(),
            Div_code = div_Code
            }).ToList();


          //  var result = res.ToDataSetToJSON();

            //{
            //                            label: labelDt[j].VENDOR_NAME,
            //                            data: dataDT,
            //                            backgroundColor: labelDt[j].COLOR,
            //                            // hoverBackgroundColor: "#7E57C2",
            //                            hoverBorderWidth: 0
            //                        }


            return result;
        }
        else
        {

            return "1";
        }
    }
    public class item
    {
        public string label { get; set; }
        public string[] data { get; set; }
        public string  backgroundColor { get; set; }
        public string hoverBorderWidth { get; set; }
        public string Div_code { get; set; }
    }
    public class ItemResult
    {
        public DataTable  data { get; set; }
        public List<item> itemList { get; set; }
    }
}