json.categories do
  json.partial! 'record', collection: categories, as: :category
end
