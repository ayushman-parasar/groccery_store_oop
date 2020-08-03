require_relative "store"


class Manager
 
  def take_order
    puts "Enter Your Order"
    @items = gets.chomp.gsub(" ", '').split(",")
    check_order(@items)
  end

  def check_order(items)
    if items.empty?
      p "Enter proper input"
      return
    else
      get_order_list(items)
    end
  end
  
  def get_order_list(item_list)
    array_item_qty = item_list.map do |item|
      if item != ""
        qty = item_list.count(item)
        {item => qty}
      end
    end 
    p array_item_qty
  end
end

Manager.new.take_order
