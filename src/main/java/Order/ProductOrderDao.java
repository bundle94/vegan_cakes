package Order;

import Store.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.ConnectionPool;
import utils.DBUtil;


public class ProductOrderDao {
            
    public int create(ProductOrder productOrder) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        int generatedkey = 0;
 
        String query
                = "INSERT INTO order_details (order_id, product_id, quantity, price, date_created) "
                + "VALUES (?, ?, ?, ?, CURDATE())";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, productOrder.getOrderId());
            ps.setInt(2, productOrder.getProductId());
            ps.setInt(3, productOrder.getQuantity());
            ps.setString(4, productOrder.getPrice());
            ps.setString(5, productOrder.getSizes());
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
    
    public List<ProductOrderCpanel> getProductsByOrderId(int id) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<ProductOrderCpanel> list = new ArrayList();
 
        String query = "SELECT c.photo, c.category_id, c.name, o.* FROM order_details o join products c on c.id = o.product_id where o.order_id = " + id;
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            ProductOrderCpanel product = null;
            while (rs.next()) {
                product = new ProductOrderCpanel();
                product.setId(rs.getInt("id"));
                product.setOrderId(rs.getInt("order_id"));
                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setPhoto(rs.getBlob("photo"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getString("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setDelivered(rs.getBoolean("delivered"));
                product.setDateCreated(rs.getDate("date_created"));
                product.setDateUpdated(rs.getDate("date_updated"));
                list.add(product);
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
    
    
    public int updateProductOrderDeliveryByProductOrderId(int productOrderId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE order_details SET date_updated = CURDATE(),"
                + "delivered = true "
                + "WHERE id = ?";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query);
            ps.setInt(1, productOrderId);
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
    
    
    public int updateProductOrderDeliveryByOrderId(int orderId) {
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
 
        String query = "UPDATE order_details SET date_updated = CURDATE(),"
                + "delivered = true "
                + "WHERE order_id = ?";
        try {
            connection.setAutoCommit(false); //transaction block start
            ps = connection.prepareStatement(query);
            ps.setInt(1, orderId);
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
}
