<%@ WebHandler Language="C#" Class="RegisterHandler" %>
using System;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;

public class RegisterHandler : IHttpHandler
{
    public bool IsReusable { get { return false; } }

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        try
        {
            var record = new {
                type = "register",
                name = context.Request["name"] ?? "",
                email = context.Request["email"] ?? "",
                role = context.Request["role"] ?? "",
                createdAt = DateTime.UtcNow.ToString("o")
            };
            string dir = context.Server.MapPath("~/App_Data");
            Directory.CreateDirectory(dir);
            string path = Path.Combine(dir, "users.jsonl");
            File.AppendAllText(path, new JavaScriptSerializer().Serialize(record) + Environment.NewLine);
            context.Response.Write(new JavaScriptSerializer().Serialize(new { success = true, user = record }));
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            context.Response.Write(new JavaScriptSerializer().Serialize(new { success = false, error = ex.Message }));
        }
    }
}
