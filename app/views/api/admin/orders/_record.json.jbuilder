json.order_id order.id
json.original_price order.original_price
json.sale_price order.sale_price
json.receive_address order.receive_address
json.additional_data order.additional_data
json.state order.state
if order.shipping_ref != ''
  json.shipping_link "https://tracking.ghn.dev/?order_code=#{order.shipping_ref}"
end
json.order_details order.order_details do |order_detail|
  json.flower_id order_detail.flower_id
  json.name order_detail.flower.name
  json.amount order_detail.amount
  json.price order_detail.price
  json.images order_detail.flower.images
end
if order.vouchers.first
  json.voucher do
    json.code order.vouchers.first.code
    json.condition_str order.vouchers.first.render_condition
  end
end
