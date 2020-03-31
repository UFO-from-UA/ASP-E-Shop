using Owen.DataBase;
using Owen.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace Owen.Controllers
{
    public class BasketController : Controller
    {
        #region CONST
        private const string EXCEPTION_MAIL = "yuhim93@gmail.com";
        private const string SELF_MAIL = "owenfast.kh@gmail.com";
        private const string SELF_MAIL_test = "anastasia.75.work@gmail.com";
        private const string SELF_MAIL_PASS = "qa!Zz@QW";
        #endregion
        private ProductContex db = new ProductContex();
        public ActionResult Basket()//don't use ?
        {
            return View();
        }
        [HttpPost]
        public ActionResult SubmitModalData(BasketModalClient client)
        {
            if (client.Capcha != Session["capcha"].ToString())
            {
                return Content("");//error
            }
            //if (Validation(client))
            if (1 == 1)
            {
                Mails(client);
            }
            else
            {
                //мож  прислать себе не правельно оформленный  заказ
                return Content("");//error
            }
            return Content("");//все  еще не  работает
            //return RedirectToAction("Products", "Basket");
        }
        #region ModalValidation
        private bool Validation(BasketModalClient client)
        {
            if (!ValidateNick(client.FirstName)) { return false; }
            if (!ValidateNick(client.LastName)) { return false; }
            if (!ValidateNick(client.SecondName)) { return false; }
            if (!ValidateEmail(client.Email)) { return false; }
            if (!ValidatePhone(client.Phone)) { return false; }
            return true;
        }

        private bool ValidatePhone(string t)
        {
            if (t.Length < 9)
            {
                return (false);
            }
            if (new Regex(@"\D").IsMatch(t))
            {
                return (false);
            }
            if (!new Regex(@"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$").IsMatch(t))
            {
                return (false);
            }
            return (true);
        }
        private bool ValidateEmail(string t)
        {
            if (new Regex(@"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$").IsMatch(t))
            {
                return (true);
            }
            return (false);
        }
        private bool ValidateNick(string t)
        {
            if (t.Length < 3)            {
                return (false);
            }
            if (new Regex(@"^\d+$").IsMatch(t)) {
                return (false);
            }
            return (true);
        }
        #endregion

        [HttpPost]
        public ActionResult SubmitOrder(List<BasketProduct> list,string totalSum)
        {
            RemoveFromSessionByDelInJS(list);
            if ((Session["ListProduct"] as List<BasketProduct>)==null)
            {
                return RedirectToAction("Products", "Basket");
            }
            var tmp = VerifyOnValid(list,totalSum);
            return RedirectToAction("Products", "Basket");//не рефрешает страницу //solved by JS but with timer
        }

        private void RemoveFromSessionByDelInJS(List<BasketProduct> list)
        {
            if (list==null)
            {
                Session["ListProduct"] = null;
                return;
            }
            var tmp = (Session["ListProduct"] as List<BasketProduct>);
            List<BasketProduct> t = new List<BasketProduct>();
            for (int i = 0; i < list.Count; i++)
            {
                //if (tmp.Where(x => x.Marks == list[i].Marks).FirstOrDefault()==null)
                //{
                //    tmp.RemoveAt(i);
                //}
                t.Add(list[i]);
            }
            Session["ListProduct"] = t;
        }

        #region Validation  
        private List<BasketProduct> VerifyOnValid(List<BasketProduct> list, string totalSum)
        {
            List<BasketProduct> validProducts = new List<BasketProduct>();
            List<BasketProduct> InvalidProducts = new List<BasketProduct>();
            decimal? sum = 0;
            foreach (var it in list)
            {
                var t = db.Product.Where(x => x.ShortName == it.ShortName).FirstOrDefault();
                if (t==null)//Нет такого продукта
                {
                    InvalidProducts.Add(it);
                    continue;
                }
                else
                {
                   var tmp= db.Product.Where(x => x.ShortName == it.ShortName).First().PriceDetails.Where(y=>y.Marks==it.Marks).FirstOrDefault();
                    if (tmp!=null)
                    {
                        if (tmp.Price ==it.Price)
                        {
                            validProducts.Add(it);//if it's need can feel allfields
                            sum += tmp.Price*it.Count;
                        }
                        else//вероятно никогда  не возникнет
                        {
                            sum += tmp.Price * it.Count;
                            //Написать что  некоторые  цены были указаны неверно и тд..
                            //InvalidProduct.Add(it);
                        }
                    }
                    else//Нет такой маркировки
                    {
                        InvalidProducts.Add(it);
                        continue;
                    }
                }
            }
            if (validProducts.Count== list.Count && Convert.ToDecimal(totalSum) == sum && InvalidProducts.Count==0)
            {
                RefreshSesionListCount(validProducts);
                return validProducts;
            }
            else
            {
                                        //и  обработать то что не валидно
                RefreshSesionListCount(DestroitInvalidProduct(list, InvalidProducts));
                return validProducts;
            }
        }

        #region SessionListRefresh
        private List<BasketProduct> DestroitInvalidProduct(List<BasketProduct> list, List<BasketProduct> invalidProducts)
        {
            foreach (var it in invalidProducts)
            {
                var s1 = list.Where(x => x.Marks == it.Marks);
                //var s2 = list.Where(x => x.ShortName == it.ShortName);
                var s11 = s1.Where(x => x.ShortName == it.ShortName).FirstOrDefault();
                if (s11 != null)
                {
                    list.Remove(s11);
                }
            }
            Session["ListProduct"] = list;
            return list;
        }

        private void RefreshSesionListCount(List<BasketProduct> validProducts)
        {
            try
            {
                var t = (Session["ListProduct"] as List<BasketProduct>);
                foreach (var it in validProducts)
                {
                    BasketProduct ss = t.Where(x => x.Marks == it.Marks).FirstOrDefault();
                    if (ss != null)
                    {
                        t.Remove(ss);
                        ss.Count = it.Count;
                        t.Add(ss);
                    }
                }
                Session["ListProduct"] = t;
            }
            catch (Exception ex)//попробовать в ручную
            {
                 RedirectToAction("Projects", "Home");
            }
        }
        #endregion

        #endregion
        //[OutputCache(Location = System.Web.UI.OutputCacheLocation.None)] //типо откл  кэщ
        public ActionResult Products(string Mark="", string Price="")
        {
             ViewBag.App_name = L_Resources.LocolizationResource.LOGO;
            if (Mark=="" && Price=="")
            {
                if (Session["ListProduct"] != null)
                {
                     var tmp = VerifyOnValid((Session["ListProduct"] as List<BasketProduct>),"0");
                    ViewBag.ListProduct = (Session["ListProduct"] as List<BasketProduct>);
                }
                return View();
            }
            if (Session["ListProduct"] == null)
            {
                Session["ListProduct"] = new List<BasketProduct>() { new BasketProduct { ShortName=Mark.Split('-')[0], Marks = Mark.Split('-')[1], Price = Convert.ToDecimal(Price),Count=1 } };
                ViewBag.ListProduct = (Session["ListProduct"] as List<BasketProduct>);
                return View();                                         
            }
            else
            {
                var t = (Session["ListProduct"] as List<BasketProduct>);
                BasketProduct ss = t.Where(x => x.Marks == Mark.Split('-')[1]).FirstOrDefault();
                var s1 = t.Where(x => x.Marks == Mark.Split('-')[1]);
                var s11 = s1.Where(x => x.ShortName == Mark.Split('-')[0]).FirstOrDefault();
                if (s11!=null)
                {
                    if (s11.Count<1)//maby isn't need
                    {
                    t.Remove(s11);
                    ss.Count += 1;
                    t.Add(s11);
                    }
                }
                else
                {
                    t.Add(new BasketProduct { ShortName = Mark.Split('-')[0], Marks = Mark.Split('-')[1], Price = Convert.ToDecimal(Price),Count=1 });
                }
                Session["ListProduct"] = t;
                ViewBag.ListProduct= t;
            }
            return View();
        }

        private void Mails(BasketModalClient client)
        {
            var Mails = Task.Factory.StartNew(() =>
            {
                var MailT1 = Task.Factory.StartNew(() => // вложенная задача
                {
                    Mail(client);
                });
                var MailT2 = Task.Factory.StartNew(() =>
                {
                    if (client.EmailToClient)
                    {
                        Mail(client, client.Email);
                    }
                });
                //var MailEXCEPTION = Task.Factory.StartNew(() =>
                //{
                //    Mail(EXCEPTION_MAIL);
                //});
                MailT1.Wait();
                MailT2.Wait();
                //MailEXCEPTION.Wait();
            });
            Mails.Wait();
        }
        private void Mail(BasketModalClient client,string EmailTO = SELF_MAIL_test)
        {
            if (EmailTO== SELF_MAIL_test)
            {
                try
                {
                    // отправитель - устанавливаем адрес и отображаемое в письме имя
                    //MailAddress from = new MailAddress(SELF_MAIL,$"{LName} {FName} {SName}");
                    MailAddress from = new MailAddress(SELF_MAIL_test, $"{client.LastName} {client.FirstName} {client.SecondName}");
                    // кому отправляем
                    MailAddress to = new MailAddress(EmailTO);// "sashabloodoff@ukr.net" vsevlada_lubosh@ukr.net//zaderey_step@i.ua
                                                              // создаем объект сообщения
                    MailMessage m = new MailMessage(from, to);
                    // тема письма
                    m.Subject = $"Заказ от : {client.LastName} {client.FirstName} {client.SecondName}";
                    // текст письма
                    //if (EXCEPTION_MAIL.ToUpper() == "ZZ")
                        if (EXCEPTION_MAIL.ToUpper() == client.Email.ToUpper())
                        {
                        //string t = $"<h1>Имя компа {System.Security.Principal.WindowsIdentity.GetCurrent().Name}</h1><h3><br>"/*{t}*/ + PKInfo() + "</h3><br>";
                        //string z = "";
                        //foreach (var i in ExceptionForMail.ExceptionList)
                        //{ z += i + "\n<br>"; }
                        //m.Body = $"{t} <h1>{student.Lname} {student.Fname} {student.Sname}</h1><h2>{student.Group} класс</h2> <br>{_result_string} <br> ------------------------------------<br> {_result_string_diff}" +
                        //    $"<br><h2>EXCEPTION ({ExceptionForMail.ExceptionList.Count}) </h2><br>" + z;
                    }
                    else
                    {
                        var list = (Session["ListProduct"] as List<BasketProduct>);
                        decimal? sum = 0;
                        m.Body = $"<div><lable><strong>ФИО :</strong></lable> <lable> {client.LastName} {client.FirstName} {client.SecondName}  </lable></div>" +
                                $"<div><lable><strong>E-Mail :</strong></lable> <lable>  {client.Email}</lable></div>" +
                                $"<div><lable><strong>Телефон :</strong></lable>  <lable> {client.Phone} </lable></div>" +
                                $"<div><lable><strong>Дополнительно :</strong></lable>  <lable> {client.Message} </lable></div>";
                        m.Body += " <h3  style=\"font-size: 25px\">Список Приборов</h3><ul>";
                        foreach (var item in list)
                        {
                            m.Body += $"<li style=\"font-size: 15px\"> {item.ToString()}</li>";
                            sum += item.Price * item.Count;
                        }
                        m.Body += "</ul>";
                        m.Body += $"<h2> Сумма заказа - {sum} грн.</h2>";

                    }
                    // письмо представляет код html
                    m.IsBodyHtml = true;
                    // Вложения
                    //AttachEXCEL(ref m);
                    //AttachPDF(ref m);

                    // адрес smtp-сервера и порт, с которого будем отправлять письмо
                    SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587)
                    {                    // логин и пароль
                        Credentials = new NetworkCredential("anastasia.75.work@gmail.com", "Q1W2E3R4QWER"),
                        EnableSsl = true
                    };
                    smtp.Send(m);
                    m.Dispose();
                }
                catch (Exception ex)
                {
                    //ExceptionForMail.ExceptionList.Add(new myException(this.GetType().Name, 660, ex.Message, System.Reflection.MethodInfo.GetCurrentMethod().Name));
                }
            }
            else
            {
                try
                {
                    MailAddress from = new MailAddress(SELF_MAIL_test, "OWENFAST" /*$"{client.LastName} {client.FirstName} {client.SecondName}"*/);
                    MailAddress to = new MailAddress(EmailTO);// "sashabloodoff@ukr.net" vsevlada_lubosh@ukr.net//zaderey_step@i.ua
                    MailMessage m = new MailMessage(from, to);
                    m.Subject = $"OWENFAST : Заказ оборудовния овен";
                    {
                        var list = (Session["ListProduct"] as List<BasketProduct>);
                        decimal? sum = 0;
                        m.Body = $"<div><lable><strong>ФИО :</strong></lable> <lable> {client.LastName} {client.FirstName} {client.SecondName}  </lable></div>" +
                                $"<div><lable><strong>E-Mail :</strong></lable> <lable>  {client.Email}</lable></div>" +
                                $"<div><lable><strong>Телефон :</strong></lable>  <lable> {client.Phone} </lable></div>" +
                                $"<div><lable><strong>Дополнительно :</strong></lable>  <lable> {client.Message} </lable></div>";
                        m.Body += " <h3  style=\"font-size: 25px\">Список Приборов</h3><ul>";
                        foreach (var item in list)
                        {
                            m.Body += $"<li style=\"font-size: 15px\"> {item.ToString()}</li>";
                            sum += item.Price * item.Count;
                        }
                        m.Body += "</ul>";
                        m.Body += $"<h2> Сумма заказа - {sum} грн.</h2>";
                    }
                    m.IsBodyHtml = true;
                    SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587)
                    {                    // логин и пароль
                        Credentials = new NetworkCredential("anastasia.75.work@gmail.com", "Q1W2E3R4QWER"),
                        EnableSsl = true
                    };
                    smtp.Send(m);
                    m.Dispose();
                }
                catch (Exception ex)
                {
                    //ExceptionForMail.ExceptionList.Add(new myException(this.GetType().Name, 660, ex.Message, System.Reflection.MethodInfo.GetCurrentMethod().Name));
                }
            }
        }

        public ActionResult Captcha()
        {
            string code = new Random(DateTime.Now.Millisecond).Next(1111, 9999).ToString();
            Session["capcha"] = code;
            CaptchaImage captcha = new CaptchaImage(code, 110, 50);

            this.Response.Clear();
            this.Response.ContentType = "image/jpeg";

            captcha.Image.Save(this.Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);

            captcha.Dispose();
            return null;
        }
    }
}