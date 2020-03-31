namespace Owen.DataBase
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class InfoDetails
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public InfoDetails()
        {
            MenuDetails = new HashSet<MenuDetails>();
        }

        public int InfoDetailsId { get; set; }

        [StringLength(300)]
        public string ImgSource { get; set; }

        [StringLength(300)]
        public string UrlImgSource { get; set; }

        public string HtmlData { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MenuDetails> MenuDetails { get; set; }
    }
}
