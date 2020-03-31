namespace Owen.DataBase
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class ProductContex : DbContext
    {
        public ProductContex()
            : base("name=ProductContex")
        {
        }

        public virtual DbSet<Category> Category { get; set; }
        public virtual DbSet<Details> Details { get; set; }
        public virtual DbSet<InfoDetails> InfoDetails { get; set; }
        public virtual DbSet<MainCategory> MainCategory { get; set; }
        public virtual DbSet<MenuDetails> MenuDetails { get; set; }
        public virtual DbSet<PriceDetails> PriceDetails { get; set; }
        public virtual DbSet<Product> Product { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Category>()
                .HasMany(e => e.Product)
                .WithOptional(e => e.Category)
                .HasForeignKey(e => e.Id_Category);

            modelBuilder.Entity<Details>()
                .HasMany(e => e.MenuDetails)
                .WithOptional(e => e.Details)
                .HasForeignKey(e => e.Id_Details);

            modelBuilder.Entity<Details>()
                .HasMany(e => e.Product)
                .WithOptional(e => e.Details)
                .HasForeignKey(e => e.Id_Details);

            modelBuilder.Entity<InfoDetails>()
                .HasMany(e => e.MenuDetails)
                .WithOptional(e => e.InfoDetails)
                .HasForeignKey(e => e.Id_InfoDetails);

            modelBuilder.Entity<MainCategory>()
                .HasMany(e => e.Product)
                .WithOptional(e => e.MainCategory)
                .HasForeignKey(e => e.Id_MainCategory);

            modelBuilder.Entity<PriceDetails>()
                .Property(e => e.Price)
                .HasPrecision(19, 4);

            modelBuilder.Entity<Product>()
                .HasMany(e => e.PriceDetails)
                .WithOptional(e => e.Product)
                .HasForeignKey(e => e.Id_Product);
        }
    }
}
