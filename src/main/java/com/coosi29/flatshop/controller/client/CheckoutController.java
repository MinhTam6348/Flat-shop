package com.coosi29.flatshop.controller.client;

import java.sql.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coosi29.flatshop.dao.ItemDao;
import com.coosi29.flatshop.dao.OrderDao;
import com.coosi29.flatshop.entity.Item;
import com.coosi29.flatshop.entity.Order;
import com.coosi29.flatshop.entity.Product;
import com.coosi29.flatshop.entity.User;
import com.coosi29.flatshop.model.ItemDTO;
import com.coosi29.flatshop.model.UserDTO;

@Controller
@RequestMapping(value = "/client")
public class CheckoutController {

	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private ItemDao itemDao;
	
	@PostMapping(value = "/checkout")
	public String checkout(HttpSession session) {
		
		float subTotal = 0; // tong tien hang
		float fee = 0; // phi ship = 5$
		System.out.println("-------");
		UserDTO userInfo = (UserDTO) session.getAttribute("user");
		System.out.println(userInfo.getEmail());
		// lay thong tin nguoi mua hang
		User user = new User();
		user.setUserId(userInfo.getUserId());
		
        Date date = new Date(new java.util.Date().getTime()); // lay ngay hien tai
        
		Object object = session.getAttribute("cart"); // lay danh sach gio hang tu session
		Map<Long, ItemDTO> mapItem = (Map<Long, ItemDTO>) object;
		
		for(Map.Entry<Long, ItemDTO> entry : mapItem.entrySet()) {
		    Long key = entry.getKey();
		    ItemDTO value = entry.getValue();
		    
		    subTotal += (value.getUnitPrice() * value.getQuantity()); // tinh tong tien hang
		}
		
		Order order = new Order();
		order.setBuyDate(date);
		order.setBuyer(user);
		order.setStatus("PENDING");
		order.setPriceTotal(subTotal + fee);
		
		orderDao.insert(order);
		
		// insert danh sach san pham trong don hang vao bang item
		for(Map.Entry<Long, ItemDTO> entry : mapItem.entrySet()) {
		    Long key = entry.getKey();
		    ItemDTO value = entry.getValue();
		    
		    Product product = new Product();
		    product.setProductId(entry.getValue().getProductDTO().getProductId());
		    
		    Item item = new Item();
		    item.setItemId(entry.getValue().getItemId());
		    item.setProduct(product);
		    item.setQuantity(entry.getValue().getQuantity());
		    item.setUnitPrice(entry.getValue().getUnitPrice());
		    item.setOrder(order);
		    
		    // insert vao bang item
			itemDao.insert(item);
		}
	
		mapItem.clear();
		session.setAttribute("cart", mapItem);
		System.out.println(session.getAttribute("cart"));
		
		return "redirect:/client/my-order";
	}
}
