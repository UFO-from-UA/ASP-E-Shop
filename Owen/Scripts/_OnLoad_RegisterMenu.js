setTimeout(function () {
    $('div.navbar').ready(function (event) {
        RegisterHoover();
        RegisterArrowToTop();
        BasketNumber();
        CultureSelected();
        $('.dropdown-menu-support').hide();
    });
}, 200);

function BasketNumber() {
    if (sessionStorage.BASKET_for_layout != null) {
        $("#BASKET").attr("data-count", "" + sessionStorage.BASKET_for_layout);
    }
    else {
        $("#BASKET").attr("data-count", "0");
    }    
} 
function CultureSelected() {
    //console.dir(getCookie("lang"));
    var elements = document.getElementsByClassName("localizationButtons");
        //console.dir(elements);
    if (getCookie("lang") === "ru") {
        //console.dir("ru");
        elements[1].classList.remove("selectedLang");
        elements[0].classList.add("selectedLang");
    }
    else {
        //console.dir("ua");
        elements[0].classList.remove("selectedLang");
        elements[1].classList.add("selectedLang");
    }
}
function RegisterArrowToTop() {//проверить регистрацию
    window.onscroll = function () { scrollFunction() };
    console.dir("EndPageLoad-Arrow");
}

function scrollFunction() {
    var scrollArrow = document.getElementById("scrollArrow");
    if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
        scrollArrow.style.display = "block";
    } else {
        scrollArrow.style.display = "none";
    }
}
           
// When the user clicks on the button, scroll to the top of the document
function topFunction() {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
}

function RegisterHoover() {
    console.dir("EndPageLoad");
    $('.dropdown-toggle-support').mouseover(function () {
        $('.dropdown-menu-support').show();
    })
    $('.dropdown-toggle-support').mouseout(function () {
        t = setTimeout(function () {
            $('.dropdown-menu-support').hide();
        }, 200);

        $('.dropdown-menu-support').on('mouseenter', function () {
            $('.dropdown-menu-support').show();
            clearTimeout(t);
        }).on('mouseleave', function () {
            $('.dropdown-menu-support').hide();
        });
    });
}

function getCookie(name) {
    let matches = document.cookie.match(new RegExp(
        "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
    ));
    return matches ? decodeURIComponent(matches[1]) : undefined;
}