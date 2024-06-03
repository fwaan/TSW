<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="UTF-8">
        <title>YourSkates</title>
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            @font-face{
                font-family: 'Titoli-Skateboard';
                src:url('font-esterni/Bubbleboddy-FatTrial.ttf');
            }
            @font-face{
                font-family: 'Font-Carino';
                src:url('font-esterni/PermanentMarker-Regular.ttf');
            }
            @font-face{
                font-family: 'Roboto-Serif';
                src:url('font-esterni/Roboto_Serif/RobotoSerif-VariableFont_GRAD\,opsz\,wdth\,wght.ttf');
            }
            body, .navbar{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                overflow-x: hidden;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background-image: url('immagini/sfondo.png');
                background-size: cover;
                background-position: center center;
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-position: center 100px;
                background-color: #f8f8f5; /* Cambia il colore di sfondo a #f8f8f5 */
            }
            .navbar {
                width: 100%;
                overflow: auto;
                box-sizing: border-box;
                display: flex;
                align-items: center;
                background-color: #333;
                border-bottom: #ffffff 0.125rem solid;
                padding: 0.5rem 0;
            }

            .navbar a,
            .navbar img,
            .navbar i {
                color: #f2f2f2;
                padding: 0.875rem 1rem;
                text-decoration: none;
                user-select: none;
                transition: color 0.3s ease;
            }

            .navbar .a1 {
                display: flex;
                align-items: center;
            }

            .navbar .a1:hover {
                background-color: inherit;
                color: inherit;
            }

            .navbar a:hover,
            .navbar i:hover {
                background-color: #ddd;
                color: black;
            }

            .logo {
                max-height: 1.5625rem;
                width: 3.125rem;
                transition: transform 0.3s ease;
            }
            .logo:hover{
                transform: scale(1.1);
            }

            .logo-name {
                color: #fff;
                font-size: 1.75rem;
                letter-spacing: 0.15rem;
                font-weight: bold;
                margin-right: auto;
                font-family: Titoli-Skateboard;
            }

            .links a {
                font-size: 1.5625rem;
                margin: 0 1.875rem;
            }

            .icons {
                margin-left: auto;
            }

            .icons a {
                padding: 0;
                transition: color 0.3s ease;
            }
            .icons a:hover{
                color: #ddd;
            }

            .container {
                display: flex;
                justify-content: space-between;
            }

            .image-container {
                margin: 5%;
                width: 25%;
                height: 25%;
                float: left;
                overflow: hidden;
                background-color: rgba(238, 191, 112, 0.5);
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                border: 0.125rem solid red;
                border-radius: 0.5rem;
                transition: transform 0.3s ease;
            }

            .image-container a {
                display: block;
                width: 100%;
                height: 100%;
                text-decoration: none;
            }

            .image-container-sell {
                margin: 5%;
                width: 25%;
                height: 25%;
                overflow: hidden;
                background-color: rgba(238, 191, 112, 0.5);
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                border: 0.125rem solid red;
                border-radius: 0.5rem;
                transition: transform 0.3s ease;
            }

            .image-caption {
                text-align: center;
                font-size: 2rem;
                letter-spacing: 0.15rem;
                font-weight: bolder;
                color: #515151;
                text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
                text-decoration: none;
                font-family: Titoli-Skateboard;
            }

            .image-caption2 {
                text-align: center;
                font-size: 2rem;
                letter-spacing: 0.15rem;
                font-weight: bolder;
                color: #515151;
                text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
                text-decoration: none;
                font-family: Titoli-Skateboard;
                margin-top: 1%;
            }

            .hover-image {
                width: 80%;
                height: 80%;
                object-fit: contain;
                transition: transform 0.3s ease;
                position: relative;
                top: 20%;
                left: 10%;
                transform-origin: center;
            }

            .hover-image:hover {
                transform: scale(1.1);
            }

            main {
                flex: 1 0 auto;
                padding-bottom: 10%;
                margin-bottom: 5rem;
            }
            footer {
                font-family: Titoli-Skateboard;
                position: fixed;
                flex-shrink: 0;
                background-color: #333;
                color: white;
                text-align: center;
                padding: 0.625rem;
                padding-bottom: 0;
                left: 0;
                bottom: 0;
                width: 100%;
                margin-top: auto;
                margin-bottom: 0;
                border-top: #ffffff 0.125rem solid;
            }

            .form-container {
                width: 40%;
                padding: 1.25rem;
                background-color: rgba(238, 191, 112, 0.5);
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                border: 0.125rem solid red;
                border-radius: 0.5rem;
                transition: transform 0.3s ease;
                margin-right: 22%;
                margin-top: 0.4%;
                margin-bottom: 10rem;
            }
            .form-container3 {
                width: 10%;
                padding: 1.25rem;
                background-color: lightgreen;
                border-radius: 0.625rem;
                margin-right: 22%;
            }
            .radio-container label{
                font-family: Titoli-Skateboard;
                font-size: 1.5rem;
                text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
            }
            .form-container label{
                font-family: Titoli-Skateboard;
                font-size: 1.5rem;
                text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
            }
            #assePrezzo, #asseDescription, #carrelloPrezzo, #carrelloDescription, #cuscinettiPrezzo, #cuscinettiDescription, #ruotePrezzo, #ruoteDescription {
                font-family: Font-Carino;
                text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
            }

            .select-container select {
    width: 70%;
    padding: 0.5em;
    border: none;
    border-radius: 0.25rem;
    background-color: #f2f2f2;
    font-size: 1em;
    color: #444;
    -webkit-appearance: none; /* rimuove l'aspetto predefinito in Chrome e Safari */
    -moz-appearance: none; /* rimuove l'aspetto predefinito in Firefox */
    appearance: none; /* rimuove l'aspetto predefinito */
}

.select-container::after {
    content: "\25BC"; /* freccia verso il basso */
    position: absolute;
    right: 0.5em;
    top: 50%;
    transform: translateY(-50%);
    pointer-events: none; /* rende cliccabile l'elemento sottostante */
}

            .gray-icon {
                color: gray;
            }

            .special-char {
                font-family: Arial, sans-serif;
            }

            .select-container {
        display: flex; /* Aggiunto per posizionare gli elementi uno accanto all'altro */
    }
    .prezzo {
        margin-left: 0.625rem; /* Aggiunto per creare dello spazio tra la select e il prezzo */
    }
    input[type='radio'] {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    width: 1.25rem;
    height: 1.25rem;
    background-color: white;
    border: 0.0625rem solid #c0c0c0;
    outline: none;
    position: relative;
}

input[type='radio']:checked {
    background-color: #c0c0c0;
}

input[type='radio']:checked::after {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0.625rem;
    height: 0.625rem;
    background: white;
    transform: translate(-50%, -50%);
    border-radius: 50%; /* Aggiunto per rendere il pseudo-elemento un cerchio */
}
#cart-container {
        width: 70%; /* Imposta la larghezza del carrello */
        height: auto; /* Imposta l'altezza del carrello */
        margin: 2% auto 20%; /* Centra il quadrato orizzontalmente */
        border: 0.0625rem solid #000; /* Aggiunge un bordo al quadrato */
        background-color: white;
        border-radius: 0.375rem;
    }
    #cart-title {
        text-align: center; /* Centra il testo orizzontalmente */
        font-size: 300%; /* Rende il testo più grande */
        font-family: Arial, Helvetica, sans-serif;
    }
    .container-roba {
        width: 90%; /* Imposta la larghezza del carrello */
        height: auto; /* Imposta l'altezza del carrello */
        margin: 2% auto 20%; /* Centra il quadrato orizzontalmente */
        border: 0.0625rem solid #000; /* Aggiunge un bordo al quadrato */
        background-color: #f2f2f2;
        border-radius: 0.375rem;
    }
    .order-title {
        text-align: center; /* Centra il testo orizzontalmente */
        font-size: 200%; /* Rende il testo più grande */
        font-family: Arial, Helvetica, sans-serif;
    }
    .switch {
  position: relative;
  display: inline-block;
  width: 2.75rem;
  height: 1.125rem;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  border: 2px solid black;
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 0.625rem;
  width: 0.625rem;
  left: 0.25rem;
  bottom: 0.125rem;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #4CAF50;
}

input:focus + .slider {
  box-shadow: 0 0 0.0625rem #4CAF50;
}

input:checked + .slider:before {
  -webkit-transform: translateX(1.625rem);
  -ms-transform: translateX(1.625rem);
  transform: translateX(1.625rem);
}

/* Rounded sliders */
.slider.round {
  border-radius: 1.125rem;
}

.slider.round:before {
  border-radius: 50%;
}
.slideshow{
    display: none;
    position: relative;
    max-width: 37.5rem;
    margin: auto;
}
.slide{
    display: none;
    overflow: hidden;
    margin-top: 35%;
    background-color: rgba(238, 191, 112, 0.5);
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
    border: 0.125rem solid red;
    border-radius: 0.5rem;
    transition: transform 0.3s ease;
    padding-bottom: 1rem;
}
.slide:first-child{
    display: block;
}
.slide a {
                display: block;
                width: 100%;
                height: 100%;
                text-decoration: none;
            }
.dot-container {
  position: absolute;
  bottom: 0.625rem;
  left: 50%;
  transform: translateX(-50%);
  text-align: center;
}

.dot {
  height: 0.9375rem;
  width: 0.9375rem;
  margin: 0 0.125rem;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active {
  background-color: #717171;
}
button.admin {
    font-family: Titoli-Skateboard;
    text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
    background-color: #eebf70; /* Colore di sfondo */
    border: none; /* Rimuove il bordo */
    color: white; /* Colore del testo */
    padding: 0.9375rem 2rem; /* Spazio intorno al testo */
    text-align: center; /* Allinea il testo al centro */
    text-decoration: none; /* Rimuove il sottolineato */
    display: inline-block;
    font-size: 1rem; /* Dimensione del testo */
    margin: 0.25rem 0.125rem;
    cursor: pointer; /* Cambia il cursore quando si passa sopra */
    border-radius: 0.25rem; /* Angoli arrotondati */
}
@media (max-width: 900px) {
                .container{
                    flex-direction: column;
                }
                .image-container-sell{
                    width: 85%;
                    margin: 0 auto;
                }
    .form-container {
        width: 80%;
        margin: 0 auto;
    }
}
@media (max-width: 600px) {
    .image-container-sell{
        width: 88%;
    }
}
@media (max-width: 900px) {
    .radio-option{
        display: block;
        margin-bottom: 0.5em; /* aggiungi un po' di spazio sotto ciascun pulsante radio */
    }
}
@media (min-width: 901px) {
    .radio-option {
        display: inline-block; /* rendi ciascun div inline-block, così ciascuno sarà sulla stessa linea */
        margin-bottom: 0; /* rimuovi lo spazio sotto ciascun div */
    }
}
@media (max-width: 600px) {
        .navbar {
            display: flex;
            flex-direction: center;
            align-items: center;
            justify-content: center;
            padding-bottom: 5%;
        }

        .navbar .links,
        .navbar .icons {
            flex-direction: column;
            flex-wrap: wrap;
            width: 100%;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        .navbar .links a {
        font-size: 0.8rem; /* Riduci la dimensione del font */
        }
        .navbar .logo {
            width: 1.5625rem;
        }

        .navbar .logo-name {
            font-size: 1rem; /* Riduci la dimensione delle scritte */
        }
        .image-caption{
            font-size: 1rem;
        }
        .image-container{
            display: none;
        }
        .slideshow{
            display: block;
        }
    }
        </style>
    </head>

    <body>

        <div class="navbar">
            <a href="catalogo.jsp" class="a1">
                <img src="immagini/gatto-skate.png" alt="Logo" class="logo">
            </a>
                <div class="logo-name"><a href="catalogo.jsp" class="a1">YourSkates <i class="fa fa-home" style="margin-left: 0.625rem;"></i></a></div> 
            <div class="icons">
                <a href="utente.jsp"><i class="fa fa-user"></i></a>
                <a href="carrello.jsp"><i class="fa fa-shopping-cart"></i></a>
            </div>
        </div>
        <main>