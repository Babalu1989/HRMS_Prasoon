using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections;
using System.Data.OracleClient;
using System.Net.Mail;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Web.Script.Serialization;
using System.IO;
using System.Diagnostics;
using aejw.Network;

/// <summary>
/// Summary description for DBCONNECTION
/// </summary>
public class DBCONNECTION
{
   // string constring = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["connection"].ConnectionString.ToString();
   string constring = NDS.Connection();

    OracleConnection OC;
    OracleTransaction dbtrans;
    OracleCommand OD;
    public DBCONNECTION()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool UpdateDb(string command)
    {

       OC = new OracleConnection(constring);       
        OD = new OracleCommand(command, OC); ;

        int int_result = 0;
        bool bl_result = false;

        OC.Open();
        int_result = OD.ExecuteNonQuery();
        OC.Close();
        if (int_result > 0)
        {
            return
               bl_result = true;
        }
        else
        { bl_result = false; }

        return bl_result;
    }
    public void Execute_without_Parameter_Proc(string proc_name)
    {
        OD = new OracleCommand(proc_name, OC);
        OD.CommandType = CommandType.StoredProcedure;
        OC.Open();
        OD.ExecuteNonQuery();
        OC.Close();
        
    }

    public System.Data.DataSet Select_data_indataset(string Sql_command)
    {
        
        System.Data.DataSet DS = new System.Data.DataSet();
        try
        {
            OracleConnection OC = new OracleConnection(constring);
            OracleDataAdapter OA = new OracleDataAdapter(Sql_command, OC);
            OA.Fill(DS);        
        }
        catch (OracleException oex)
        {
            throw (oex);
        }
        catch (Exception ex)
        {
            throw (ex);
        }        
        return DS;
    }


    

    //select single value

    public Int32 select_single_value(string str_command)
    {

        System.Data.DataSet DS = new System.Data.DataSet();
        Int32 count;
        try
        {
            OracleConnection OC = new OracleConnection(constring);
            OracleCommand OD = new OracleCommand(str_command, OC);
            OD.CommandType = CommandType.Text;


            OC.Open();

            count = Convert.ToInt32(OD.ExecuteScalar());
            OD.Dispose();

            OC.Close();
        }
        catch (OracleException oex)
        {
            count = -1;
        }
        catch (Exception ex)
        {
            count = -1;
        }
        return count;
    }

    


    //To Clear all the text boxes of the page
    public void ClearInputs(ControlCollection ctrls)
    {
        foreach (Control ctrl in ctrls)
        {
            if (ctrl is TextBox)
                ((TextBox)ctrl).Text = string.Empty;

            ClearInputs(ctrl.Controls);
        }
    }

    //This function is used to fill Dropdown list 
    public void FillDDL(DropDownList DDL, string str_query)
    {
        try
        {
            System.Data.DataSet DS = new System.Data.DataSet();
            DS = Select_data_indataset(str_query);
            DDL.DataSource = DS;
            DDL.DataTextField = DS.Tables[0].Columns[0].ToString();
            DDL.DataValueField = DS.Tables[0].Columns[1].ToString();
            DDL.DataBind();
            DDL.Items.Insert(0, new ListItem("--Select--", "0"));
            //Middle_Layer.AddToolTip_DropDown(DDL);

        }
        catch (Exception ex)
        {

            throw (ex);

        }
    }

    //This function is used to fill Dropdown list 
    public void FillDDLwithonecolumn(DropDownList DDL, string str_query)
    {
        try
        {
            System.Data.DataSet DS = new System.Data.DataSet();
            DS = Select_data_indataset(str_query);
            DDL.DataSource = DS;
            DDL.DataTextField = DS.Tables[0].Columns[0].ToString();
            DDL.DataValueField = DS.Tables[0].Columns[0].ToString();
            DDL.DataBind();
            DDL.Items.Insert(0, new ListItem("--Select--", "0"));
            //Middle_Layer.AddToolTip_DropDown(DDL);

        }
        catch (Exception ex)
        {

            throw (ex);

        }
    }

    public void FillDDL_without(DropDownList DDL, string str_query)
    {
        try
        {
            System.Data.DataSet DS = new System.Data.DataSet();
            DS = Select_data_indataset(str_query);
            DDL.DataSource = DS;
            DDL.DataTextField = DS.Tables[0].Columns[0].ToString();
            DDL.DataValueField = DS.Tables[0].Columns[1].ToString();
            DDL.DataBind();
            //DDL.Items.Insert(0, new ListItem("--Select--", "0"));
            //Middle_Layer.AddToolTip_DropDown(DDL);

        }
        catch (Exception ex)
        {

            throw (ex);

        }
    }

   

    public void FillDDLwithdt(DropDownList DDL, DataTable  dt)
    {
        try
        {

            DDL.DataSource = dt;
            DDL.DataTextField = dt.Columns[0].ToString();
            DDL.DataValueField = dt.Columns[0].ToString();
            DDL.DataBind();
         //   DDL.Items.Insert(0, new ListItem("--Select--", "0"));
            //Middle_Layer.AddToolTip_DropDown(DDL);

        }
        catch (Exception ex)
        {

            throw (ex);

        }
    }

    public void FillDDLwithdtmat(DropDownList DDL, DataTable dt)
    {
        try
        {

            DDL.DataSource = dt;
            DDL.DataTextField = dt.Columns[0].ToString();
            DDL.DataValueField = dt.Columns[1].ToString();
            DDL.DataBind();
           // DDL.Items.Insert(0, new ListItem("--Select--", "0"));
            //Middle_Layer.AddToolTip_DropDown(DDL);

        }
        catch (Exception ex)
        {

            throw (ex);

        }
    }
    public void FillDDLwithoutdtmat(DropDownList DDL, DataTable dt)
    {
        try
        {

            DDL.DataSource = dt;
            DDL.DataTextField = dt.Columns[0].ToString();
            DDL.DataValueField = dt.Columns[1].ToString();
            DDL.DataBind();
         //   DDL.Items.Insert(0, new ListItem("--Select--", "0"));
            //Middle_Layer.AddToolTip_DropDown(DDL);

        }
        catch (Exception ex)
        {

            throw (ex);

        }
    }

    public void FillDDLwithoutselect(DropDownList DDL, DataTable dt)
    {
        try
        {

            DDL.DataSource = dt;
            DDL.DataTextField = dt.Columns[0].ToString();
            DDL.DataValueField = dt.Columns[1].ToString();
            DDL.DataBind();
            DDL.Items.Insert(0, new ListItem("All", "0"));
          
            //Middle_Layer.AddToolTip_DropDown(DDL);

        }
        catch (Exception ex)
        {

            throw (ex);

        }
    }


    public void FillDDLwithdt1(DropDownList DDL, DataTable dt)
    {
        try
        {

            DDL.DataSource = dt;
            DDL.DataTextField = dt.Columns[0].ToString();
            DDL.DataValueField = dt.Columns[1].ToString();
            DDL.DataBind();
            DDL.Items.Insert(0, new ListItem("--Select--", "0"));
            //Middle_Layer.AddToolTip_DropDown(DDL);

        }
        catch (Exception ex)
        {

            throw (ex);

        }
    }

    public void FillDDLwithdt1termination(DropDownList DDL, DataTable dt)
    {
        try
        {

            DDL.DataSource = dt;
            DDL.DataTextField = dt.Columns[0].ToString();
            DDL.DataValueField = dt.Columns[1].ToString();
            DDL.DataBind();
            DDL.Items.Insert(0, new ListItem("--Select--", "4"));
            //Middle_Layer.AddToolTip_DropDown(DDL);

        }
        catch (Exception ex)
        {

            throw (ex);

        }
    }
    public void FillDDL1(DropDownList DDL, string str_query)
    {
        try
        {
            System.Data.DataSet DS = new System.Data.DataSet();
            DS = Select_data_indataset(str_query);
            DDL.DataSource = DS;
            DDL.DataTextField = DS.Tables[0].Columns[0].ToString();
            DDL.DataValueField = DS.Tables[0].Columns[1].ToString();
            DDL.DataBind();
            DDL.Items.Insert(0, new ListItem("--Select--", "--Select--"));
            DDL.Items.Insert(1, new ListItem("Others", "Others"));
            //Middle_Layer.AddToolTip_DropDown(DDL);

        }
        catch (Exception ex)
        {

            throw (ex);

        }


    }

    public void FillDDL_with_DT(DropDownList DDL, System.Data.DataTable DT)
    {
        try
        {
            DDL.DataSource = DT;
            DDL.DataTextField = DT.Columns[0].ToString();
            DDL.DataValueField = DT.Columns[1].ToString();
            DDL.ToolTip = DT.Columns[0].ToString();
            DDL.DataBind();
            DDL.Items.Insert(0, new ListItem("--Select--", "0"));
            //Middle_Layer.AddToolTip_DropDown(DDL);

        }
        catch (Exception ex)
        {

            throw (ex);

        }


    }



    public void FillLB( ListBox lb  , string str_query)
    {
        try
        {
            System.Data.DataSet DS = new System.Data.DataSet();
            DS = Select_data_indataset(str_query);
            lb.DataSource = DS;
            lb.DataTextField = DS.Tables[0].Columns[0].ToString();
            lb.DataValueField = DS.Tables[0].Columns[1].ToString();
            lb.DataBind();


        }
        catch (Exception ex)
        {

            throw (ex);
        }


    }


    public DataSet Exe_Proc_with_refcur(string proc_name, OracleCommand OD)
    {
        DataSet DS = new DataSet();
        OracleConnection OC = new OracleConnection(constring);
        OD.CommandText = proc_name;
        OD.Connection = OC;
        OD.CommandType = CommandType.StoredProcedure;
        OracleDataAdapter ODA = new OracleDataAdapter(OD);
        ODA.Fill(DS);
        return DS;
    }

   
    public void Exe_Proc_with_Parameter(string proc_name, OracleCommand OD)
    {

         OC = new OracleConnection(constring);
        OD.CommandText = proc_name;
        OD.Connection = OC;
        OD.CommandType = CommandType.StoredProcedure;
        OC.Open();
        OD.ExecuteNonQuery();
        OC.Close();


    }

    

    public bool update_with_param( OracleCommand OD)
    {

        OC = new OracleConnection(constring);
       OD.Connection = OC;
        OD.CommandType = CommandType.Text;

        int int_result = 0;
        bool bl_result = false;

        OC.Open();
        int_result = OD.ExecuteNonQuery();
        OC.Close();
        if (int_result > 0)
        {
            return
               bl_result = true;
        }
        else
        { bl_result = false; }

        return bl_result;


    }    

    

    public DataTable dt_ACTIVITYTYPE(string ACTTYPE)
    {
        OC = new OracleConnection(constring);
        if (OC.State == ConnectionState.Closed)
            OC.Open();
        DataTable dt = new DataTable();
        OracleDataAdapter da = new OracleDataAdapter("select WTYPE,IDS  from DTC_EX_CAP where WCAT='" + ACTTYPE + "'", OC);
        da.Fill(dt);
        OC.Close();
        return dt;

    }

    public DataTable GetDataTableFromJsonString(string json)
    {
        var jsonLinq = JObject.Parse(json);

        // Find the first array using Linq
        var srcArray = jsonLinq.Descendants().Where(d => d is JArray).First();
        var trgArray = new JArray();
        foreach (JObject row in srcArray.Children<JObject>())
        {
            var cleanRow = new JObject();
            foreach (JProperty column in row.Properties())
            {
                // Only include JValue types
                if (column.Value is JValue)
                {
                    cleanRow.Add(column.Name, column.Value);
                }
            }
            trgArray.Add(cleanRow);
        }

        return JsonConvert.DeserializeObject<DataTable>(trgArray.ToString());
    }


    public bool dmlsinglequery1(string sql)
    {

        using (OracleConnection ocon = new OracleConnection(constring))
        {
            try
            {
                if (ocon.State == ConnectionState.Closed)
                {
                    ocon.Open();
                }
                OD = new OracleCommand(sql, ocon);
                OD.Transaction = dbtrans;
                OD.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            { throw ex; }
        }
    }


    public string DataSetToJSON(DataTable dt)
    {
        List<Dictionary<string, object>> dict = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        foreach (DataRow dr in dt.Rows)
        {
            row = new Dictionary<string, object>();

            foreach (DataColumn col in dt.Columns)
            {
                row.Add(col.ColumnName, dr[col]);
            }
            dict.Add(row);
        }
        JavaScriptSerializer json = new JavaScriptSerializer();
        json.MaxJsonLength = Int32.MaxValue;
        return json.Serialize(dict);
    }


    public DataSet Exe_Proc_with_param_refcur(string proc_name, string typ, string cano, string refno, string insrtby, string text1, string text2, string text3, string text4, string text5, string text6, string text7, string text8, string text9, string text10, string text11, string text12, string text13, string text14, string text15)
    {
        OC = new OracleConnection(constring);
        DataSet ds = new DataSet();
        OracleDataAdapter oradpdb1 = new OracleDataAdapter(proc_name, OC);
        oradpdb1.SelectCommand.Parameters.Add("p_typ", OracleType.VarChar).Value = typ;
        oradpdb1.SelectCommand.Parameters.Add("p_refno", OracleType.VarChar).Value = refno;
        oradpdb1.SelectCommand.Parameters.Add("p_cano", OracleType.VarChar).Value = cano;
        oradpdb1.SelectCommand.Parameters.Add("p_text1", OracleType.VarChar).Value = text1;
        oradpdb1.SelectCommand.Parameters.Add("p_text2", OracleType.VarChar).Value = text2;
        oradpdb1.SelectCommand.Parameters.Add("p_text3", OracleType.VarChar).Value = text3;
        oradpdb1.SelectCommand.Parameters.Add("p_text4", OracleType.VarChar).Value = text4;
        oradpdb1.SelectCommand.Parameters.Add("p_text5", OracleType.VarChar).Value = text5;
        oradpdb1.SelectCommand.Parameters.Add("p_text6", OracleType.VarChar).Value = text6;
        oradpdb1.SelectCommand.Parameters.Add("p_text7", OracleType.VarChar).Value = text7;
        oradpdb1.SelectCommand.Parameters.Add("p_text8", OracleType.VarChar).Value = text8;
        oradpdb1.SelectCommand.Parameters.Add("p_text9", OracleType.VarChar).Value = text9;
        oradpdb1.SelectCommand.Parameters.Add("p_text10", OracleType.VarChar).Value = text10;
        oradpdb1.SelectCommand.Parameters.Add("p_text11", OracleType.VarChar).Value = text11;
        oradpdb1.SelectCommand.Parameters.Add("p_text12", OracleType.VarChar).Value = text12;
        oradpdb1.SelectCommand.Parameters.Add("p_text13", OracleType.VarChar).Value = text13;
        oradpdb1.SelectCommand.Parameters.Add("p_text14", OracleType.VarChar).Value = text14;
        oradpdb1.SelectCommand.Parameters.Add("p_text15", OracleType.VarChar).Value = text15;
        oradpdb1.SelectCommand.Parameters.Add("p_insrtby", OracleType.VarChar).Value = insrtby;
        oradpdb1.SelectCommand.CommandType = CommandType.StoredProcedure;
        oradpdb1.SelectCommand.Parameters.Add("v_refcur", OracleType.Cursor).Direction = ParameterDirection.Output;
        oradpdb1.Fill(ds);
        return ds;
    }

    public DataSet Exe_Proc_with_PROC_EMP_MASTER_MNG(string typ, string P_aadhar, string insrtby, string text1="", string text2="", string text3="", string text4="", string text5="", string text6="", string text7="", string text8="", string text9="", string text10="", string text11="", string text12="", string text13="", string text14="", string text15="", string text16="", string text17="", string text18="", string text19="", string text20="", string text21="", string text22="", string text23="", string text24="", string text25="", string text26="", string text27="", string text28="", string text29="", string text30="", string text31="", string text32="", string text33="", string text34="", string text35="")
    {
        OC = new OracleConnection(constring);
        DataSet ds = new DataSet();
        OracleDataAdapter oradpdb1 = new OracleDataAdapter("PROC_HRMS_EMP_MASTER_MNG", OC);
        oradpdb1.SelectCommand.Parameters.Add("p_typ", OracleType.VarChar).Value = typ;
        oradpdb1.SelectCommand.Parameters.Add("P_aadhar", OracleType.VarChar).Value = P_aadhar;        
        oradpdb1.SelectCommand.Parameters.Add("p_text1", OracleType.VarChar).Value = text1;
        oradpdb1.SelectCommand.Parameters.Add("p_text2", OracleType.VarChar).Value = text2;
        oradpdb1.SelectCommand.Parameters.Add("p_text3", OracleType.VarChar).Value = text3;
        oradpdb1.SelectCommand.Parameters.Add("p_text4", OracleType.VarChar).Value = text4;
        oradpdb1.SelectCommand.Parameters.Add("p_text5", OracleType.VarChar).Value = text5;
        oradpdb1.SelectCommand.Parameters.Add("p_text6", OracleType.VarChar).Value = text6;
        oradpdb1.SelectCommand.Parameters.Add("p_text7", OracleType.VarChar).Value = text7;
        oradpdb1.SelectCommand.Parameters.Add("p_text8", OracleType.VarChar).Value = text8;
        oradpdb1.SelectCommand.Parameters.Add("p_text9", OracleType.VarChar).Value = text9;
        oradpdb1.SelectCommand.Parameters.Add("p_text10", OracleType.VarChar).Value = text10;
        oradpdb1.SelectCommand.Parameters.Add("p_text11", OracleType.VarChar).Value = text11;
        oradpdb1.SelectCommand.Parameters.Add("p_text12", OracleType.VarChar).Value = text12;
        oradpdb1.SelectCommand.Parameters.Add("p_text13", OracleType.VarChar).Value = text13;
        oradpdb1.SelectCommand.Parameters.Add("p_text14", OracleType.VarChar).Value = text14;
        oradpdb1.SelectCommand.Parameters.Add("p_text15", OracleType.VarChar).Value = text15;
        oradpdb1.SelectCommand.Parameters.Add("p_text16", OracleType.VarChar).Value = text16;
        oradpdb1.SelectCommand.Parameters.Add("p_text17", OracleType.VarChar).Value = text17;
        oradpdb1.SelectCommand.Parameters.Add("p_text18", OracleType.VarChar).Value = text18;
        oradpdb1.SelectCommand.Parameters.Add("p_text19", OracleType.VarChar).Value = text19;
        oradpdb1.SelectCommand.Parameters.Add("p_text20", OracleType.VarChar).Value = text20;
        oradpdb1.SelectCommand.Parameters.Add("p_text21", OracleType.VarChar).Value = text21;
        oradpdb1.SelectCommand.Parameters.Add("p_text22", OracleType.VarChar).Value = text22;
        oradpdb1.SelectCommand.Parameters.Add("p_text23", OracleType.VarChar).Value = text23;
        oradpdb1.SelectCommand.Parameters.Add("p_text24", OracleType.VarChar).Value = text24;
        oradpdb1.SelectCommand.Parameters.Add("p_text25", OracleType.VarChar).Value = text25;
        oradpdb1.SelectCommand.Parameters.Add("p_text26", OracleType.VarChar).Value = text26;
        oradpdb1.SelectCommand.Parameters.Add("p_text27", OracleType.VarChar).Value = text27;
        oradpdb1.SelectCommand.Parameters.Add("p_text28", OracleType.VarChar).Value = text28;
        oradpdb1.SelectCommand.Parameters.Add("p_text29", OracleType.VarChar).Value = text29;
        oradpdb1.SelectCommand.Parameters.Add("p_text30", OracleType.VarChar).Value = text30;
        oradpdb1.SelectCommand.Parameters.Add("p_text31", OracleType.VarChar).Value = text31;
        oradpdb1.SelectCommand.Parameters.Add("p_text32", OracleType.VarChar).Value = text32;
        oradpdb1.SelectCommand.Parameters.Add("p_text33", OracleType.VarChar).Value = text33;
        oradpdb1.SelectCommand.Parameters.Add("p_text34", OracleType.VarChar).Value = text34;
        oradpdb1.SelectCommand.Parameters.Add("p_text35", OracleType.VarChar).Value = text35;
        oradpdb1.SelectCommand.Parameters.Add("P_INSERT_BY", OracleType.VarChar).Value = insrtby;
        oradpdb1.SelectCommand.CommandType = CommandType.StoredProcedure;
        oradpdb1.SelectCommand.Parameters.Add("v_refcur", OracleType.Cursor).Direction = ParameterDirection.Output;
        oradpdb1.Fill(ds);
        return ds;
    }

    public DataSet Exe_Proc_with_PROC_HRMS_MRF(string typ, string P_aadhar, string insrtby, string text1 = "", string text2 = "", string text3 = "", string text4 = "", string text5 = "", string text6 = "", string text7 = "", string text8 = "", string text9 = "", string text10 = "", string text11 = "", string text12 = "", string text13 = "", string text14 = "", string text15 = "", string text16 = "", string text17 = "", string text18 = "", string text19 = "", string text20 = "", string text21 = "", string text22 = "", string text23 = "", string text24 = "", string text25 = "", string text26 = "", string text27 = "", string text28 = "", string text29 = "", string text30 = "", string text31 = "", string text32 = "", string text33 = "", string text34 = "", string text35 = "", string text36 = "", string text37 = "", string text38 = "", string text39 = "", string text40 = "", string text41 = "", string text42 = "", string text43 = "", string text44 = "", string text45 = "", string text46 = "", string text47 = "", string text48 = "", string text49 = "", string text50 = "")
    {
        OC = new OracleConnection(constring);
        DataSet ds = new DataSet();
        OracleDataAdapter oradpdb1 = new OracleDataAdapter("PROC_HRMS_MRF", OC);
        oradpdb1.SelectCommand.Parameters.Add("p_typ", OracleType.VarChar).Value = typ;
        oradpdb1.SelectCommand.Parameters.Add("P_aadhar", OracleType.VarChar).Value = P_aadhar;
        oradpdb1.SelectCommand.Parameters.Add("p_text1", OracleType.VarChar).Value = text1;
        oradpdb1.SelectCommand.Parameters.Add("p_text2", OracleType.VarChar).Value = text2;
        oradpdb1.SelectCommand.Parameters.Add("p_text3", OracleType.VarChar).Value = text3;
        oradpdb1.SelectCommand.Parameters.Add("p_text4", OracleType.VarChar).Value = text4;
        oradpdb1.SelectCommand.Parameters.Add("p_text5", OracleType.VarChar).Value = text5;
        oradpdb1.SelectCommand.Parameters.Add("p_text6", OracleType.VarChar).Value = text6;
        oradpdb1.SelectCommand.Parameters.Add("p_text7", OracleType.VarChar).Value = text7;
        oradpdb1.SelectCommand.Parameters.Add("p_text8", OracleType.VarChar).Value = text8;
        oradpdb1.SelectCommand.Parameters.Add("p_text9", OracleType.VarChar).Value = text9;
        oradpdb1.SelectCommand.Parameters.Add("p_text10", OracleType.VarChar).Value = text10;
        oradpdb1.SelectCommand.Parameters.Add("p_text11", OracleType.VarChar).Value = text11;
        oradpdb1.SelectCommand.Parameters.Add("p_text12", OracleType.VarChar).Value = text12;
        oradpdb1.SelectCommand.Parameters.Add("p_text13", OracleType.VarChar).Value = text13;
        oradpdb1.SelectCommand.Parameters.Add("p_text14", OracleType.VarChar).Value = text14;
        oradpdb1.SelectCommand.Parameters.Add("p_text15", OracleType.VarChar).Value = text15;
        oradpdb1.SelectCommand.Parameters.Add("p_text16", OracleType.VarChar).Value = text16;
        oradpdb1.SelectCommand.Parameters.Add("p_text17", OracleType.VarChar).Value = text17;
        oradpdb1.SelectCommand.Parameters.Add("p_text18", OracleType.VarChar).Value = text18;
        oradpdb1.SelectCommand.Parameters.Add("p_text19", OracleType.VarChar).Value = text19;
        oradpdb1.SelectCommand.Parameters.Add("p_text20", OracleType.VarChar).Value = text20;
        oradpdb1.SelectCommand.Parameters.Add("p_text21", OracleType.VarChar).Value = text21;
        oradpdb1.SelectCommand.Parameters.Add("p_text22", OracleType.VarChar).Value = text22;
        oradpdb1.SelectCommand.Parameters.Add("p_text23", OracleType.VarChar).Value = text23;
        oradpdb1.SelectCommand.Parameters.Add("p_text24", OracleType.VarChar).Value = text24;
        oradpdb1.SelectCommand.Parameters.Add("p_text25", OracleType.VarChar).Value = text25;
        oradpdb1.SelectCommand.Parameters.Add("p_text26", OracleType.VarChar).Value = text26;
        oradpdb1.SelectCommand.Parameters.Add("p_text27", OracleType.VarChar).Value = text27;
        oradpdb1.SelectCommand.Parameters.Add("p_text28", OracleType.VarChar).Value = text28;
        oradpdb1.SelectCommand.Parameters.Add("p_text29", OracleType.VarChar).Value = text29;
        oradpdb1.SelectCommand.Parameters.Add("p_text30", OracleType.VarChar).Value = text30;
        oradpdb1.SelectCommand.Parameters.Add("p_text31", OracleType.VarChar).Value = text31;
        oradpdb1.SelectCommand.Parameters.Add("p_text32", OracleType.VarChar).Value = text32;
        oradpdb1.SelectCommand.Parameters.Add("p_text33", OracleType.VarChar).Value = text33;
        oradpdb1.SelectCommand.Parameters.Add("p_text34", OracleType.VarChar).Value = text34;
        oradpdb1.SelectCommand.Parameters.Add("p_text35", OracleType.VarChar).Value = text35;
        oradpdb1.SelectCommand.Parameters.Add("p_text36", OracleType.VarChar).Value = text36;
        oradpdb1.SelectCommand.Parameters.Add("p_text37", OracleType.VarChar).Value = text37;
        oradpdb1.SelectCommand.Parameters.Add("p_text38", OracleType.VarChar).Value = text38;
        oradpdb1.SelectCommand.Parameters.Add("p_text39", OracleType.VarChar).Value = text39;
        oradpdb1.SelectCommand.Parameters.Add("p_text40", OracleType.VarChar).Value = text40;
        oradpdb1.SelectCommand.Parameters.Add("p_text41", OracleType.VarChar).Value = text41;
        oradpdb1.SelectCommand.Parameters.Add("p_text42", OracleType.VarChar).Value = text42;
        oradpdb1.SelectCommand.Parameters.Add("p_text43", OracleType.VarChar).Value = text43;
        oradpdb1.SelectCommand.Parameters.Add("p_text44", OracleType.VarChar).Value = text44;
        oradpdb1.SelectCommand.Parameters.Add("p_text45", OracleType.VarChar).Value = text45;
        oradpdb1.SelectCommand.Parameters.Add("p_text46", OracleType.VarChar).Value = text46;
        oradpdb1.SelectCommand.Parameters.Add("p_text47", OracleType.VarChar).Value = text47;
        oradpdb1.SelectCommand.Parameters.Add("p_text48", OracleType.VarChar).Value = text48;
        oradpdb1.SelectCommand.Parameters.Add("p_text49", OracleType.VarChar).Value = text49;
        oradpdb1.SelectCommand.Parameters.Add("p_text50", OracleType.VarChar).Value = text50;
        oradpdb1.SelectCommand.Parameters.Add("P_INSERT_BY", OracleType.VarChar).Value = insrtby;
        oradpdb1.SelectCommand.CommandType = CommandType.StoredProcedure;
        oradpdb1.SelectCommand.Parameters.Add("v_refcur", OracleType.Cursor).Direction = ParameterDirection.Output;
        oradpdb1.Fill(ds);
        return ds;
    }

    public DataSet Exe_proc_emp_search(string txt, string typ)
    {
        OC = new OracleConnection(constring);
        DataSet ds = new DataSet();
        OracleDataAdapter da = new OracleDataAdapter("proc_emp_search", OC);
        da.SelectCommand.Parameters.Add("p_aadhar_no", OracleType.VarChar).Value = txt.Trim();
        da.SelectCommand.Parameters.Add("p_RPRT_TYP", OracleType.VarChar).Value = typ;
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.Add("v_refcur", OracleType.Cursor).Direction = ParameterDirection.Output;
        da.SelectCommand.Parameters.Add("v_refcur_edu", OracleType.Cursor).Direction = ParameterDirection.Output;
        da.SelectCommand.Parameters.Add("v_refcur_emp", OracleType.Cursor).Direction = ParameterDirection.Output;
        da.Fill(ds);       
        return ds;
    }
    public DataSet Exe_proc_proc_deduping_hrms(string txt, string typ)
    {
        OC = new OracleConnection(constring);
        DataSet ds = new DataSet();
        OracleDataAdapter da = new OracleDataAdapter("proc_deduping_hrms", OC);
        da.SelectCommand.Parameters.Add("rprt_type", OracleType.VarChar).Value = typ;
        da.SelectCommand.Parameters.Add("p_report", OracleType.VarChar).Value = txt;
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.Add("v_refcur", OracleType.Cursor).Direction = ParameterDirection.Output;
        da.Fill(ds);
        return ds;
    }



    public DataSet Exe_proc_hrms_fill_data(string txt, string typ, string p_text1, string p_text2, string p_text3, string p_text4, string p_text5)
    {
        OC = new OracleConnection(constring);
        DataSet ds = new DataSet();
        OracleDataAdapter da = new OracleDataAdapter("proc_hrms_fill_data", OC);
        da.SelectCommand.Parameters.Add("rprt_type", OracleType.VarChar).Value = typ;
        da.SelectCommand.Parameters.Add("p_report", OracleType.VarChar).Value = txt;
        da.SelectCommand.Parameters.Add("p_text1", OracleType.VarChar).Value = p_text1;
        da.SelectCommand.Parameters.Add("p_text2", OracleType.VarChar).Value = p_text2;
        da.SelectCommand.Parameters.Add("p_text3", OracleType.VarChar).Value = p_text3;
        da.SelectCommand.Parameters.Add("p_text4", OracleType.VarChar).Value = p_text4;
        da.SelectCommand.Parameters.Add("p_text5", OracleType.VarChar).Value = p_text5;
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.Add("v_refcur", OracleType.Cursor).Direction = ParameterDirection.Output;
        da.Fill(ds);
        return ds;
    }

    public DataSet Exe_proc_FETCH_login_details(string userid, string password)
    {
        OC = new OracleConnection(constring);
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        OracleDataAdapter da = new OracleDataAdapter("FETCH_login_details", OC);
        da.SelectCommand.Parameters.Add("p_loginid", OracleType.VarChar).Value = userid;
        da.SelectCommand.Parameters.Add("p_passwrd", OracleType.VarChar).Value = password;
        da.SelectCommand.Parameters.Add("p_cip", OracleType.VarChar).Value = "";
        da.SelectCommand.Parameters.Add("p_cnm", OracleType.VarChar).Value = System.Environment.GetEnvironmentVariable("COMPUTERNAME");
        da.SelectCommand.Parameters.Add("p_appnm", OracleType.VarChar).Value = "HRMS";
        da.SelectCommand.CommandType = CommandType.StoredProcedure;
        da.SelectCommand.Parameters.Add("v_refcur", OracleType.Cursor).Direction = ParameterDirection.Output;
        da.SelectCommand.Parameters.Add("v_refcur1", OracleType.Cursor).Direction = ParameterDirection.Output;
        da.Fill(ds);
        dt = ds.Tables[0];
        return ds;
    }




    public string NASPATH()
    {

        UnMAPDrive();
        NetworkDrive oNetDrive = new aejw.Network.NetworkDrive();
        //  NetworkDrive oNetDrive = NetWorkDrives;
        var pth = naspath;
        var username = NAS_USERNAME;
        var password = NAS_Password;
        oNetDrive.LocalDrive = "ZZ:";
        oNetDrive.ShareName = pth;
        oNetDrive.MapDrive(username, password);


        var _NASPATH = oNetDrive.ShareName;
        _NASPATH = Path.Combine(_NASPATH, "PICS/");
        return _NASPATH;


    }

    public string NASPATHvendor()
    {

        UnMAPDrive();
        NetworkDrive oNetDrive = new aejw.Network.NetworkDrive();
        //  NetworkDrive oNetDrive = NetWorkDrives;
        var pth = naspath;
        var username = NAS_USERNAME;
        var password = NAS_Password;
        oNetDrive.LocalDrive = "ZZ:";
        oNetDrive.ShareName = pth;
        oNetDrive.MapDrive(username, password);


        var _NASPATH = oNetDrive.ShareName;
        _NASPATH = Path.Combine(_NASPATH, "VENDOR/");
        return _NASPATH;


    }


    public static void UnMAPDrive()
    {
        string logMsg = "Start Time :" + DateTime.Now; ;
        try
        {
            //NetworkDrive oNetDrive = NetWorkDrives;
            //oNetDrive.LocalDrive = "ZZ:";
            //oNetDrive.UnMapDrive();
            Process proc = new Process();
            proc.StartInfo.CreateNoWindow = true;
            proc.StartInfo.UseShellExecute = false;
            proc.StartInfo.FileName = "cmd.exe";
            //proc.StartInfo.Arguments="/c "+Application.StartupPath+"\\unmap.bat";
            proc.StartInfo.Arguments = "/c NET USE y: /delete ";
            proc.Start();
            proc.WaitForExit();
        }
        catch (Exception e)
        {
            logMsg += "Error On :" + DateTime.Now + e.ToString();
            // Log.CreateLog(logMsg, "UnMAPDrive", "UnMAPDrive");
        }
    }

    public static string naspath
    {
        get
        {
            return ConfigurationManager.AppSettings["naspath"];
        }
    }
    public static string NAS_USERNAME
    {
        get
        {
            return ConfigurationManager.AppSettings["NASUSERNAME"];
        }
    }
    public static string NAS_Password
    {
        get
        {
            return ConfigurationManager.AppSettings["NASPassword"];
        }
    }

}

public static class Extantions
{
    public static string ToDataSetToJSON(this DataTable dt)
    {
        List<Dictionary<string, object>> dict = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        foreach (DataRow dr in dt.Rows)
        {
            row = new Dictionary<string, object>();

            foreach (DataColumn col in dt.Columns)
            {
                row.Add(col.ColumnName, dr[col]);
            }
            dict.Add(row);
        }
        // JavaScriptSerializer json = new JavaScriptSerializer();
        System.Web.Script.Serialization.JavaScriptSerializer json = new System.Web.Script.Serialization.JavaScriptSerializer();
        json.MaxJsonLength = Int32.MaxValue;
        return json.Serialize(dict);
    }   
   
}

public static class DataSetExt
{
    public static string GetJSON(this DataSet ds)
    {

        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        ArrayList root = new ArrayList();
        List<Dictionary<string, object>> table;
        Dictionary<string, object> data;

        foreach (DataTable dt in ds.Tables)
        {
            table = new List<Dictionary<string, object>>();
            foreach (DataRow dr in dt.Rows)
            {
                data = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    data.Add(col.ColumnName, dr[col]);
                }
                table.Add(data);
            }
            root.Add(table);
        }

        return serializer.Serialize(root);
    }
}