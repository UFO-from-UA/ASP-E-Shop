namespace Owen.DataBase
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Product")]
    public partial class Product
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Product()
        {
            PriceDetails = new HashSet<PriceDetails>();
        }

        public int Id { get; set; }

        public int? Id_MainCategory { get; set; }

        public int? Id_Category { get; set; }

        public int? Id_Details { get; set; }

        [StringLength(50)]
        public string ShortName { get; set; }

        [StringLength(300)]
        public string Name { get; set; }

        [StringLength(300)]
        public string ImgSource { get; set; }

        public virtual Category Category { get; set; }

        public virtual Details Details { get; set; }

        public virtual MainCategory MainCategory { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PriceDetails> PriceDetails { get; set; }
    }
}
