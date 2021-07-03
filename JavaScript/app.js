
// Fashion Code
var FashionSlideIndex = 1;
FashionShowSlides(FashionSlideIndex);

// Next/previous controls
function FashionPlusSlides(n) {
    FashionShowSlides(FashionSlideIndex += n);
}

// Thumbnail image controls
function FashionCurrentSlides(n) {
    FashionShowSlides(FashionSlideIndex = n);
}

function FashionShowSlides(n) {
    var i;
    var slides = document.getElementsByClassName("FashionSlides");
   
    if (n > slides.length) { FashionSlideIndex = 1 }
    if (n < 1) { FashionSlideIndex = slides.length }
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    
    slides[FashionSlideIndex - 1].style.display = "block";
}


// Electronics Code
var ElectronicsSlideIndex = 1;
ElectronicsShowSlides(ElectronicsSlideIndex);

// Next/previous controls
function ElectronicsPlusSlides(n) {
    ElectronicsShowSlides(ElectronicsSlideIndex += n);
}

// Thumbnail image controls
function ElectronicsCurrentSlides(n) {
    ElectronicsShowSlides(ElectronicsSlideIndex = n);
}

function ElectronicsShowSlides(n) {
    var i;
    var slides = document.getElementsByClassName("ElectronicsSlides");

    if (n > slides.length) { ElectronicsSlideIndex = 1 }
    if (n < 1) { ElectronicsSlideIndex = slides.length }
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }

    slides[ElectronicsSlideIndex - 1].style.display = "block";
}




// Food Code
var FoodSlideIndex = 1;
FoodShowSlides(FoodSlideIndex);

// Next/previous controls
function FoodPlusSlides(n) {
    FoodShowSlides(FoodSlideIndex += n);
}

// Thumbnail image controls
function FoodCurrentSlides(n) {
    FoodShowSlides(FoodSlideIndex = n);
}

function FoodShowSlides(n) {
    var i;
    var slides = document.getElementsByClassName("FoodSlides");

    if (n > slides.length) { FoodSlideIndex = 1 }
    if (n < 1) { FoodSlideIndex = slides.length }
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }

    slides[FoodSlideIndex - 1].style.display = "block";
}




