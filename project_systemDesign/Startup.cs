using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(project_systemDesign.Startup))]
namespace project_systemDesign
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
