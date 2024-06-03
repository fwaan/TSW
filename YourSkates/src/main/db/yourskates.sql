DROP DATABASE IF EXISTS yourskates;
CREATE DATABASE yourskates;
USE yourskates;

DROP TABLE IF EXISTS prodotto;

CREATE TABLE prodotto (	
  id int primary key AUTO_INCREMENT,
  tipo ENUM('Asse', 'Carrello', 'Cuscinetti', 'Ruote') not null,
  nome varchar(50) not null,
  descrizione varchar(200),
  prezzo float default 10000,
  quantita int default 0
);

CREATE TABLE utente (
 userid varchar(255) primary key,
 tipo ENUM('Admin','Customer') default 'Customer' not null,
 password_hash CHAR(64) not null,
 indirizzo VARCHAR(255),
 citta VARCHAR(255),
 provincia VARCHAR(255),
 CAP VARCHAR(10),
 metodo_pagamento ENUM('Carta di credito', 'PayPal')
);

CREATE TABLE ordine (
    id int primary key AUTO_INCREMENT,
    userid varchar(255) not null,
    tipo_skateboard ENUM('Skateboard', 'Longboard', 'Cruiser'),
    colore ENUM('nero', 'rosso', 'blu', 'verde'),
    id_asse int not null,
    id_carrello int not null,
    id_cuscinetti int not null,
    id_ruote int not null,
    prezzo float not null,
    indirizzo VARCHAR(255) not null,
    citta VARCHAR(255) not null,
    provincia VARCHAR(255) not null,
    CAP VARCHAR(10) not null,
    dataordine TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userid) REFERENCES utente(userid),
    FOREIGN KEY (id_asse) REFERENCES prodotto(id),
    FOREIGN KEY (id_carrello) REFERENCES prodotto(id),
    FOREIGN KEY (id_cuscinetti) REFERENCES prodotto(id),
    FOREIGN KEY (id_ruote) REFERENCES prodotto(id)
);

INSERT INTO prodotto values (1,"Asse","Legno di frassino","Durevole e flessibile al punto giusto per gli skaters meno esperti",10,1000);
INSERT INTO prodotto values (2,"Ruote","Ruote di base nere","Ruote per novizi, perfette per il cemento armato",5,1000);
INSERT INTO prodotto values (3,"Cuscinetti","Gommini skateboard medi","Gommini per ogni tipo di skateboard",10,1000);
INSERT INTO prodotto values (4,"Carrello","Carrello in acciaio inox","Carrello durevole prodotto dalla YourSkates&Fabbrication",15,1000);
INSERT INTO prodotto values (5,"Asse","Legno di acero","Miglior legno per una tavola, durevole e flessibile come nessun altro",50,100);
INSERT INTO prodotto values (6,"Asse","Carbonio","Materiale per l'asse per i più esperti skaters[NON ADATTO A PRINCIPIANTI]",100,50);
INSERT INTO utente (userid, tipo, password_hash) values ("YourSkatesAdminUserID","Admin","0b575dc9bb48efa5fbf2eef15cb26c1129b3d5a085ba631e7f36b62bc912e1fb");