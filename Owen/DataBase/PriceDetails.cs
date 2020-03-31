namespace Owen.DataBase
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class PriceDetails
    {
        public int PriceDetailsId { get; set; }

        public int? Id_Product { get; set; }

        [StringLength(300)]
        public string Marks { get; set; }

        [Column(TypeName = "money")]
        public decimal? Price { get; set; }

        public virtual Product Product { get; set; }
    }
}
