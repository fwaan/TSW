package it.unisa;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.ArrayList;
import java.util.List;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ProductModelDS implements ProductModel {

	private static DataSource ds;

	static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/yourskates");

		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}

	private static final String TABLE_NAME = "prodotto";
	private static final String TABLE_NAME2 = "utente";

	@Override
	public synchronized void doSave(ProductBean prodotto) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + ProductModelDS.TABLE_NAME
				+ " (ID, TIPO, NOME, DESCRIZIONE, PREZZO, QUANTITA) VALUES (NULL, ?, ?, ?, ?, ?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, prodotto.getTipo());
			preparedStatement.setString(2, prodotto.getNome());
			preparedStatement.setString(3, prodotto.getDescrizione());
			preparedStatement.setFloat(4, prodotto.getPrezzo());
			preparedStatement.setInt(5, prodotto.getQuantita());

			preparedStatement.executeUpdate();

			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null){
					connection.setAutoCommit(true);
					connection.close();
				}
			}
		}
	}

	@Override
	public synchronized void doSaveUser(UserBean user) throws SQLException {

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        String insertSQL = "INSERT INTO " + ProductModelDS.TABLE_NAME2
                + " (userid, tipo, password_hash) VALUES (?, ?, ?)";

        try {
            connection = ds.getConnection();
            connection.setAutoCommit(false);
            preparedStatement = connection.prepareStatement(insertSQL);
            preparedStatement.setString(1, user.getUserid());
            preparedStatement.setString(2, user.getTipo());
            preparedStatement.setString(3, user.getPasswordHash());

            preparedStatement.executeUpdate();

            connection.commit();
        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null){
                    connection.setAutoCommit(true);
                    connection.close();
                }
            }
        }
    }

	@Override
	public synchronized void doSaveOrder(String userid, CartBean cart) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
	
		String insertSQL = "INSERT INTO ordine (userid, tipo_skateboard, colore, id_asse, id_carrello, id_cuscinetti, id_ruote, prezzo, indirizzo, citta, provincia, CAP) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		String updateQuantitySQL = "UPDATE prodotto SET quantita = quantita - 1 WHERE id = ?";
		String selectUserSQL = "SELECT indirizzo, citta, provincia, CAP FROM utente WHERE userid = ?";
	
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
	
			preparedStatement = connection.prepareStatement(selectUserSQL);
			preparedStatement.setString(1, userid);
			ResultSet rs = preparedStatement.executeQuery();
			String indirizzo = "", citta = "", provincia = "", CAP = "";
			if (rs.next()) {
				indirizzo = rs.getString("indirizzo");
				citta = rs.getString("citta");
				provincia = rs.getString("provincia");
				CAP = rs.getString("CAP");
			}
	
			for (SkateboardBean skateboard : cart.getSkateboards()) {
				List<ProductBean> components = skateboard.getComponents();
	
				preparedStatement = connection.prepareStatement(insertSQL);
				preparedStatement.setString(1, userid);
				preparedStatement.setString(2, skateboard.getTipo());
				preparedStatement.setString(3, skateboard.getColore());
				preparedStatement.setInt(4, components.get(0).getId()); // Asse
				preparedStatement.setInt(5, components.get(1).getId()); // Carrello
				preparedStatement.setInt(6, components.get(2).getId()); // Cuscinetti
				preparedStatement.setInt(7, components.get(3).getId()); // Ruote
				preparedStatement.setFloat(8, skateboard.getTotalPrice()); // Prezzo
				preparedStatement.setString(9, indirizzo); // Indirizzo
				preparedStatement.setString(10, citta); // Città
				preparedStatement.setString(11, provincia); // Provincia
				preparedStatement.setString(12, CAP); // CAP
	
				preparedStatement.executeUpdate();
				for (ProductBean component : components) {
					preparedStatement = connection.prepareStatement(updateQuantitySQL);
					preparedStatement.setInt(1, component.getId());
					preparedStatement.executeUpdate();
				}
			}
	
			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null) {
					connection.setAutoCommit(true);
					connection.close();
				}
			}
		}
	}

	public synchronized void doChange(ProductBean prodotto) throws SQLException {	
    	Connection connection = null;
    	PreparedStatement preparedStatement = null;

	    String updateSQL = "UPDATE " + ProductModelDS.TABLE_NAME
	            + " SET TIPO = ?, NOME = ?, DESCRIZIONE = ?, PREZZO = ?, QUANTITA = ? WHERE ID = ?";

	    try {
	        connection = ds.getConnection();
	        connection.setAutoCommit(false);
	        preparedStatement = connection.prepareStatement(updateSQL);
	        preparedStatement.setString(1, prodotto.getTipo());
	        preparedStatement.setString(2, prodotto.getNome());
	        preparedStatement.setString(3, prodotto.getDescrizione());
	        preparedStatement.setFloat(4, prodotto.getPrezzo());
	        preparedStatement.setInt(5, prodotto.getQuantita());
	        preparedStatement.setInt(6, prodotto.getId());

	        preparedStatement.executeUpdate();

	        connection.commit();
		} finally {
    	    try {
        	    if (preparedStatement != null)
        	        preparedStatement.close();
        	} finally {
        	    if (connection != null){
        	        connection.setAutoCommit(true);
        	        connection.close();
        	    }
        	}
    	}
	}

	public synchronized void doChangeUserLocation(UserBean utente) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
	
		String updateSQL = "UPDATE "+ ProductModelDS.TABLE_NAME2 
				+" SET indirizzo = ?, citta = ?, provincia = ?, CAP = ? WHERE userid = ?";
	
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setString(1, utente.getIndirizzo());
			preparedStatement.setString(2, utente.getCitta());
			preparedStatement.setString(3, utente.getProvincia());
			preparedStatement.setString(4, utente.getCAP());
			preparedStatement.setString(5, utente.getUserid());
	
			preparedStatement.executeUpdate();
	
			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null){
					connection.setAutoCommit(true);
					connection.close();
				}
			}
		}
	}

	public synchronized void doChangeUserPaymentMethod(UserBean utente) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
	
		String updateSQL = "UPDATE " + ProductModelDS.TABLE_NAME2 
				+ " SET metodo_pagamento = ? WHERE userid = ?";
	
		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(updateSQL);
			preparedStatement.setString(1, utente.getMetodoPagamento());
			preparedStatement.setString(2, utente.getUserid());
	
			preparedStatement.executeUpdate();
	
			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null){
					connection.setAutoCommit(true);
					connection.close();
				}
			}
		}
	}

	@Override
	public synchronized ProductBean doRetrieveByKey(int id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		ProductBean bean = new ProductBean();

		String selectSQL = "SELECT * FROM " + ProductModelDS.TABLE_NAME + " WHERE ID = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setId(rs.getInt("ID"));
				bean.setNome(rs.getString("NOME"));
				bean.setTipo(rs.getString("TIPO"));
				bean.setDescrizione(rs.getString("DESCRIZIONE"));
				bean.setPrezzo(rs.getFloat("PREZZO"));
				bean.setQuantita(rs.getInt("QUANTITA"));
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return bean;
	}

	public OrderBean doRetrieveByKeyOrder(int id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		OrderBean ordine = new OrderBean();

		String selectSQL = "SELECT * FROM ordine WHERE id = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				ordine.setId(rs.getInt("id"));
				ordine.setUserid(rs.getString("userid"));
				ordine.setTipoSkateboard(rs.getString("tipo_skateboard"));
				ordine.setColore(rs.getString("colore"));
				ordine.setIdAsse(rs.getInt("id_asse"));
				ordine.setIdCarrello(rs.getInt("id_carrello"));
				ordine.setIdCuscinetti(rs.getInt("id_cuscinetti"));
				ordine.setIdRuote(rs.getInt("id_ruote"));
				ordine.setPrezzo(rs.getFloat("prezzo"));
				ordine.setIndirizzo(rs.getString("indirizzo"));
				ordine.setCitta(rs.getString("citta"));
				ordine.setProvincia(rs.getString("provincia"));
				ordine.setCAP(rs.getString("CAP"));
				ordine.setDataOrdine(rs.getTimestamp("dataordine"));
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}

		return ordine;
	}
	
	@Override
	public UserBean doRetrieveByKeyUser(String userid) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String selectSQL = "SELECT * FROM utente WHERE userid = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, userid);

			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				UserBean bean = new UserBean();
				bean.setUserid(rs.getString("userid"));
				bean.setTipo(rs.getString("tipo"));
				bean.setPasswordHash(rs.getString("password_hash"));
				bean.setIndirizzo(rs.getString("indirizzo"));
				bean.setCitta(rs.getString("citta"));
				bean.setProvincia(rs.getString("provincia"));
				bean.setCAP(rs.getString("CAP"));
				bean.setMetodoPagamento(rs.getString("metodo_pagamento"));
				return bean;
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return null;
	}

	@Override
	public List<OrderBean> doRetrieveByUserid(String userid) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String selectSQL = "SELECT o.id, o.userid, o.tipo_skateboard, o.colore, o.id_asse, p1.nome AS nome_asse, o.id_carrello, p2.nome AS nome_carrello, o.id_cuscinetti, p3.nome AS nome_cuscinetti, o.id_ruote, p4.nome AS nome_ruote, o.prezzo "
				+
				"FROM ordine o " +
				"JOIN prodotto p1 ON o.id_asse = p1.id " +
				"JOIN prodotto p2 ON o.id_carrello = p2.id " +
				"JOIN prodotto p3 ON o.id_cuscinetti = p3.id " +
				"JOIN prodotto p4 ON o.id_ruote = p4.id " +
				"WHERE o.userid = ?";

		List<OrderBean> orders = new ArrayList<OrderBean>();

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, userid);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				OrderBean bean = new OrderBean();

				bean.setId(rs.getInt("id"));
				bean.setUserid(rs.getString("userid"));
				bean.setTipoSkateboard(rs.getString("tipo_skateboard"));
				bean.setColore(rs.getString("colore"));
				bean.setIdAsse(rs.getInt("id_asse"));
				bean.setNomeAsse(rs.getString("nome_asse"));
				bean.setIdCarrello(rs.getInt("id_carrello"));
				bean.setNomeCarrello(rs.getString("nome_carrello"));
				bean.setIdCuscinetti(rs.getInt("id_cuscinetti"));
				bean.setNomeCuscinetti(rs.getString("nome_cuscinetti"));
				bean.setIdRuote(rs.getInt("id_ruote"));
				bean.setNomeRuote(rs.getString("nome_ruote"));
				bean.setPrezzo(rs.getFloat("prezzo"));

				orders.add(bean);
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}

		return orders;
	}

	@Override
	public UserBean doCheckUser(String userid, String password) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String selectSQL = "SELECT * FROM " + ProductModelDS.TABLE_NAME2 + " WHERE userid = ? AND password_hash = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, userid);
			preparedStatement.setString(2, password);

			ResultSet rs = preparedStatement.executeQuery();

			if (rs.next()) {
				UserBean bean = new UserBean();
				bean.setUserid(rs.getString("userid"));
				bean.setTipo(rs.getString("tipo"));
				bean.setPasswordHash(rs.getString("password_hash"));
				bean.setIndirizzo(rs.getString("indirizzo"));
				bean.setCitta(rs.getString("citta"));
				bean.setProvincia(rs.getString("provincia"));
				bean.setCAP(rs.getString("CAP"));
				bean.setMetodoPagamento(rs.getString("metodo_pagamento"));
				return bean;
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return null;
	}

	public List<ProductBean> doRetrieveByType(String type) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
	
		// Create a list to store the products
		List<ProductBean> products = new ArrayList<ProductBean>();
	
		String selectSQL = "SELECT * FROM prodotto WHERE tipo = ?";
	
		try {
			connection = DriverManagerConnectionPool.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, type);
	
			ResultSet rs = preparedStatement.executeQuery();
	
			// For each row in the result set, create a new ProductBean and add it to the list
			while (rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setId(rs.getInt("ID"));
				bean.setNome(rs.getString("NOME"));
				bean.setTipo(rs.getString("TIPO"));
				bean.setDescrizione(rs.getString("DESCRIZIONE"));
				bean.setPrezzo(rs.getFloat("PREZZO"));
				bean.setQuantita(rs.getInt("QUANTITA"));
	
				products.add(bean);
			}
	
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				DriverManagerConnectionPool.releaseConnection(connection);
			}
		}
	
		return products;
	}
	
	@Override
	public synchronized boolean doDelete(int id) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + ProductModelDS.TABLE_NAME + " WHERE ID = ?";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, id);

			result = preparedStatement.executeUpdate();

			connection.commit();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null){
					connection.setAutoCommit(true);
					connection.close();
				}
			}
		}
		return (result != 0);
	}

	@Override
	public synchronized List<ProductBean> doRetrieveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
	
		List<ProductBean> prodotti = new ArrayList<ProductBean>();
	
		String selectSQL = "SELECT * FROM " + ProductModelDS.TABLE_NAME;
	
		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}
	
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
	
			ResultSet rs = preparedStatement.executeQuery();
	
			while (rs.next()) {
				ProductBean bean = new ProductBean();
	
				bean.setId(rs.getInt("ID"));
				bean.setTipo(rs.getString("TIPO"));
				bean.setNome(rs.getString("NOME"));
				bean.setDescrizione(rs.getString("DESCRIZIONE"));
				bean.setPrezzo(rs.getFloat("PREZZO"));
				bean.setQuantita(rs.getInt("QUANTITA"));
				prodotti.add(bean);
			}
	
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
	
		return prodotti;
	}

	public List<OrderBean> doRetrieveAllOrder() throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        List<OrderBean> orders = new ArrayList<OrderBean>();

        String selectSQL = "SELECT * FROM ordine";

        try {
            connection = ds.getConnection();
            preparedStatement = connection.prepareStatement(selectSQL);

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                OrderBean bean = new OrderBean();

                bean.setId(rs.getInt("id"));
                bean.setUserid(rs.getString("userid"));
                bean.setTipoSkateboard(rs.getString("tipo_skateboard"));
                bean.setColore(rs.getString("colore"));
                bean.setIdAsse(rs.getInt("id_asse"));
                bean.setIdCarrello(rs.getInt("id_carrello"));
                bean.setIdCuscinetti(rs.getInt("id_cuscinetti"));
                bean.setIdRuote(rs.getInt("id_ruote"));
                bean.setPrezzo(rs.getFloat("prezzo"));
                bean.setIndirizzo(rs.getString("indirizzo"));
                bean.setCitta(rs.getString("citta"));
                bean.setProvincia(rs.getString("provincia"));
                bean.setCAP(rs.getString("CAP"));
                bean.setDataOrdine(rs.getTimestamp("dataordine"));

                orders.add(bean);
            }

        } finally {
            try {
                if (preparedStatement != null)
                    preparedStatement.close();
            } finally {
                if (connection != null)
                    connection.close();
            }
        }

        return orders;
    }

	public Collection<ProductBean> getProductsByType(String tipo) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
	
		Collection<ProductBean> products = new LinkedList<ProductBean>();
	
		try {
			connection = ds.getConnection();
			String selectSQL = "SELECT * FROM prodotto WHERE tipo = ?";
	
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, tipo);
	
			ResultSet rs = preparedStatement.executeQuery();
	
			while (rs.next()) {
				ProductBean bean = new ProductBean();
	
				bean.setId(rs.getInt("id"));
				bean.setTipo(rs.getString("tipo"));
				bean.setNome(rs.getString("nome"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setPrezzo(rs.getFloat("prezzo"));
				bean.setQuantita(rs.getInt("quantita"));
	
				products.add(bean);
			}
	
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
	
		return products;
	}

}