using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Owen.Filters;
using Owen.Models;

namespace Owen.Controllers
{
    [Culture]
    public class LocalizationController : Controller
    {
        // GET: Localization
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ChangeCulture(string lang)
        {
            //string returnUrl = Request.UrlReferrer.AbsolutePath;
            string returnUrl = Request.UrlReferrer.AbsoluteUri;
            // Список культур
            List<string> cultures = new List<string>() { "ru", "uk", "en" };
            if (!cultures.Contains(lang))
            {
                lang = "ru";
            }
            // Сохраняем выбранную культуру в куки
            HttpCookie cookie = Request.Cookies["lang"];
            if (cookie != null)
                cookie.Value = lang;   // если куки уже установлено, то обновляем значение
            else
            {
                cookie = new HttpCookie("lang");
                cookie.HttpOnly = false;
                cookie.Value = lang;
                cookie.Expires = DateTime.Now.AddYears(1);
            }
            Response.Cookies.Add(cookie);
            return Redirect(returnUrl);
        }

    }
}