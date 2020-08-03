require_relative "store"


class Calculate < Store
  attr_reader :order_list, :sale_qty_for_item, :unit_price_of_item, :sale_price_for_item

  def initialize(order_list)
    super()
    @order_list = order_list
    @unit_price_of_item
    @sale_qty_for_item
    @sale_price_for_item
    @total_cost
    @total_savings
    
  end

  def self.calculation(order_list)
    new(order_list).calculation_start
  end

  def calculation_start
    order_list.each {|hsh| check_hash(hsh)}
    calculation_result(@total_price_array, @saving_price)
    
  end

  def check_hash(hsh)
    hsh.each do |key,val|
      if MENU[key.to_sym] && SALE_MENU[key.to_sym]
        @unit_price_of_item =  MENU[key.to_sym]
        @sale_qty_for_item = SALE_MENU[key.to_sym][:qty]
        @sale_price_for_item = SALE_MENU[key.to_sym][:price]
        calculation_with_discount(key, val)
      elsif MENU[key.to_sym] && !SALE_MENU[key.to_sym]
        @unit_price_of_item =  MENU[key.to_sym]
        calculation_with_discount(key, val) 
      else
        @not_available_items << key
      end   
    end
    
  end

  def calculation_with_discount(key,val)
    if !SALE_MENU[key.to_sym]
      price = val * unit_price_of_item
      @total_price_array << {key => price}
    else
      if val.to_f >= SALE_MENU[key.to_sym][:qty]
        if val.to_f == SALE_MENU[key.to_sym][:qty]
          total_price_array << {key => sale_price_for_item}
          without_discount_price = val * unit_price_of_item
          saving_price << {key => (without_discount_price - sale_price_for_item).round(2)} 
        else
          n = (val / sale_qty_for_item).to_i
          qty_used = n * sale_qty_for_item
          price = ((val- qty_used)*unit_price_of_item) + (n *sale_price_for_item)
          @total_price_array << {key => price}
          without_discount_price = val * unit_price_of_item
          @saving_price << {key => (without_discount_price - price).round(2)}

        end
      end
    end
    
    
  end

  def calculation_result(costings_array, savings_array)
    price_values_array = costings_array.map{|item| item.inject(0){|sum, (key,val)| sum+=val}}
    @total_cost = price_values_array.inject(0){|sum,item| sum+=item}
    # p @total_cost_of_purchase, 'total cost of purchase'
    saving_values_array = savings_array.map{|item| item.inject(0){|sum, (key,val)| sum+=val}}
    @total_savings = saving_values_array.inject(0){|sum,item| sum+=item}
    # p @total_savings_in_purchase, 'total savings in purchase'
    show_result
    
  end
  def show_result  
    
    show_cost
    show_saving
    
  end
  
  def show_cost
    p "Total cost is : $#{@total_cost}"
  end
  
  def show_saving
    p "You saved $#{@total_savings} today"
  end

  
end
