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
            body{
                overflow-x: hidden;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background-image: url('immagini/sfondo.jpg');
                background-repeat: no-repeat;
                background-attachment: fixed;
                background-size: cover;
                background-position: center 100px;
                background-color: black;
            }
            .navbar {
                width: 100%;
                overflow: auto;
                box-sizing: border-box;
                display: flex;
                align-items: center;
                background-color: black;
                border-bottom: #ffffff 0.125rem solid;
            }

            .navbar a,
            .navbar img,
            .navbar i {
                color: #f2f2f2;
                padding: 14px 16px;
                text-decoration: none;
                user-select: none;
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
            }

            .logo-name {
                color: #fff;
                font-size: 1.5625rem;
                font-weight: bold;
                margin-right: auto;
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
                background-position: center;
                background-repeat: no-repeat;
                background-size: cover;
                border: 0.125rem solid white;
            }

            .image-container a {
                display: block;
                width: 100%;
                height: 100%;
                text-decoration: none;
            }

            .image-caption {
                text-align: center;
                font-size: 30px;
                font-weight: bold;
                color: white;
                text-decoration: none;
            }

            .image-caption2 {
                text-align: center;
                font-size: 1.875rem;
                font-weight: bold;
                color: black;
                text-decoration: none;
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
            }
            footer {
                flex-shrink: 0;
                background-color: black;
                color: white;
                text-align: center;
                padding: 0.625rem;
                left: 0;
                bottom: 0;
                width: 100%;
                margin-top: 15%;
                border-top: #ffffff 0.125rem solid;
            }

            .form-container {
                width: 40%;
                padding: 1.25rem;
                background-color: white;
                border-radius: 0.625rem;
                margin-right: 22%;
                margin-top: 0.4%;
            }

            .form-container3 {
                width: 10%;
                padding: 1.25rem;
                background-color: lightgreen;
                border-radius: 0.625rem;
                margin-right: 22%;
            }

            .gray-icon {
                color: gray;
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
        background-color: #e7dcf2;
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
  bottom: 0.25rem;
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

@media (max-width: 600px) {
        .navbar {
            display: flex;
            flex-direction: center;
            align-items: center;
            justify-content: center;
        }

        .navbar .links,
        .navbar .icons {
            flex-direction: column;
            width: 100%;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        .navbar .logo {
            width: 1.5625; /* Riduci la larghezza del logo */
        }

        .navbar .logo-name {
            font-size: 1rem; /* Riduci la dimensione delle scritte */
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
            <div class="links">
                <a href="catalogo.jsp">Prodotti</a>
            </div>
            <div class="icons">
                <a href="utente.jsp"><i class="fa fa-user"></i></a>
                <a href="carrello.jsp"><i class="fa fa-shopping-cart"></i></a>
            </div>
        </div>
        <main>