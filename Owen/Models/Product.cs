using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Owen.Models
{
    public class Product
    {
        public int Id { get; set; }
        public string ShortName { get; set; }
        public string Name { get; set; }

        public string Marks { get; set; }
        public decimal? Price { get; set; }
        public string ImgSource { get; set; }

        public string Category { get; set; }
        public string MainCategory { get; set; }
        // Главный  текст  на Catalog/Details
        public string Details { get; set; }
        //заддумано  что они  идут одинаковы  по size
        public List<string> ListMenu { get; set; }
        public List<string> ListInfo { get; set; }

        public Product(int id , string name, string ShortName, string Marks, int Price, string img, string Category, string MainCategory,string Details)
        {
            this.Id = id;
            this.Name = name;
            this.ShortName = ShortName; 
            this.Marks = Marks;
            this.Price = Price;
            this.ImgSource = img;
            this.Category = Category;
            this.MainCategory = MainCategory;
            this.Details = Details;
        }
        public Product() {  }
        public override string ToString()
        {
            return $"Id = {Id} , ShortName = {ShortName}, Name =  {Name}, Marks = {Marks}, Price = {Price}, MainCategory = {MainCategory},Category = {Category} , ImgSource = {ImgSource}";
        }
    }
}