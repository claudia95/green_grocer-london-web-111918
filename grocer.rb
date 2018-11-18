def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |hash|
    hash.each do |food, info|
      consolidated_cart[food] = info 
      consolidated_cart[food][:count] ||= 0
      consolidated_cart[food][:count] += 1 
    end
  end
  consolidated_cart
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    food = coupon[:item]
    if cart[food] && cart[food][:count] >= coupon[:num]
      if cart["#{food} W/COUPON"]
        cart["#{food} W/COUPON"][:count] += 1 
    else
      cart["#{food} W/COUPON"] = {
        :price => coupon[:cost],
        :clearance => true,
        :count => 1 
      }
      cart["#{food} W/COUPON"][:clearance] = cart[food][:clearance]
    end
    cart[food][:count] -= coupon[:num]
  end
end
cart
end

def apply_clearance(cart)
  cart.each do |food, info|
    if cart[food][:clearance] == true 
      new_price = info[:price] * 0.8
      info[:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0
  updated_cart = consolidate_cart(cart)
  updated_cart1 = apply_coupons(updated_cart, coupons)
  updated_cart2 = apply_clearance(updated_cart1)
  
  updated_cart2.each do |name, data_hash|
    total = total + (data_hash[:price].to_f * data_hash[:count].to_f)
  end
   if total > 100
    total = total * 0.9
  end
  
  return total
  
end
