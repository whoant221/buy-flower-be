json.flowers do
  json.partial! 'record', collection: flowers, as: :flower
end