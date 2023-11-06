package Store;

import java.util.*;


public class StoreService {
    
    public Double getCartTotal(List<Product> cart) {
        Double total = 0.0;
        if(cart == null) {
            return total;
        }
        else{
            for (int index=0; index < cart.size();index++) {
                Product item = (Product) cart.get(index);
                total += item.getPrice();
            }
        }
        return total;
    }
    
}
