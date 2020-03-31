using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Owen.DataBase;

namespace Owen.Controllers
{
    public class DB_Controller : Controller
    {
        private ProductContex db = new ProductContex();

        // GET: DB_
        public async Task<ActionResult> GetProductByCategory(string CategoryName)//PageData for Category View
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

            //var tmp = db.Product.Where(x => x.Category.CategoryName == CategoryName);
            //var ListProduct = await tmp.ToListAsync();

            var tmp = await db.Product
                .Where(x => x.Category.CategoryName == CategoryName)
                .ToListAsync();
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

            TempData["CategoryPage"] = ListProduct;
            return RedirectToAction("Category", "Catalog", new { CategoryName = CategoryName });

        }

        public async Task<ActionResult> GetProductDetails(string ShortName)//PageData for Details View
        {
            var tmp = await db.Product
                .Where(x => x.ShortName == ShortName)
                .ToListAsync();
            Models.Product ProductDetails = new Models.Product();
            foreach (var it in tmp)
            {
                ProductDetails = new Models.Product()
                {
                    Name = it.Name,
                    ShortName = it.ShortName,
                    Details = it.Details.MainInfo,
                    ImgSource = it.ImgSource,
                    Price = it.PriceDetails.Min(x=>x.Price),//Мин  цена  для надписи  "от ХХХХ грн"
                    ListMenu = ProdGetMenuList(it),
                    ListInfo = ProdGetInfoList(it)
                };
            }

            TempData["DetailsPage"] = ProductDetails;
            return RedirectToAction("Details", "Catalog", new { DetailName = ShortName }
               );

        }

        private List<string> ProdGetInfoList(Product it)
        {
            List<string> t = new List<string>();
            foreach (var i in it.Details.MenuDetails)
            {
                t.Add(i.InfoDetails.HtmlData);
            }
            return t;
        }

        private List<string> ProdGetMenuList(Product it)
        {
            List<string> t = new List<string>();
            foreach (var i in it.Details.MenuDetails)
            {
                t.Add(i.MenuName);
            }
            return t;
        }

        // GET: DB_/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = await db.Product.FindAsync(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // GET: DB_/Create
        public ActionResult Create()
        {
            ViewBag.Id_Category = new SelectList(db.Category, "CategoryId", "CategoryName");
            ViewBag.Id_Details = new SelectList(db.Details, "DetailsId", "MainInfo");
            ViewBag.Id_MainCategory = new SelectList(db.MainCategory, "MainCategoryId", "MainCategoryName");
            return View();
        }

        // POST: DB_/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Id,Id_MainCategory,Id_Category,Id_Details,ShortName,Name,ImgSource")] Product product)
        {
            if (ModelState.IsValid)
            {
                db.Product.Add(product);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            ViewBag.Id_Category = new SelectList(db.Category, "CategoryId", "CategoryName", product.Id_Category);
            ViewBag.Id_Details = new SelectList(db.Details, "DetailsId", "MainInfo", product.Id_Details);
            ViewBag.Id_MainCategory = new SelectList(db.MainCategory, "MainCategoryId", "MainCategoryName", product.Id_MainCategory);
            return View(product);
        }

        // GET: DB_/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = await db.Product.FindAsync(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ViewBag.Id_Category = new SelectList(db.Category, "CategoryId", "CategoryName", product.Id_Category);
            ViewBag.Id_Details = new SelectList(db.Details, "DetailsId", "MainInfo", product.Id_Details);
            ViewBag.Id_MainCategory = new SelectList(db.MainCategory, "MainCategoryId", "MainCategoryName", product.Id_MainCategory);
            return View(product);
        }

        // POST: DB_/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id,Id_MainCategory,Id_Category,Id_Details,ShortName,Name,ImgSource")] Product product)
        {
            if (ModelState.IsValid)
            {
                db.Entry(product).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.Id_Category = new SelectList(db.Category, "CategoryId", "CategoryName", product.Id_Category);
            ViewBag.Id_Details = new SelectList(db.Details, "DetailsId", "MainInfo", product.Id_Details);
            ViewBag.Id_MainCategory = new SelectList(db.MainCategory, "MainCategoryId", "MainCategoryName", product.Id_MainCategory);
            return View(product);
        }

        // GET: DB_/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = await db.Product.FindAsync(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: DB_/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            Product product = await db.Product.FindAsync(id);
            db.Product.Remove(product);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
