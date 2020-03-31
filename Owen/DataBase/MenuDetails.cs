namespace Owen.DataBase
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class MenuDetails
    {
        public int MenuDetailsId { get; set; }

        [StringLength(200)]
        public string MenuName { get; set; }

        public int? Id_InfoDetails { get; set; }

        public int? Id_Details { get; set; }

        public virtual Details Details { get; set; }

        public virtual InfoDetails InfoDetails { get; set; }
    }
}
