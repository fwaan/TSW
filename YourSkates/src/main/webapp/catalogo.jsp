<%@ include file="header.jsp" %>

    <div class="container">
        <div class="slideshow">
            <div class="slide">
                <a href="skateboard.jsp">
                    <p class="image-caption">SKATEBOARD</p>
                    <img src="immagini/skateboard.png" alt="Skateboard" class="hover-image">
                </a>
                <div class="dot-container">
                    <span class="dot active"></span>
                    <span class="dot"></span>
                    <span class="dot"></span>
                  </div>
            </div>
            <div class="slide">
                <a href="longboard.jsp">
                    <p class="image-caption">LONGBOARD</p>
                    <img src="immagini/longboard.png" alt="Longboard" class="hover-image">
                </a>
                <div class="dot-container">
                    <span class="dot"></span>
                    <span class="dot active"></span>
                    <span class="dot"></span>
                  </div>
            </div>
            <div class="slide">
                <a href="cruiser.jsp">
                    <p class="image-caption">CRUISER</p>
                    <img src="immagini/cruiser.png" alt="Cruiser" class="hover-image">
                </a>
                <div class="dot-container">
                    <span class="dot"></span>
                    <span class="dot"></span>
                    <span class="dot active"></span>
                  </div>
            </div>
        </div>
        <div class="image-container">
            <a href="skateboard.jsp">
                <p class="image-caption">SKATEBOARD</p>
                <img src="immagini/skateboard.png" alt="Skateboard" class="hover-image">
            </a>
        </div>
        <div class="image-container">
            <a href="longboard.jsp">
                <p class="image-caption">LONGBOARD</p>
                <img src="immagini/longboard.png" alt="Longboard" class="hover-image">
            </a>
        </div>
        <div class="image-container">
            <a href="cruiser.jsp">
                <p class="image-caption">CRUISER</p>
                <img src="immagini/cruiser.png" alt="Cruiser" class="hover-image">
            </a>
        </div>
    </div>
    <script>
        var slideContainer = document.querySelector('.slideshow');
        var slides = document.getElementsByClassName("slide");
        var startX;
        var endX;
        var slideIndex = 1; // initialize slideIndex

        showSlides(slideIndex); // show the first slide

        slideContainer.addEventListener('touchstart', function (event) {
            startX = event.touches[0].clientX;
        });

        slideContainer.addEventListener('touchmove', function (event) {
            endX = event.touches[0].clientX;
        });

        slideContainer.addEventListener('touchend', function (event) {
            var threshold = 200; // threshold in pixels for swipe action
            if (startX - endX > threshold) {
                // swipe left, go to next slide
                nextSlide();
            } else if (endX - startX > threshold) {
                // swipe right, go to previous slide
                prevSlide();
            }
        });

        function nextSlide() {
            slideIndex++;
            if (slideIndex > slides.length) { slideIndex = 1 }
            showSlides(slideIndex);
        }

        function prevSlide() {
            slideIndex--;
            if (slideIndex < 1) { slideIndex = slides.length }
            showSlides(slideIndex);
        }

        function showSlides(n) {
            var i;
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            slides[n - 1].style.display = "block";
        }
    </script>
    <%@ include file="footer.jsp" %>