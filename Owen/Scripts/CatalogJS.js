function DetailsHoover_add(arg) {
    arg.classList.add("active");
    //console.dir(arg.dataset.maingroup);
    $("#main_category").load("/Catalog/PartView", { DetailName: arg.dataset.maingroup });  //PartView это экшен в контроллере Сatalog
}
function DetailsHoover_remove(arg) {
    //console.dir("Hoover_remove");
    arg.classList.remove("active");
    //arg.classList.add("text-primary");
}
function DetailsClick_LoadPartial(arg) {
    var x = document.getElementsByClassName("active");
    document.body.scrollTop = 120;
    document.documentElement.scrollTop = 120;
    //console.dir(x);
    if (x.length>0) {
        x[0].classList.remove("active");
    }
    arg.classList.add("active");
    //console.dir(arg.dataset.maingroup);
    if (arg.dataset.maingroup=='Цены') {
        $("#main_category").load("/Catalog/PriceDetails_PartView"); 
     //и далее  другой партиал виев с подгрузкой  маркировок и цен
    } 
    else {
        $("#main_category").load("/Catalog/PartViewDetails", { DetailName: arg.dataset.maingroup });  //PartView это экшен в контроллере Сatalog
    }
    
}
function pHoover_add(arg) {
     arg.classList.add("active");
     //console.dir(arg.dataset.maingroup);
     $("#main_category").load("/Home/PartView", { vievName: arg.dataset.maingroup });  //PartView это экшен в контроллере Home
     //$('#main_category').load('@Url.Action("Insert_Partial_View","Customers")');
}

function pHoover_remove(arg) {
    //console.dir("pHoover_remove");
    arg.classList.remove("active");
    arg.classList.add("text-primary");    
}

function CategorySelected(arg) {
    //https://stackoverflow.com/questions/6244411/ajax-actionlink-calling-controller-twice
    //console.dir(arg.textContent);
    //arg.preventDefault(); // ОТключает всплывание и первый вход в метод остаётся только нул
    setTimeout(function () {
        $.ajax({
            url: "/Catalog/Category",
            method: 'POST',
            data: { CategoryName: arg.textContent }
        }).done(function (e) {     /*   e.preventDefault();        return false;*/ });
    }, 200);


    //$.ajax({
    //    //url: "/Catalog/Category",
    //    url: "/Catalog/Category",
    //    method: 'POST',
    //    data: { CategoryName:arg.textContent }
    //}).done(function (e) {     /*   e.preventDefault();        return false;*/    });
    
    //@Html.ActionLink("Index page", "Index", "Home", new { @id = 1 }, null)
    //@html.Action("", "", { })
    //@Url.Action("Category", "Catalog", { CategoryName = arg.textContent });

}
    