"use strict";
//console.dir("start");// as state
function sleep(ms) {
    return new Promise(resolve => setTimeout(Init, ms));
}
//sleep(2000);//норm пашет
var remove, add, CountElement, count = 0, LAYOUT_BASKET, removeFull;

window.onload = Init();//толком не пащет , норм только потому что скрипт внизу хтмл страницы
function Init() {
    //console.dir("end"); // as state
    remove = document.querySelectorAll('.countRemove');
    removeFull = document.querySelectorAll('.remove');
    add = document.querySelectorAll('.countAdd');
    //eval - типизация предположительно в  инт от "use strict"; https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Strict_mode
    removeFull.forEach(function (t) {

        t.addEventListener('click', function () {
            var par = t.parentElement;
            par.parentNode.removeChild(par);
            var tmp = document.getElementsByClassName("total");
            if (tmp.length>0) {
                totals = document.querySelectorAll('.total');
                $('.TOTAL').prop("disabled", false);
                tmp[0].dispatchEvent(new Event("change"));
            }
            else {
                var TOTAL = document.querySelector('.TOTAL');
                TOTAL.value = "0,00";
                $('.TOTAL').prop("disabled", true);

            }
            $("#BASKET").attr("data-count", "" + tmp.length);
            sessionStorage.BASKET_for_layout = tmp.length;
        });

    });

    remove.forEach(function (t) {

        t.addEventListener('click', function () {
            var par = t.parentElement;
            var CountElement = par.getElementsByClassName("count")[0];
            var Count = eval(CountElement.childNodes[0].data);
            var total = par.getElementsByClassName("total")[0];
            var price = eval(par.getElementsByClassName("price")[0].firstChild.data.substring(0, par.getElementsByClassName("price")[0].firstChild.data.length - 3));
            Count -= 1;
            if (Count < 0) {
                Count = 0;
            }
            CountElement.innerHTML = "" + Count;
            CountElement.childNodes[0].parentElement.value = Count;
            //total.innerHTML = (Count * price) + ",00";
            total.value = (Count * price) + ",00";
            total.dispatchEvent(new Event("change"));//запуск ивента у  элемента

            //Test(par, CountElement, Count, total, price);
        });
    });

    add.forEach(function (t) {

        t.addEventListener('click', function () {
            var par = t.parentElement;
            var CountElement = par.getElementsByClassName("count")[0];
            var Count = eval(CountElement.childNodes[0].data);
            var total = par.getElementsByClassName("total")[0];
            var price = eval(par.getElementsByClassName("price")[0].firstChild.data.substring(0, par.getElementsByClassName("price")[0].firstChild.data.length - 3));
            Count += 1;
            CountElement.innerHTML = "" + Count;
            CountElement.childNodes[0].parentElement.value = Count;
            total.value = (Count * price) + ",00";
            total.dispatchEvent(new Event("change"));
            //Test(par, CountElement, Count, total, price);
        });
    });

    $('.badge.count').select((e) =>{
         
            e.target.value = "0";
            e.target.dispatchEvent(new Event("input"));
        }    );
    $('.badge.count').keypress(function (e) {//работает на все
        var a = [];
        var k = e.which;
        var i;
        if (this.value.length > 3) {
            e.preventDefault();
        }
       
        if (this.value[0] === "0") {
            this.value = this.value.substring(1);
            }

        for (i = 48; i < 58; i++)
            a.push(i);

        if (!(a.indexOf(k) >= 0))
            e.preventDefault();
    });

    // оставить для UI выделения изменения  цены
    //$('.badge.count').on("focusout",
    //    (e) => {
    //        console.dir(e);
    //    }
    //);

    var textAreas = document.querySelectorAll('.count');
    textAreas.forEach(function (t) {
        t.addEventListener('input', (a) => {//change input
            let textLn = t.value.length;
            if (textLn == 0) {
                t.value = "0";
            }
            if (textLn >= 3) {
                t.style.width = '4rem';
            }
            else {
                t.style.width = ' 3.5rem';
            }
            var par = t.parentElement;
            var total = par.getElementsByClassName("total")[0];
            var price = eval(par.getElementsByClassName("price")[0].firstChild.data.substring(0, par.getElementsByClassName("price")[0].firstChild.data.length - 3));
            var CountElement = par.getElementsByClassName("count")[0];
            CountElement.innerHTML = "" + CountElement.childNodes[0].parentElement.value;
            total.value = (CountElement.childNodes[0].parentElement.value * price) + ",00";
            total.dispatchEvent(new Event("change"));

            //console.dir(CountElement.childNodes[0].parentElement.value);
        });

    });

    var totals = document.querySelectorAll('.total');
    totals.forEach(function (t) {
        t.addEventListener('change', () => {//change input
            var TOTAL = document.querySelector('.TOTAL');
            var sum = 0;
            totals.forEach(function (t) {
                sum += eval(t.value.substring(0, t.value.length - 3));
            });
            if (sum > 0) {
                TOTAL.value = sum + ",00";
            }
            else {
                TOTAL.value = "0,00";
            }
        });
    });

    if (textAreas.length > 0) {
        $("#BASKET").attr("data-count", "" + textAreas.length);
        sessionStorage.BASKET_for_layout = textAreas.length;
        //https://stackoverflow.com/questions/44384529/how-to-access-session-variable-in-asp-net-mvc-using-a-javascript-variable-as-a-k
        //https://www.w3schools.com/html/html5_webstorage.asp
        textAreas.forEach(function (t) {
            t.dispatchEvent(new Event("input"));
        });
        totals[0].dispatchEvent(new Event("change"));
    }
    RegisterModal();
    var btn = document.getElementById("modalConfirn");
    btn.addEventListener("click", modalConfirn, false);

}
function modalConfirn() {
    document.getElementById("Modal").style.display = "none";
    //ValidateModal();
    createJSONforModal();

    window.location.href = '/Basket/Products/';//мож непонадобится
}
function createJSONforModal() {
    var z = new Client();
    z.LastName = $("#surname").val();
    z.FirstName = $("#name").val();
    z.SecondName = $("#secondname").val();
    z.Phone = $("#recipient-phone").val();
    z.Capcha = $("#capcha").val();
    z.Email = $("#email").val();
    z.EmailToClient = $('#MailToClient').is(':checked');
    z.Message = $("#message").val();
    jQuery.extend({
        postJSON: function (cl, callback, fail) {
            return jQuery.ajax({
                type: "POST",
                url: "/Basket/SubmitModalData",
                data: JSON.stringify({ 'client': cl}),//https://stackoverflow.com/questions/28316378/how-to-pass-multiple-parameters-from-ajax-to-mvc-controller
                success: callback,
                OnFailure: fail,
                dataType: "json",
                contentType: "application/json",
                processData: false
            });
        }
    });
    $.postJSON(z, Success(), Failure());
}
function ConfirnOrder() {
    jQuery.extend({
        postJSON: function (data, total, callback, fail) {
            return jQuery.ajax({
                type: "POST",
                url: "/Basket/SubmitOrder",
                data: JSON.stringify({ 'list': data, 'totalSum': total }),//https://stackoverflow.com/questions/28316378/how-to-pass-multiple-parameters-from-ajax-to-mvc-controller
                success: callback,
                OnFailure: fail,
                Error: "err(x)",
                dataType: "json",
                contentType: "application/json",
                processData: false
            });
        }
    });
    //https://stackoverflow.com/questions/6244411/ajax-actionlink-calling-controller-twice
    //$.postJSON(/*'@URL.Action("Basket", "Basket")', */ { CategoryName: "ss" }, Test("JSON CALLBACK"));
    var totalSum = document.querySelector('.TOTAL').value.substring(0, document.querySelector('.TOTAL').value.length - 3);

    $.postJSON(createJSON(), totalSum, Success(), Failure());
}

function err(x) {
    console.dir(x);
}
function Failure() {
    //console.dir("Fail");
}
function Success() {
    //console.dir("succes");
    //window.location.reload(); //http://qaru.site/questions/9665842/asp-mvc-how-refresh-index-page-after-data-deletion
    //setTimeout(() => {//подумать над задержкой так как ф-я вкл как только уйдет аякс 
    //    window.location.href = '/Basket/Products/';
    //}, 500);

}

function createJSON() {
    var JSON_obj = [];
    var tmp_prod = document.querySelectorAll('ul.list-group li');
    //console.dir(tmp_prod);
    if (tmp_prod.length < 1) {
        return JSON_obj;
    }
    tmp_prod.forEach((t) => {
        var mark = t.getElementsByClassName("mark")[0].firstChild.data;
        var price = eval(t.getElementsByClassName("price")[0].firstChild.data.substring(0, t.getElementsByClassName("price")[0].firstChild.data.length - 3));
        var Count = eval(t.getElementsByClassName("count")[0].childNodes[0].data);
        var ShortName = mark.split("-")[0];
        mark = mark.split("-")[1];
        //Test(mark, ShortName, Count, "не надо", price);

        var item = {};
        item["ShortName"] = ShortName;
        item["Name"] = "не надо";
        item["Marks"] = mark;
        item["Price"] = price;
        item["Category"] = "не надо";
        item["MainCategory"] = "не надо";
        item["Count"] = Count;

        JSON_obj.push(item);
    });
    //console.dir(JSON_obj);
    return JSON_obj;
}

function RegisterModal() {
    var modal = document.getElementById("Modal");
    var btn = document.getElementById("confirnOrder");
    var span = document.getElementsByClassName("closeModal")[0];
    btn.addEventListener("click", function () { modal.style.display = "block"; }, false);// то как внизу , заменяет ивент
    span.onclick = function () {
        modal.style.display = "none";
        window.location.href = '/Basket/Products/';
    };
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
            window.location.href = '/Basket/Products/';
        }
    };
}

function ValidateModal() {
    //console.dir($("#email").val());
    //console.dir($("#name").val());
    //console.dir($("#surname").val());
    //console.dir($("#secondname").val());
    //console.dir($("#recipient-phone").val());
    //console.dir($("#capcha").val());
    if (!ValidateEmail($("#email").val())) {  return;    }
    if (!ValidateNick("name", $("#name").val())) { return; }
    if (!ValidateNick("surname", $("#surname").val())) { return; }
    if (!ValidateNick("secondname", $("#secondname").val())) { return; }
    if (!ValidatePhone($("#recipient-phone").val())) { return; }
    if (!Validate($("#capcha").val())) { return; }
}
function ValidateEmail(mail) {
    if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(mail)) {
        return (true);
    }
    alert("You have entered an invalid email address!");
    return (false);
}
function ValidateNick(a,t) {
    if (t.length < 3) {
        alert("You "+a+" is too short");
        return (false);
    }
    if (/\d+/.test(t)) {
        alert("You " + a +" Cannot contain just numbers");
        return (false);
    }
    return (true);
}
function Validate(t) {
    if (t.length != 4) {
        alert("You picture code must have 4 numbers");
        return (false);
    }
    return (true);
}
function ValidatePhone(t) {
    if (t.length < 10) {
        alert("Incorrect phone");
        return (false);
    }
    if (!/d/.test(t)) {
        alert("NUMBER CAN'T DO NOT CONTAIN DIGITS");
        return (false);
    }
    if (!/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/im.test(t)) {
        return (false);
    }
    return (true);
}

function maxLengthCheck(object) {//onInputCapcha check
    if (object.value.length > object.maxLength)
        object.value = object.value.slice(0, object.maxLength)
}

function Test(par, elem, data, total, price) {
    console.dir("--------------");
    console.dir("PARENT ELEM");
    console.dir(par);
    console.dir("--------------");
    console.dir("CountElement");
    console.dir(elem);
    console.dir("--------------");
    console.dir("Data after change = " + data);
    console.dir("--------------");

    console.dir("price = " + price);
    console.dir("--------------");
    console.dir("total");
    console.dir(total);
    console.dir("--------------");
}


class Client {
          LastName;
}