# frozen_string_literal: true

module ProductsHelper
  def print_stock(stock, requested = 1)
    if stock.zero?
      content_tag(:span, content_tag(:p, "Out of Stock"), class: "out_stock")
    elsif stock >= requested
      content_tag(:span, content_tag(:p, "In Stock #{stock}"), class: "in_stock")
    else
      stock < requested
      content_tag(:span, "Insufficient stock (#{stock})", class: "low_stock")
    end
  end

  def currency_of_price(currency)
    { "usd" => "$", "eur" => "€", "rub" => "₽", "pln" => "zł", "byn" => "br", "uah" => "₴" }.fetch(currency)
  end
end
