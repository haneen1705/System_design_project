<%@ WebHandler Language="C#" Class="SessionHandler" %>
using System;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;

public class SessionHandler : IHttpHandler
{
    public bool IsReusable { get { return false; } }

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        try
        {
            var record = new {
                type = "session",
                fullName = context.Request["fullName"] ?? "",
                email = context.Request["email"] ?? "",
                promoCode = context.Request["promoCode"] ?? "",
                sessionDate = context.Request["sessionDate"] ?? "",
                sessionMonth = context.Request["sessionMonth"] ?? "September",
                sessionTime = context.Request["sessionTime"] ?? "",
                createdAt = DateTime.UtcNow.ToString("o")
            };

            string dir = context.Server.MapPath("~/App_Data");
            Directory.CreateDirectory(dir);
            File.AppendAllText(Path.Combine(dir, "sessions.jsonl"), new JavaScriptSerializer().Serialize(record) + Environment.NewLine);

            context.Response.Write(new JavaScriptSerializer().Serialize(new { success = true, session = record }));
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            context.Response.Write(new JavaScriptSerializer().Serialize(new { success = false, error = ex.Message }));
        }
    }
}
