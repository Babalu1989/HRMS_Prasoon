<%@ Application Language="C#" %>

<script runat="server">

    
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>

<%@ Import Namespace="System.Web.Routing" %>
<script runat="server">
    void Application_Start(object sender, EventArgs e)
    {
        RegisterRoutes(RouteTable.Routes);
    }
   
    static void RegisterRoutes(RouteCollection routes)
    {
        routes.MapPageRoute("Login", "Login", "~/Login.aspx");
        routes.MapPageRoute("Dashboard", "Dashboard", "~/Dashboard.aspx");
        routes.MapPageRoute("AllEmployee", "AllEmployee", "~/empdt.aspx");
        routes.MapPageRoute("Report", "Report", "~/Common_report.aspx");
        routes.MapPageRoute("EmployeeDetail", "EmployeeDetail", "~/EmployeeDetail.aspx");
        routes.MapPageRoute("EmployeeSummary", "EmployeeSummary", "~/EmployeeSummary.aspx");
        routes.MapPageRoute("Holiday", "Holiday", "~/Holiday.aspx");
        routes.MapPageRoute("Deactive", "Deactive", "~/Termination.aspx");
        routes.MapPageRoute("Reportingofficer", "Reportingofficer", "~/Reportingofficer.aspx");
        routes.MapPageRoute("Message", "Message", "~/Message.aspx");
        routes.MapPageRoute("Update", "Update", "~/Vendormove.aspx");
        routes.MapPageRoute("LIbulkupdate", "LIbulkupdate", "~/LIbulkupdate.aspx");
        routes.MapPageRoute("Clearance", "Clearance", "~/Clearance.aspx");
        routes.MapPageRoute("Admin", "Admin", "~/Admin.aspx");
        routes.MapPageRoute("BulkSMS", "BulkSMS", "~/BulkSMS.aspx");
        routes.MapPageRoute("Seperation", "Seperation", "~/Seperation.aspx");
        routes.MapPageRoute("form", "form", "~/Seperationform.aspx");
        routes.MapPageRoute("Wages", "Wages", "~/HRreport.aspx");
        routes.MapPageRoute("vendorregistration", "vendorregistration", "~/vendorregistration.aspx");
        routes.MapPageRoute("MRF", "MRF", "~/MRF.aspx");
        routes.MapPageRoute("MRFapprove", "MRFapprove", "~/MRFapprove.aspx");
        routes.MapPageRoute("mrfreport", "mrfreport", "~/mrfreport.aspx");
        routes.MapPageRoute("UIDGeneration", "UIDGeneration", "~/UIDGeneration.aspx");
        routes.MapPageRoute("UIDTermination", "UIDTermination", "~/UIDTermination.aspx");
        routes.MapPageRoute("UIDReturnreplace", "UIDReturnreplace", "~/UIDReturnreplace.aspx");
        routes.MapPageRoute("UIDRenewal", "UIDRenewal", "~/UIDRenewal.aspx");
        routes.MapPageRoute("POCreation", "POCreation", "~/POCreation.aspx");
        routes.MapPageRoute("uidpendencyreport", "uidpendencyreport", "~/uidpendencyreport.aspx");
        
    }
</script>


