json.id flower.id
json.name flower.name
json.color flower.color
json.original_price flower.original_price
json.sale_price flower.sale_price
json.description flower.description
json.images flower.images
json.category_ids flower.category_ids
json.buds flower.flower_buds do |flower_bud|
  json.id flower_bud.bud.id
  json.name flower_bud.bud.name
  json.count flower_bud.count
end
