json.order_id order.id
json.original_price order.original_price
json.sale_price order.sale_price
json.receive_address order.receive_address
json.note order.note
json.state order.state
json.order_details order.order_details do |order_detail|
  json.flower_id order_detail.flower_detail.flower_id
  json.amount order_detail.amount
  json.price order_detail.price
  json.images order_detail.flower_detail.flower.images
end
if order.vouchers.first
  json.voucher do
    json.code order.vouchers.first.code
    json.txt_condition order.vouchers.first.render_condition
  end
end
