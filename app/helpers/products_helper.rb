module ProductsHelper
  def print_price(price)
    # format("$%.2f", price)
    number_to_currency price
  end

  def print_stock(stock, requested = 1)
    if stock.zero?
      content_tag(:span, content_tag(:p, "Out of Stock"), class: "out_stock")
    elsif stock >= requested
      content_tag(:span, content_tag(:p, "In Stock #{stock}"), class: "in_stock")
    else stock < requested
      content_tag(:span, "Insufficient stock (#{stock})", class: "low_stock")
    end
  end

  # def price=(input)
  #   input.delete!("$")
  #   super
  # end
end
