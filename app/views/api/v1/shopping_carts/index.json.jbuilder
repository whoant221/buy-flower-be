json.shopping_carts do
  json.partial! 'record', collection: shopping_carts, as: :shopping_cart
end
