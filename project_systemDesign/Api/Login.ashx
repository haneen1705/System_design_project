<%@ WebHandler Language="C#" Class="LoginHandler" %>
using System;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;

public class LoginHandler : IHttpHandler
{
    public bool IsReusable { get { return false; } }

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        try
        {
            string email = context.Request["email"] ?? "";
            string displayName = email.Contains("@") ? email.Split('@')[0] : "User";
            var record = new {
                type = "login",
                email = email,
                name = displayName,
                createdAt = DateTime.UtcNow.ToString("o")
            };
            string dir = context.Server.MapPath("~/App_Data");
            Directory.CreateDirectory(dir);
            File.AppendAllText(Path.Combine(dir, "logins.jsonl"), new JavaScriptSerializer().Serialize(record) + Environment.NewLine);
            context.Response.Write(new JavaScriptSerializer().Serialize(new { success = true, user = record }));
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            context.Response.Write(new JavaScriptSerializer().Serialize(new { success = false, error = ex.Message }));
        }
    }
}
