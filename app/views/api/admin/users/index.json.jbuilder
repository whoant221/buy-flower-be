json.users do
  json.partial! 'record', collection: users, as: :user
end