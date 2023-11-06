package Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.ConnectionPool;
import utils.DBUtil;


public class CategoryService {
    
    public String getCategoryNameById(int id) {
        
        ConnectionPool pool = ConnectionPool.getInstance();
        Connection connection = pool.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Category> list = new ArrayList();
 
        String query = "SELECT title FROM categories where id = " + id;
        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();
            Category category = null;
            while (rs.next()) {
                category = new Category();
                category.setTitle(rs.getString("title"));
                list.add(category);
            }
            if(list.size() < 1) {
                return null;
            }
            return list.get(0).getTitle();
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        } finally {
            DBUtil.closeResultSet(rs);
            DBUtil.closePreparedStatement(ps);
            pool.freeConnection(connection);
        }
    }
    
}
