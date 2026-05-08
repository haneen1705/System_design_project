<%@ WebHandler Language="C#" Class="HealthHandler" %>
using System;
using System.Web;
using System.Web.Script.Serialization;
public class HealthHandler : IHttpHandler
{
    public bool IsReusable { get { return false; } }
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.Write(new JavaScriptSerializer().Serialize(new { ok = true, app = "MentorHub", time = DateTime.UtcNow.ToString("o") }));
    }
}
