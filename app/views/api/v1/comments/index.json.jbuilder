json.comments do
  json.partial! 'record', collection: comments, as: :comment
end