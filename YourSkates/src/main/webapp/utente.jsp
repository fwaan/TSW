<%@ page import="java.util.List" %>
<%@ page import="it.unisa.OrderBean, it.unisa.UserBean" %>
<%@ include file="header.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String userid = (String) session.getAttribute("userid");
    if (userid == null) {
%>

<div id="loginForm">
    <h2 style="color: white;">Login</h2>
    <form action="ProductControl?action=loginutente" method="post">
        <input type="hidden" name="action" value="login">
        <label for="loginUserid" style="color: white;">E-mail:</label><br>
        <input type="text" id="loginUserid" name="userid" required><br>
        <label for="loginPassword" style="color: white;">Password:</label><br>
        <input type="password" id="loginPassword" name="password" required>
        <button type="button" onmousedown="showPassword('loginPassword')" onmouseup="hidePassword('loginPassword')"><i class="fa fa-eye" aria-hidden="true"></i></button><br>
        <input type="submit" value="Login">
    </form>
    <h3 style="color: white;"> Non hai un account? </h3><button onclick="showRegisterForm()">Registrati</button>
</div>

<div id="registerForm" style="display: none;">
    <h2 style="color: white;">Registrazione</h2>
    <form action="ProductControl?action=registrautente" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="action" value="register">
        <label for="registerUserid" style="color: white;">E-mail:</label><br>
        <input type="text" id="registerUserid" name="userid" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required><br>
        <label for="registerPassword" style="color: white;">Password:</label><br>
        <input type="password" id="registerPassword" name="password" required>
        <button type="button" onmousedown="showPassword('registerPassword')" onmouseup="hidePassword('registerPassword')"><i class="fa fa-eye" aria-hidden="true"></i></button><br>
        <label for="confirmPassword" style="color: white;">Conferma Password:</label><br>
        <input type="password" id="confirmPassword" name="confirmPassword" required>
        <button type="button" onmousedown="showPassword('confirmPassword')" onmouseup="hidePassword('confirmPassword')"><i class="fa fa-eye" aria-hidden="true"></i></button><br>
        <input type="submit" value="Registra">
    </form>
    <h3 style="color: white;"> Hai già un account? </h3><button onclick="showLoginForm()">Accedi</button>
</div>


<script>

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
            <button type="button" onclick="location.href='amministratore-yourskates.jsp'">Pagina admin</button>
            <%
            
        }
        if(tipo != null) {
%>
    <h2 style="color: white;">Benvenuto, <%= userid %>!</h2>
    <form action="ProductControl?action=logoututente" method="post">
        <input type="hidden" name="action" value="logout">
        <input type="submit" value="Logout">
    </form>
    <div style="display: flex; align-items: center;">
        <label class="switch" style="margin-top: 0.625rem;">
            <input type="checkbox" id="toggleSwitch">
            <span class="slider round"></span>
        </label>
        <p style="color: white; margin-left: 0.625rem;">Informazioni utente</p>
    </div>
    <div id="userInfo" style="display: none;">
        <form action="ProductControl?action=changeUserLocation" method="post">
            <input type="hidden" name="userid" value="<%= user.getUserid() %>">
            <div style="width: 40%;">
                <table style="background-color: white; color: black; border: 0.125rem solid black; width: 100%; height: 10%; border-collapse: collapse;">
                    <tr>
                        <th style="border: 0.125rem solid black;">Indirizzo</th>
                        <th style="border: 0.125rem solid black;">Città</th>
                        <th style="border: 0.125rem solid black;">Provincia</th>
                        <th style="border: 0.125rem solid black;">CAP</th>
                    </tr>
                    <tr>
                        <td style="border: 0.125rem solid black;"><input type="text" name="indirizzo" value="<%= user.getIndirizzo() != null ? user.getIndirizzo() : "" %>" required></td>
                        <td style="border: 0.125rem solid black;"><input type="text" name="citta" value="<%= user.getCitta() != null ? user.getCitta() : "" %>" required></td>
                        <td style="border: 0.125rem solid black;"><input type="text" name="provincia" value="<%= user.getProvincia() != null ? user.getProvincia() : "" %>" required></td>
                        <td style="border: 0.125rem solid black;"><input type="text" name="cap" value="<%= user.getCAP() != null ? user.getCAP() : "" %>" maxlength="10" required></td>
                    </tr>
                </table>
                <input type="submit" value="EFFETTUA MODIFICHE" style="width: 100%; height: 1.5rem; border-radius: 0.25rem; font-weight: bolder; font-size: 1.1rem;">
            </div>
        </form>
    </div>
    <script>
        document.getElementById('toggleSwitch').addEventListener('click', function() {
            var userInfo = document.getElementById('userInfo');
            if (userInfo.style.display === 'none') {
                userInfo.style.display = 'block';
            } else {
                userInfo.style.display = 'none';
            }
        });
    </script>
    <p style="color: white;">Qui è la tua lista degli ordini:</p>
    <%
    if (orders != null && !orders.isEmpty()) {
%>
<style>
    table{
        border-collapse: collapse;
        width: 100%; /* Aggiunto per rendere la tabella reattiva */
    }
    td, th {
        border: 0.1875rem solid blueviolet;
        padding: 0; /* Rimuovi padding dalla cella della tabella */
        min-width: 6.25rem;
    }
    td{
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
        display: block; /* Imposta il display a block */
        width: 100%;
        height: 100%;
        padding: 100% 0;
        background-color: red;
    }
    .fa-trash {
        font-size: 4rem; /* Imposta la dimensione dell'icona */
    }
    @media (max-width: 37.5rem) {
        td, th {
            min-width: 3.125rem;
        }
        .fa-trash {
            font-size: 2rem;
        }
    }
</style>
<div class="container-roba">
<h1 class="order-title">ORDINI</h1>
<table>
    <tr>
        <th>Immagine</th>
        <th>Tipo Skateboard</th>
        <th>Colore</th>
        <th>Asse</th>
        <th>Carrello</th>
        <th>Cuscinetti</th>
        <th>Ruote</th>
        <th>Prezzo</th>
        <th>ID</th>
    </tr>
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
            <td style="background-color: <%= color %>;"><span style="color: white; text-transform: uppercase; font-weight: bolder; font-family: Arial, Helvetica, sans-serif;"><%= order.getColore() %></span></td>
            <td><%= order.getNomeAsse() %></td>
            <td><%= order.getNomeCarrello() %></td>
            <td><%= order.getNomeCuscinetti() %></td>
            <td><%= order.getNomeRuote() %></td>
            <td><%= order.getPrezzo() %> €</td>
            <td><%= order.getId() %></td>
        </tr>
    <% } %>
</table>
</div>
<%
    } else {
%>
    <p style="color: white;">Non hai ancora effettuato ordini.</p>
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