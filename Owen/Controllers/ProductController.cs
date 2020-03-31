using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Owen.Controllers
{
    public class ProductController : Controller
    {
        public ActionResult DownloadFiles(string fileName= null, string fileExtention =null)
        {
            if (fileExtention==".zip")
            {
                //в  окне сохранения меняет строку DEFAULT name
                Response.AddHeader("Content-Disposition", $"inline; filename={fileName}.zip");
                return new FilePathResult(string.Format(@"~\ProductFiles\ZIP\{0}", fileName + ".zip"), "application/zip");
                //application/octet -альтернативный вариант если зип не работает (не тестил)
            }
            else if (fileExtention == ".pdf")
            {
                //                                       attachment   -  сразу скачать
                Response.AddHeader("content-disposition", $"inline; filename={fileName}.pdf");
                var path = System.IO.Path.Combine(Server.MapPath("~"), "ProductFiles\\PDF", fileName + ".pdf");
                return new FilePathResult(path, "application/pdf");
            }
            return new HttpStatusCodeResult(System.Net.HttpStatusCode.NotFound);
        }
    }
}