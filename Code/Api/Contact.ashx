<%@ WebHandler Language="C#" Class="ContactHandler" %>
using System;
using System.IO;
using System.Web;
using System.Web.Script.Serialization;

public class ContactHandler : IHttpHandler
{
    public bool IsReusable { get { return false; } }

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        try
        {
            var record = new {
                type = "contact",
                name = context.Request["name"] ?? "",
                email = context.Request["email"] ?? "",
                phone = context.Request["phone"] ?? "",
                role = context.Request["role"] ?? "",
                message = context.Request["message"] ?? "",
                createdAt = DateTime.UtcNow.ToString("o")
            };
            string dir = context.Server.MapPath("~/App_Data");
            Directory.CreateDirectory(dir);
            File.AppendAllText(Path.Combine(dir, "messages.jsonl"), new JavaScriptSerializer().Serialize(record) + Environment.NewLine);
            context.Response.Write(new JavaScriptSerializer().Serialize(new { success = true }));
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            context.Response.Write(new JavaScriptSerializer().Serialize(new { success = false, error = ex.Message }));
        }
    }
}
