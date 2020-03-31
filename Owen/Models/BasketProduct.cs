using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Owen.Models
{
    public class BasketProduct
    {
        public string ShortName { get; set; }
        public string Name { get; set; }

        public string Marks { get; set; }
        public decimal? Price { get; set; }
        public string Category { get; set; }
        public string MainCategory { get; set; }
        public int Count{ get; set; }
        //public decimal? TotalPrice { get; set; }

        public override string ToString()
        {
            return $"{ShortName}-{Marks} [{Count}]шт. по {Price} грн. Всего = {Count*Price} грн.";
        }
    }
}