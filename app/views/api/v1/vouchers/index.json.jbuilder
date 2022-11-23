json.vouchers do
  json.partial! 'record', collection: vouchers, as: :voucher
end