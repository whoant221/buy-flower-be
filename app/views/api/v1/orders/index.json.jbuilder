json.orders do
  json.partial! 'record', collection: orders, as: :order
end
