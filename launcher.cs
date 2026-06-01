using System.Diagnostics;
using System.Security.Principal;

class Program {
    static void Main() {
        if (!IsAdmin()) {
            Process.Start(new ProcessStartInfo(
                System.Reflection.Assembly.GetExecutingAssembly().Location) {
                Verb = "runas",
                UseShellExecute = true
            });
            return;
        }

        Process.Start(new ProcessStartInfo("taskkill", "/f /im explorer.exe") {
            UseShellExecute = false,
            CreateNoWindow = true
        }).WaitForExit();

        Process.Start(new ProcessStartInfo("explorer.exe") {
            UseShellExecute = true
        });
    }

    static bool IsAdmin() {
        WindowsIdentity id = WindowsIdentity.GetCurrent();
        return new WindowsPrincipal(id).IsInRole(WindowsBuiltInRole.Administrator);
    }
}
