class Store
  MENU = {
    milk: 3.97,
    bread: 2.17,
    banana: 0.99,
    apple: 0.89
  }
  SALE_MENU = {
    milk: {
      qty: 2,
      price: 5.00
    },
    bread:{
      qty: 3,
      price: 6.00
    },
  }
  def initialize
    @total_price_array = []
    @saving_price = []
    @total_cost_of_purchase = 0
    @total_savings_in_purchase = 0
    @not_available_items=[]
  end
  

  def check
    p "hello cheking on u"
  end

end