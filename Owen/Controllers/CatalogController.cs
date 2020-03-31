using Owen.DataBase;
using System.Collections.Generic;
using System.Linq;
using System.Resources;
using System.Web.Mvc;

namespace Owen.Controllers
{
    public class CatalogController : Controller
    {
        private ProductContex db = new ProductContex();
        #region BuildResourceDictionary
        public Dictionary<string, string> BuildResourceDictionary(ResourceManager manager)
        {
            Dictionary<string, string> resourceDict = new Dictionary<string, string>();

            ResourceSet resourceSet = manager.GetResourceSet(System.Globalization.CultureInfo.CurrentUICulture, true, true);

            System.Collections.IDictionaryEnumerator enumerator = resourceSet.GetEnumerator();

            while (enumerator.MoveNext())
            {
                resourceDict.Add((string)enumerator.Key, (string)enumerator.Value);
            }

            return resourceDict;
        }
        #endregion

        public ActionResult Category(string CategoryName)
        {
            //var rr = HttpContext.GetGlobalResourceObject("LocolizationResource","LOGO");
            //Dictionary<string, string> xx = BuildResourceDictionary(new ResourceManager("LocolizationResource",System.Reflection.Assembly.Load("App_LocalResources")));
             ViewBag.App_name = L_Resources.LocolizationResource.LOGO;
            if (CategoryName==null)
            {
                return View("Error");
            }
            ViewBag.Title = Request.Url.ToString().Substring(Request.Url.ToString().IndexOf("=")+1);
            ViewBag.CategoryListItems = GetProductByCategory(CategoryName);
            return View();
        }
        public ActionResult Details(string DetailName)
        {
            ViewBag.App_name = L_Resources.LocolizationResource.LOGO;
            ViewBag.Title = DetailName;
            if (DetailName == null)
            {
                return View("Error");
            }
            ViewBag.Product = GetProductDetails(DetailName);
            #region МБ уже не надо
            //if (DetailName == "ТРМ200")
            //ViewBag.Product = TempData["DetailsPage"] as Product;
            //При  refresh редиректит сюдаже , и нет TempData , обход ↓
            //TempData["DetailsPage"] = ViewBag.Product;
            #endregion
            return View();
        }

        public ActionResult PartViewDetails(string DetailName)
        {
            ViewBag.DetailsInfo = DetailName;
           var xx2 = (Session["DetailsPage"] as Models.Product).ListMenu.FindIndex(x => x.Equals(DetailName));
            var zz2 = ((Session["DetailsPage"] as Models.Product).ListInfo)[xx2];//.get(xx);
            ViewBag.data = zz2;
            return PartialView("_Details_PartialView");
        }
        public ActionResult PriceDetails_PartView()
        {
            var tmp = Session["DetailsPage"] as Models.Product;
            List<string> l_marks = new List<string>();
            List<string> l_prise = new List<string>();
            var t= /*await*/ db.Product
                .Where(x => x.ShortName == tmp.ShortName).First().PriceDetails;
            foreach (var it in t)
            {
                l_marks.Add(tmp.ShortName + "-" + it.Marks);
                l_prise.Add(""+it.Price);
            }
            ViewBag.ListMarks = l_marks;
            ViewBag.ListPrice = l_prise;

            return PartialView("_PriceDetails_PartialView");
        }

        public List<Models.Product> GetProductByCategory(string CategoryName)//PageData for Category View
        {
            #region EXEMPLE WORCK with  this  DB

            //string connectString = System.Configuration.ConfigurationManager.ConnectionStrings["LinqToSQLDBConnectionString"].ToString();

            //LinqToSQLDataContext db = new LinqToSQLDataContext(connectString);

            ////Create new Employee

            //Employee newEmployee = new Employee();
            //newEmployee.Name = "Michael";
            //newEmployee.Email = "yourname@companyname.com";
            //newEmployee.ContactNo = "343434343";
            //newEmployee.DepartmentId = 3;
            //newEmployee.Address = "Michael - USA";

            ////Add new Employee to database
            //db.Employees.InsertOnSubmit(newEmployee);

            ////Save changes to Database.
            //db.SubmitChanges();

            ////Get new Inserted Employee            
            //Employee insertedEmployee = db.Employees.FirstOrDefault(e ⇒e.Name.Equals("Michael"));
            #endregion

            #region JsonConvert
            //var ssd =  JsonConvert.SerializeObject(new List<Models.Product>() { new Models.Product("ТРМ200. Измеритель двухканальный с RS-485",1, "https://owen.ua/uploads/79/trm200-n--.jpg"),
            //    new Models.Product("УКТ38. Измеритель 8-канальный с аварийной сигнализацией",3846, "https://owen.ua/thumbs/79/1/karta-tovara-ukt38v___7814f375-260x260-d.jpg"),
            //    new Models.Product("ИДЦ1. Измеритель цифровой одноканальный",2016, "https://owen.ua/thumbs/80/karta-tovara___1349a27c-260x260-d.jpg"),
            //);
            //List<Models.Product> model = JsonConvert.DeserializeObject<List<Models.Product>>(serializedModel);
            #endregion

            var tmp = /*await*/ db.Product
                .Where(x => x.Category.CategoryName == CategoryName);
                //.ToListAsync();
            List<Models.Product> ListProduct = new List<Models.Product>();
            foreach (var it in tmp)
            {
                ListProduct.Add(new Models.Product()
                {
                    Name = it.Name,
                    ShortName = it.ShortName,
                    Price = it.PriceDetails.Min(x => x.Price),
                    ImgSource = it.ImgSource
                });
            }

            return ListProduct;
        }

        public Models.Product GetProductDetails(string ShortName)//PageData for Details View
        {
            var tmp = /*await*/ db.Product
                .Where(x => x.ShortName == ShortName);
                //.ToListAsync();
            Models.Product ProductDetails = new Models.Product();
            foreach (var it in tmp)
            {
                ProductDetails = new Models.Product()
                {
                    Name = it.Name,
                    ShortName = it.ShortName,
                    Details = it.Details.MainInfo,
                    ImgSource = it.ImgSource,
                    Price = it.PriceDetails.Min(x => x.Price),//Мин  цена  для надписи  "от ХХХХ грн"
                    ListMenu = ProdGetMenuList(it),
                    ListInfo = ProdGetInfoList(it)
                };
            }

            Session["DetailsPage"] = ProductDetails;
            return ProductDetails;

        }
        #region GetDetailsLists
        private List<string> ProdGetInfoList(DataBase.Product it)
        {
            List<string> t = new List<string>();
            foreach (var i in it.Details.MenuDetails)
            {
                t.Add(i.InfoDetails.HtmlData);
            }
            return t;
        }

        private List<string> ProdGetMenuList(DataBase.Product it)
        {
            List<string> t = new List<string>();
            foreach (var i in it.Details.MenuDetails)
            {
                t.Add(i.MenuName);
            }
            return t;
        }
        #endregion

    }
}