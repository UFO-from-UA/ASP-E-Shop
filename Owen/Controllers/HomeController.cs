using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using Owen.DataBase;


namespace Owen.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.App_name = L_Resources.LocolizationResource.LOGO;
            return View();
        }

        public ActionResult Catalog()
        {
            ViewBag.Title = L_Resources.LocolizationResource.Catalog;
            ViewBag.App_name = L_Resources.LocolizationResource.LOGO;
            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Title = L_Resources.LocolizationResource.aboutCompany_Contacts;
            ViewBag.App_name = L_Resources.LocolizationResource.LOGO;
            return View();
        }

        #region USE post but firs get
        //[AcceptVerbs(HttpVerbs.Get)]
        //        public ActionResult Index()
        //        {
        //            // obviously these values might come from somewhere non-trivial
        //            return Index(2, "text");
        //        }

        //        [AcceptVerbs(HttpVerbs.Post)]
        //        public ActionResult Index(int someValue, string anotherValue)
        //        {
        //            // would probably do something non-trivial here with the param values
        //            return View();
        //        }
        #endregion
        public ActionResult Projects(String s)//List<Product>
        {

            ViewBag.App_name = L_Resources.LocolizationResource.LOGO;
            return View("Projects");
        }


        public ActionResult InfoPaymentDelivery()
        {
            ViewBag.App_name = L_Resources.LocolizationResource.LOGO;
            ViewBag.Title = L_Resources.LocolizationResource.paymentDeliver;
            return View();
        }

        public ActionResult Certifications()
        {
            ViewBag.App_name = L_Resources.LocolizationResource.LOGO;
            ViewBag.Title = L_Resources.LocolizationResource.support_serteficate;
            return View();
        }

        public ActionResult PartView(string vievName)
        {
            if (vievName == "Regulators")
            {
                return PartialView("1_Regulators_PartialView");

            }
            else if (vievName == "ManageControl")
            {
                return PartialView("2_ManageControl_PartialView");
            }
            else if (vievName == "Switches")
            {
                return PartialView("3_ProgrammableRele_PartialView");
            }
            //...
            //return PartialView(vievName);
            return PartialView("1_Regulators_PartialView");
        }

        //[Route("Home/{main_category}/{category}/{product}")]
        //public ActionResult Create(string x, string zz, string z)
        //{
        //    return View();
        //    //return string.Format($"Пользователь: {x}, Id:cc");
        //}
    }
}