package Store;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.ConnectionPool;
import utils.DBUtil;


public class StoreDao {
        
    public static List<Store> getProducts(int categoryId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Store> list = new ArrayList();
 
        String query = "SELECT * FROM products where category_id = " + categoryId;
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Store store = null;
            while (rs.next()) {
                store = new Store();
                store.setId(rs.getInt("id"));
                store.setCategoryId(rs.getInt("category_id"));
                store.setName(rs.getString("name"));
                store.setPrice(rs.getString("price"));
                store.setQuantity(rs.getInt("quantity"));
                store.setDateCreated(rs.getDate("date_created"));
                store.setDateUpdated(rs.getDate("date_updated"));
                store.setPhoto(rs.getBlob("photo"));
                list.add(store);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public Integer getProductQuantity(int productId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Store> list = new ArrayList();
 
        String query = "SELECT quantity FROM products where id = " + productId;
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Store store = null;
            while (rs.next()) {
                store = new Store();
                store.setQuantity(rs.getInt("quantity"));
                list.add(store);
            }
            return list.get(0).getQuantity();
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public int updateQuantity(int quantity, int productId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE products SET date_updated = CURDATE(),"
                + "quantity = ? "
                + "WHERE id = ?";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query);
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            ps.executeUpdate();
            connection.commit(); //transaction block end
            return 1;
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public List<Store> getAllProducts() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Store> list = new ArrayList();
 
        String query = "SELECT * FROM products order by id desc";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Store store = null;
            while (rs.next()) {
                store = new Store();
                store.setId(rs.getInt("id"));
                store.setCategoryId(rs.getInt("category_id"));
                store.setName(rs.getString("name"));
                store.setPrice(rs.getString("price"));
                store.setQuantity(rs.getInt("quantity"));
                store.setDateCreated(rs.getDate("date_created"));
                store.setDateUpdated(rs.getDate("date_updated"));
                store.setPhoto(rs.getBlob("photo"));
                list.add(store);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public int updateProductDetails(int quantity, String name, String price, int id) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE products SET date_updated = CURDATE(),"
                + "quantity = ?, name = ?, price = ?"
                + "WHERE id = ?";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query);
            ps.setInt(1, quantity);
            ps.setString(2, name);
            ps.setString(3, price);
            ps.setInt(4, id);
            ps.executeUpdate();
            connection.commit(); //transaction block end
            return 1;
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public int deleteProduct(int productid) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "DELETE FROM products "
                + "WHERE id = ?";
        try {
            connection.setAutoCommit(false); 
            ps = connection.prepareStatement(query);
            ps.setInt(1, productid);
            ps.executeUpdate();
            connection.commit();
            return 1;
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public int createProduct(String name, String price, InputStream image, int quantity, int categoryId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        int generatedkey = 0;
 
        String query
                = "INSERT INTO products (name, price, photo, quantity, category_id, date_created) "
                + "VALUES (?, ?, ?, ?, ?, CURDATE())";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, name);
            ps.setString(2, price);
            ps.setBlob(3, image);
            ps.setInt(4, quantity);
            ps.setInt(5, categoryId);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
               generatedkey=rs.getInt(1);
            }
 
            if (generatedkey > 0) {
 
            } else {
                connection.rollback();
                return 0;
            }
            connection.commit(); //transaction block end
            return generatedkey;
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
    public int getCountofProducts() {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs;
        
        String query = "SELECT count(*) FROM products";
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println(e);
            return 0;
        } finally {
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
}
