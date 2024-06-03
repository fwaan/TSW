<%@ page import="java.util.List" %>
<%@ page import="it.unisa.OrderBean, it.unisa.UserBean" %>
<%@ include file="header.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String userid = (String) session.getAttribute("userid");
    if (userid == null) {
%>
<style>
    .bottoneswitch {
        font-size: 1.25rem;
        letter-spacing: 0.05rem;
    }

    #registerForm input[type="submit"],
    #loginForm input[type="submit"] {
        font-size: 1.25rem;
        letter-spacing: 0.05rem;
    }

    #registerForm h2,
    #loginForm h2 {
        font-size: 2rem;
        letter-spacing: 0.1rem;
    }

    #registerForm h3,
    #loginForm h3 {
        font-size: 1.5rem;
        letter-spacing: 0.05rem;
    }

    #registerForm label,
    #loginForm label {
        font-size: 1.25rem;
        letter-spacing: 0.05rem;
    }

    .responsive-table strong {
        font-size: 1.25rem;
        letter-spacing: 0.05rem;
    }

    #registerForm {
        background-color: #f2f2f2;
        padding: 1.25rem;
        border-radius: 0.3125rem;
        max-width: 37.5rem;
        margin: 1rem auto 2rem auto;
        border: 0.0625rem solid #ccc;
        width: 100%;
    }

    #registerForm h2 {
        color: #333;
    }

    #registerForm label {
        color: #333;
        font-weight: bold;
    }

    #registerForm input[type="text"],
    #registerForm input[type="password"] {
        border: 1px solid #ccc;
        border-radius: 4px;
        padding: 10px;
        margin-bottom: 10px;
        width: 80%;
        box-sizing: border-box;
    }

    #registerForm input[type="submit"] {
        margin-top: 0.125rem;
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    #registerForm input[type="submit"]:hover {
        background-color: #45a049;
    }

    #registerForm table {
        width: 100%;
        margin-top: 20px;
    }

    #registerForm table th,
    #registerForm table td {
        text-align: center;
        padding: 10px;
    }

    .responsive-table {
        width: 100%;
        overflow-x: auto;
    }

    #loginForm {
        background-color: #f2f2f2;
        padding: 1.25rem;
        border-radius: 0.3125rem;
        max-width: 37.5rem;
        margin: 1rem auto 2rem auto;
        border: 0.0625rem solid #ccc;
        width: 100%;
    }

    #loginForm h2 {
        color: #333;
    }

    #loginForm label {
        color: #333;
        font-weight: bold;
    }

    #loginForm input[type="text"],
    #loginForm input[type="password"] {
        border: 1px solid #ccc;
        border-radius: 4px;
        padding: 10px;
        margin-bottom: 10px;
        width: 80%;
        box-sizing: border-box;
    }

    #loginForm input[type="submit"] {
        margin-top: 0.125rem;
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    #loginForm input[type="submit"]:hover {
        background-color: #45a049;
    }

    #loginForm table {
        width: 100%;
        margin-top: 20px;
    }

    #loginForm table th,
    #loginForm table td {
        text-align: center;
        padding: 10px;
    }

    .responsive-table {
        width: 100%;
        overflow-x: auto;
    }

    #loginForm label,
    #registerForm label,
    #loginForm h2,
    #registerForm h2,
    #loginForm h3,
    #registerForm h3 {
        font-family: Titoli-Skateboard;
        text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
    }

    #loginForm button,
    #registerForm button,
    #loginForm input[type="submit"],
    #registerForm input[type="submit"] {
        font-family: Titoli-Skateboard;
        text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
    }

    #loginForm button,
    #registerForm button {
        margin-top: 0.125rem;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    #loginForm button,
    #registerForm button {
        background-color: #4CAF50;
    }

    .responsive-table div strong {
        font-family: Titoli-Skateboard;
        text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
        color: #333;
    }

    @media (max-width: 650px) {
        #loginForm {
            padding: 10px;
        }

        #loginForm input[type="text"],
        #loginForm input[type="password"] {
            width: 80%;
            /* Imposta la larghezza al 100% per occupare tutto lo spazio disponibile */
            box-sizing: border-box;
            /* Include padding e border nella larghezza totale */
        }

        #loginForm .responsive-table {
            width: 100%;
            /* Imposta la larghezza al 100% per occupare tutto lo spazio disponibile */
        }

        #registerForm {
            padding: 10px;
        }

        #registerForm input[type="text"],
        #registerForm input[type="password"] {
            width: 80%;
            /* Imposta la larghezza al 100% per occupare tutto lo spazio disponibile */
            box-sizing: border-box;
            /* Include padding e border nella larghezza totale */
        }

        #registerForm .responsive-table {
            width: 100%;
            /* Imposta la larghezza al 100% per occupare tutto lo spazio disponibile */
        }

        .responsive-table {
            display: block;
            width: 100%;
            /* Imposta la larghezza al 100% per occupare tutto lo spazio disponibile */
            min-width: 0;
            overflow-x: auto;
        }

        .responsive-table div input {
            width: 100%;
            min-width: 0;
        }

        #loginForm,
        #registerForm {
            width: 100%;
            padding: 1rem;
        }
    }

    /* Stili specifici per schermi di dimensioni inferiori a 650px */
    @media (max-width: 650px) {

        #loginForm,
        #registerForm {
            max-width: 80%;
            font-size: 0.875rem;
        }
    }

    /* Stili specifici per schermi di dimensioni comprese tra 600px e 1200px */
    @media (min-width: 650px) and (max-width: 1200px) {

        #loginForm,
        #registerForm {
            max-width: 75%;
            font-size: 0.9rem;
        }
    }

    /* Stili specifici per schermi di dimensioni superiori a 1200px */
    @media (min-width: 1200px) {

        #loginForm,
        #registerForm {
            max-width: 50%;
            font-size: 1.25rem;
        }
    }
</style>
<div id="loginForm">
    <h2 >Login</h2>
    <form action="ProductControl?action=loginutente" method="post">
        <input type="hidden" name="action" value="login">
        <label for="loginUserid" >E-mail:</label><br>
        <input type="text" id="loginUserid" name="userid" required><br>
        <label for="loginPassword" >Password:</label><br>
        <input type="password" id="loginPassword" name="password" required>
        <button type="button" onmousedown="showPassword('loginPassword')" onmouseup="hidePassword('loginPassword')"><i class="fa fa-eye" aria-hidden="true"></i></button><br>
        <input type="submit" value="Login">
    </form>
    <h3 > Non hai un account? </h3><button class="bottoneswitch" onclick="showRegisterForm()">Registrati</button>
</div>



<div id="registerForm" style="display: none;">
    <h2>Registrazione</h2>
    <form action="ProductControl?action=registrautente" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="action" value="register">
        <label for="registerUserid" >E-mail:</label><br>
        <input type="text" id="registerUserid" name="userid" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required><br>
        <label for="registerPassword">Password:</label><br>
        <input type="password" id="registerPassword" name="password" required>
        <button type="button" onmousedown="showPassword('registerPassword')" onmouseup="hidePassword('registerPassword')"><i class="fa fa-eye" aria-hidden="true"></i></button><br>
        <label for="confirmPassword">Conferma Password:</label><br>
        <input type="password" id="confirmPassword" name="confirmPassword" required>
        <button type="button" onmousedown="showPassword('confirmPassword')" onmouseup="hidePassword('confirmPassword')"><i class="fa fa-eye" aria-hidden="true"></i></button><br>
        <div class="responsive-table" style="background-color: #f2f2f2; color: black; display: flex; flex-direction: column;">
            <div style="display: flex; flex-direction: row; align-items: center;">
                <div style="flex: 1;"><strong>Indirizzo</strong></div>
                <div style="flex: 1;"><input type="text" name="indirizzo" value="" required style="min-width: 8rem; width: 90%; box-sizing: border-box;"></div>
            </div>
            <div style="display: flex; flex-direction: row; align-items: center;">
                <div style="flex: 1;"><strong>Città</strong></div>
                <div style="flex: 1;"><input type="text" name="citta" value="" required style="min-width: 8rem; width: 90%; box-sizing: border-box;"></div>
            </div>
            <div style="display: flex; flex-direction: row; align-items: center;">
                <div style="flex: 1;"><strong>Provincia</strong></div>
                <div style="flex: 1;"><input type="text" name="provincia" value="" required style="min-width: 8rem; width: 90%; box-sizing: border-box;"></div>
            </div>
            <div style="display: flex; flex-direction: row; align-items: center;">
                <div style="flex: 1;"><strong>CAP</strong></div>
                <div style="flex: 1;"><input type="text" name="cap" value="" maxlength="10" required style="min-width: 4rem; width: 90%; box-sizing: border-box;"></div>
            </div>
        </div>
        <input type="submit" value="Registra">
    </form>
    <h3 > Hai già un account? </h3><button class="bottoneswitch" onclick="showLoginForm()">Accedi</button>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        $('#registerUserid').blur(function () {
            var email = $(this).val();
            $.ajax({
                url: 'ProductControl',
                method: 'POST',
                data: {
                    action: 'verificaEmail',
                    email: email
                },
                success: function (data) {
                    if (data.exists) {
                        alert('Email già registrata');
                        $('#registerUserid').val('');
                    }
                }
            });
        });
    });

function validateForm() {
    var email = document.getElementById('registerUserid').value;
    var password = document.getElementById('registerPassword').value;
    var confirmPassword = document.getElementById('confirmPassword').value;

    var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailPattern.test(email)) {
        alert('Per favore inserisci un indirizzo email valido.');
        return false;
    }

    if (password != confirmPassword) {
        alert('Le password non coincidono.');
        return false;
    }

    return true;
}

function showPassword(inputId) {
    document.getElementById(inputId).type = 'text';
}

function hidePassword(inputId) {
    document.getElementById(inputId).type = 'password';
}

function showRegisterForm() {
    document.getElementById('loginForm').style.display = 'none';
    document.getElementById('registerForm').style.display = 'block';
}

function showLoginForm() {
    document.getElementById('registerForm').style.display = 'none';
    document.getElementById('loginForm').style.display = 'block';
}
</script>
<%
    } else {
        UserBean user = (UserBean) request.getSession().getAttribute("user");
        List<OrderBean> orders = (List<OrderBean>) request.getAttribute("ordini");
        if(orders == null){
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/ProductControl?action=ordini");
            dispatcher.forward(request, response);
            return;
        }
        String tipo = (String) session.getAttribute("tipo");
        if (tipo != null && tipo.equals("Admin")){
            %>
            <button class="admin" type="button" onclick="location.href='amministratore-yourskates.jsp'">Pagina admin</button>
            <%
            
        }
        if(tipo != null) {
%>
<style>
    /* Stili generali del modulo */
    #payment-form {
        width: 100%;
        max-width: 600px;
        margin: 0;
        padding: 20px;
        background-color: #fff;
        border-radius: 4px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    /* Stili per i campi del modulo */
    #payment-form input[type="text"],
    #payment-form select {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        margin-bottom: 10px;
    }

    /* Stili per il pulsante di invio */
    #payment-form input[type="submit"] {
        width: 100%;
        padding: 10px;
        border: none;
        background-color: #007BFF;
        color: #fff;
        border-radius: 4px;
        cursor: pointer;
        font-size: 1.1rem;
    }

    /* Cambia il colore di sfondo al passaggio del mouse */
    #payment-form input[type="submit"]:hover {
        background-color: #0056b3;
    }

    /* Stili per i campi del modulo quando sono in focus */
    #payment-form input[type="text"]:focus,
    #payment-form select:focus {
        border-color: #007BFF;
        outline: none;
    }

    /* Stili per i campi del modulo quando sono validi */
    #payment-form input[type="text"]:valid,
    #payment-form select:valid {
        border-color: #28a745;
    }

    /* Stili per i campi del modulo quando sono non validi */
    #payment-form input[type="text"]:invalid,
    #payment-form select:invalid {
        border-color: #dc3545;
    }

    /* Stili per i campi del modulo disabilitati */
    #payment-form input[type="text"]:disabled,
    #payment-form select:disabled {
        background-color: #e9ecef;
    }

    /* Stili per le etichette del modulo */
    #payment-form label {
        font-weight: bold;
        display: block;
        margin-bottom: 5px;
    }

    .recapito-utente {
        width: 100%;
        border-collapse: collapse;
    }

    .recapito-utente th,
    .recapito-utente td {
        border: 1px solid #ddd;
        padding: 0.5rem;
        text-align: left;
    }

    .recapito-utente th {
        background-color: #4CAF50;
        color: black;
    }

    .recapito-utente tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    .recapito-utente input[type="text"] {
        width: 100%;
        padding: 0.5rem;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .recapito-utente input[type="submit"] {
        width: 100%;
        height: 1.5rem;
        border-radius: 0.25rem;
        font-weight: bolder;
        font-size: 1.1rem;
        min-width: 13.1rem;
    }

    #payment-method-exists {
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        width: 100%;
        max-width: 600px;
        border-radius: 0.25rem;
        padding: 1rem;
        margin-bottom: 1rem;
    }
    #payment-method-exists h2 {
        margin-bottom: 0.5rem;
    }
    #payment-method-exists button {
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 0.25rem;
        padding: 0.5rem 1rem;
        cursor: pointer;
    }
    #payment-method-exists button:hover {
        background-color: #0056b3;
    }

    /* Stili per rendere il modulo responsive */
    @media (max-width: 650px) {
        #payment-method-exists{
            padding: 0;
            margin-right: 0.75rem;
        }
        #payment-form {
            padding: 0;
        }

        .recapito-utente {
            width: 100%;
        }

        .recapito-utente input[type="text"] {
            width: 100%;
        }

        .recapito-utente input[type="submit"] {
            width: 100%;
            height: 2rem;
            /* Aumenta l'altezza del pulsante su dispositivi mobili */
            font-size: 1.2rem;
            /* Aumenta la dimensione del font del pulsante su dispositivi mobili */
            min-width: 0;
            /* Rimuove la larghezza minima del pulsante su dispositivi mobili */
        }
    }
</style>
    <h2 style="color: black;text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white; font-family: Titoli-Skateboard; font-size: 2rem;">Benvenuto, <span style="color: black;text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white; font-family: Font-Carino; font-size: 2rem;"><%= userid %></span>!</h2>
    <form action="ProductControl?action=logoututente" method="post">
        <input type="hidden" name="action" value="logout">
        <input type="submit" value="Logout" style="font-family: Titoli-Skateboard;
        text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;
        background-color: #eebf70; 
        border: none; 
        color: white; 
        padding: 0.9375rem 2rem; 
        text-align: center; 
        text-decoration: none; 
        display: inline-block;
        font-size: 1rem;
        margin: 0.25rem 0.125rem;
        cursor: pointer;
        border-radius: 0.25rem;">
    </form>
    <div style="display: flex; align-items: center;">
        <label class="switch" style="margin-top: 0.625rem;">
            <input type="checkbox" id="toggleSwitch">
            <span class="slider round"></span>
        </label>
        <p style="color: black; font-family: Titoli-Skateboard; margin-left: 0.625rem; font-size: 1.25rem;">Informazioni utente</p>
    </div>
    <div id="userInfo" style="display: none;">
        <form action="ProductControl?action=changeUserLocation" method="post">
            <input type="hidden" name="userid" value="<%= user.getUserid() %>">
            <div style="max-width: 650px;">
                <table class="recapito-utente" style="background-color: white; color: black; border: 0.125rem solid black; width: 100%; height: 10%; border-collapse: collapse;">
                    <tr>
                        <th style="border: 0.125rem solid black;text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;font-family: Titoli-Skateboard;">Indirizzo</th>
                        <th style="border: 0.125rem solid black;text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;font-family: Titoli-Skateboard">Città</th>
                        <th style="border: 0.125rem solid black;text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;font-family: Titoli-Skateboard">Provincia</th>
                        <th style="border: 0.125rem solid black;text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;font-family: Titoli-Skateboard">CAP</th>
                    </tr>
                    <tr>
                        <td style="border: 0.125rem solid black;"><input type="text" name="indirizzo" value="<%= user.getIndirizzo() != null ? user.getIndirizzo() : "" %>" required style="width: 100%; box-sizing: border-box;"></td>
                        <td style="border: 0.125rem solid black;"><input type="text" name="citta" value="<%= user.getCitta() != null ? user.getCitta() : "" %>" required style="width: 100%; box-sizing: border-box;"></td>
                        <td style="border: 0.125rem solid black;"><input type="text" name="provincia" value="<%= user.getProvincia() != null ? user.getProvincia() : "" %>" required style="width: 100%; box-sizing: border-box;"></td>
                        <td style="border: 0.125rem solid black;"><input type="text" name="cap" value="<%= user.getCAP() != null ? user.getCAP() : "" %>" maxlength="10" required style="width: 100%; box-sizing: border-box;"></td>
                    </tr>
                </table>
                <input type="submit" value="EFFETTUA MODIFICHE" style="width: 100%; height: 1.5rem; border-radius: 0.25rem; font-weight: bolder; font-size: 1.1rem; min-width: 13.1rem;">
            </div>
        </form>
        <br>
        <div id="payment-method-exists" style="display: none;">
            <h2>Metodo di pagamento esistente: <span id="existing-payment-method"><%= user.getMetodoPagamento() %></span></h2>
            <button id="modify-button">MODIFICA</button>
        </div>
        <form action="ProductControl?action=changeUserPM" method="post" id="payment-form" style="display: none;">
            <input type="hidden" name="userid" value="<%= user.getUserid() %>">
            <label for="payment-method">Metodo di pagamento:</label>
            <select id="payment-method" name="payment-method">
                <option value="credit-card">Carta di credito</option>
                <option value="paypal">PayPal</option>
            </select>
            <div id="credit-card-info">
                <label for="card-number">Numero della carta:</label>
                <input type="text" id="card-number" name="card-number" required>
                <label for="expiry-date">Data di scadenza:</label>
                <input type="text" id="expiry-date" name="expiry-date" required>
                <label for="cvv">CVV:</label>
                <input type="text" id="cvv" name="cvv">
            </div>
            <input type="submit" value="Aggiorna metodo di pagamento">
        </form>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var paymentMethodExists = '<%= user.getMetodoPagamento() != null && !"".equals(user.getMetodoPagamento()) %>';
            var paymentForm = document.getElementById('payment-form');
            var paymentMethodExistsDiv = document.getElementById('payment-method-exists');
            var modifyButton = document.getElementById('modify-button');
            if (paymentMethodExists === "true") {
                paymentMethodExistsDiv.style.display = 'block';
                paymentForm.style.display = 'none';
            } else {
                paymentForm.style.display = 'block';
                paymentMethodExistsDiv.style.display = 'none';
            }
            modifyButton.addEventListener('click', function () {
                paymentMethodExistsDiv.style.display = 'none';
                paymentForm.style.display = 'block';
            });
        });
        document.getElementById('payment-method').addEventListener('change', function () {
            var paymentMethod = this.value;
            var creditCardInfo = document.getElementById('credit-card-info');
            var cardNumber = document.getElementById('card-number');
            var expiryDate = document.getElementById('expiry-date');
            if (paymentMethod === 'paypal') {
                creditCardInfo.style.display = 'none';
                cardNumber.required = false;
                expiryDate.required = false;
            } else {
                creditCardInfo.style.display = 'block';
                cardNumber.required = true;
                expiryDate.required = true;
            }
        });
        document.getElementById('toggleSwitch').addEventListener('click', function () {
            var userInfo = document.getElementById('userInfo');
            if (userInfo.style.display === 'none') {
                userInfo.style.display = 'block';
            } else {
                userInfo.style.display = 'none';
            }
        });
    </script>
    <p style="color: black; text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white; font-family: Titoli-Skateboard; font-size: 2rem;">Qui è la tua lista degli ordini:</p>
    <%
    if (orders != null && !orders.isEmpty()) {
%>
<style>
    .responsive-table-container {
        overflow-x: auto;
    }

    table {
        border-collapse: collapse;
        width: 100%;
        /* Aggiunto per rendere la tabella reattiva */
    }

    td,
    th {
        font-weight: bold;
        font-family: Roboto-Serif;
        border: 0.1875rem solid #333;
        padding: 0;
        /* Rimuovi padding dalla cella della tabella */
        min-width: 6.25rem;
        text-align: center;
    }

    .img-column {
        width: 25%;
        height: auto;
    }

    .img-column img {
        width: 100%;
        height: auto;
    }

    .full-width-button {
        width: 100%;
        height: 3.125rem;
    }

    .delete-button {
        display: block;
        /* Imposta il display a block */
        width: 100%;
        height: 100%;
        padding: 100% 0;
        background-color: red;
    }

    .fa-trash {
        font-size: 4rem;
        /* Imposta la dimensione dell'icona */
    }

    .invoiceButton {
        background-color: #4CAF50;
        /* Green */
        border: none;
        color: white;
        padding: 15px 32px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
        border-radius: 12px;
        transition-duration: 0.4s;
    }

    .invoiceButton:hover {
        background-color: #45a049;
    }

    .idcell{
        display: flex;
        flex-direction: column;
        align-items: center;
        height: 100%;
    }

    @media (max-width: 37.5rem) {

        td,
        th {
            min-width: 3.125rem;
        }

        .fa-trash {
            font-size: 2rem;
        }
    }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css">
<script>
    $(document).ready(function () {
        $('#ordiniutente').DataTable({
                responsive: true,
				"columnDefs": [
					{ "searchable": false, "targets": [0, 2, 3, 4, 5 , 6, 7 , 8] },
                    { 
                        "type": "num", 
                        "targets": 8,
                        "render": function ( data, type, row ) {
                            var id = data.match(/\d+/)[0];
                            return type === 'display' ? data : parseFloat(id);
                        }
                    }
				],
				"language": {
					"search": "",
					"lengthMenu": "Mostra _MENU_ elementi",
					"info": "Mostra da _START_ a _END_ di _TOTAL_ elementi",
					"infoEmpty": "Mostra 0 a 0 di 0 elementi",
					"infoFiltered": "(filtrati da _MAX_ elementi totali)",
					"zeroRecords": "Nessun elemento trovato",
					"paginate": {
						"first": "Primo",
						"last": "Ultimo",
						"next": "Successivo",
						"previous": "Precedente"
					}
				}
			});
			$('.dataTables_filter label').prepend('<i class="fa fa-search"></i>');
            $(document).on('click', '.invoiceButton', function(){
            var orderId = $(this).data('order-id');
            $.ajax({
                url: 'ProductControl', // replace with the path to your invoice function
                type: 'POST',
                data: {
                    'action': 'generateInvoice',
                    'orderId': orderId
                },
                success: function (response) {
                    // Start polling for the invoice
                    var invoiceCheckInterval = setInterval(function () {
                        $.ajax({
                            url: 'ProductControl', // replace with the path to your check invoice function
                            type: 'POST',
                            data: {
                                'action': 'checkInvoice',
                                'orderId': orderId
                            },
                            success: function (response) {
                                if (response.invoiceReady) {
                                    clearInterval(invoiceCheckInterval);
                                    window.open(response.url, '_blank'); // this will start the download
                                }
                            },
                            error: function () {
                                // handle any errors
                                alert('Si è verificato un errore durante il controllo della fattura');
                            }
                        });
                    }, 5000); // Check every 3 seconds
                },
                error: function () {
                    // handle any errors
                    alert('Si è verificato un errore durante la generazione della fattura');
                }
            });
        });
    });
</script>

	<style>
		.dataTables_filter label {
			font-family: Titoli-Skateboard;
			color: black;
			font-size: 1.5rem;
			text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
		}
	
		.dataTables_filter input {
            margin-bottom: 0.375rem;
			font-size: 1.5rem !important;
			border: 2px solid black !important;
			background-color: white !important;
			border-radius: 24px !important;
			padding: 10px 20px !important;
			width: 300px !important;
			height: 44px !important;
			box-shadow: none !important;
			transition: box-shadow 200ms cubic-bezier(0.4, 0.0, 0.2, 1) !important;
		}
	
		.dataTables_filter input:focus {
			outline: none !important;
			box-shadow: 0 1px 6px 0 rgba(32, 33, 36, 0.28) !important;
		}

		.dataTables_length label {
			font-family: Font-Carino;
			color: black;
			font-size: 1.5rem;
			text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
		}
		
		.dataTables_info {
			font-family: Font-Carino;
			font-weight: bold;
			color: black;
			font-size: 1.25rem;
			text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
		}

		.dataTables_paginate {
        	font-family: Font-Carino;
			letter-spacing: 0.15rem;
			font-weight: bold;
			color: black;
			font-size: 1.25rem;
			text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;
    	}

		.dataTables_paginate a {
			color: black !important;
		}
		@media (max-width: 800px) {
			.dataTables_filter label {
				font-size: 1.25rem;
			}
			.datatables_length label {
				font-size: 1rem;
			}
			.dataTables_info {
				font-size: 1rem;
			}
			.dataTables_paginate {
				font-size: 1rem;
			}
		}
		@media (max-width: 800px) {
        .table-responsive-admin {
            overflow-x: auto;
            width: 100%;
        }
    }
	</style>
<div class="container-roba" style="background-color: #f8f9fa">
<h1 class="order-title">ORDINI</h1>
<div class="responsive-table-container" style="background-color: #f8f9fa">
<table id="ordiniutente">
    <thead>
        <tr>
            <th style="background-color: rgba(238, 191, 112, 1);">IMMAGINE</th>
            <th style="background-color: rgba(238, 191, 112, 1);">TIPO</th>
            <th style="background-color: rgba(238, 191, 112, 1);">COLORE</th>
            <th style="background-color: rgba(238, 191, 112, 1);">ASSE</th>
            <th style="background-color: rgba(238, 191, 112, 1);">CARRELLO</th>
            <th style="background-color: rgba(238, 191, 112, 1);">CUSCINETTI</th>
            <th style="background-color: rgba(238, 191, 112, 1);">RUOTE</th>
            <th style="background-color: rgba(238, 191, 112, 1);">PREZZO</th>
            <th style="background-color: rgba(238, 191, 112, 1);">ID</th>
        </tr>
    </thead>
    <% for (OrderBean order : orders) { 
        String imagePath="immagini/" ; 
        String tipoSkateboard = order.getTipoSkateboard().toLowerCase();
        if (tipoSkateboard.equals("skateboard")) { 
            imagePath +="skateboard" ; 
        } else if (tipoSkateboard.equals("longboard")) { 
            imagePath +="longboard" ; 
        } else if (tipoSkateboard.equals("cruiser")) { 
            imagePath +="cruiser" ; 
        } else {
            imagePath += "default"; // default image if tipoSkateboard is not valid
        }
        if (!order.getColore().equals("nero")) { 
            imagePath +="_" + order.getColore(); 
        } 
        imagePath +=".png" ; 
        String color = "";
        if (order.getColore().equals("nero")) {
            color = "black";
        } else if(order.getColore().equals("rosso")){
            color = "red";
        } else if(order.getColore().equals("verde")){
            color = "green";
        } else if(order.getColore().equals("blu")){
             color = "blue";
        }
    %>
            <tr>
                <td class="img-column"><img src="<%= imagePath %>" alt="<%= order.getTipoSkateboard() %>"></td>
                <td ><%= order.getTipoSkateboard() %></td>
                <td style="background-color: <%= color %>;"><span style="color: white;letter-spacing: 0.1rem; font-family: Titoli-Skateboard; text-shadow: -1px 0 #333, 0 1px #333, 1px 0 #333, 0 -1px #333; text-transform: uppercase; font-weight: bolder; font-family: Arial, Helvetica, sans-serif;"><%= order.getColore() %></span></td>
                <td><%= order.getNomeAsse() %></td>
                <td><%= order.getNomeCarrello() %></td>
                <td><%= order.getNomeCuscinetti() %></td>
                <td><%= order.getNomeRuote() %></td>
                <td><%= order.getPrezzo() %> €</td>
                <td><div class="idcell"><%= order.getId() %> <button class="invoiceButton" data-order-id="<%= order.getId() %>" style="font-family: Roboto-Serif; font-weight: 400;">Genera fattura</button></div></td>
            </tr>
    <% } %>
</table>
</div>
</div>
<%
    } else {
%>
    <p style="color: black; text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white; font-family: Titoli-Skateboard; font-weight: bold; font-size: 3rem;">Non hai ancora effettuato ordini.</p>
<%
    }
%>
<%
            }
    }
%>
<%
String utenteInesistente = (String) request.getAttribute("utenteinesistente");
if (utenteInesistente != null && utenteInesistente.equals("true")) {
%>
    <script>window.onload = function() {alert("ERRORE: utente inesistente");}</script>
<%
}
%>

<%
String passworderrata = (String) request.getAttribute("passworderrata");
if (passworderrata != null && passworderrata.equals("true")) {
%>
  <script>window.onload = function() {alert("ERRORE: password errata");}</script> 
<%
}
%>

<%
String registrato = (String) request.getAttribute("registrato");
if (registrato != null && registrato.equals("true")) {
%>
  <script>
  window.onload = function() {
    showRegisterForm();
    setTimeout(function() {
      alert("ERRORE: utente già registrato");
    }, 100); // ritarda la visualizzazione dell'alert di 100 millisecondi
  }
  </script> 
<%
}
%>
<%@ include file="footer.jsp" %>