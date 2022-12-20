class Exceptions
  class InvalidCredentials < StandardError; end

  class RecordExists < StandardError; end

  class RecordNotExists < ActiveRecord::RecordNotFound; end

  class Unauthorized < StandardError; end

  class OrderInvalid < StandardError; end

  class CategoryInvalid < StandardError; end

  class ShoppingCartBlank < StandardError; end

  class TimeInvalid < StandardError; end

  class DataInvalid < StandardError; end

  class ExchangeVoucherError < StandardError; end

  class UseVoucherInvalid < StandardError; end

  class NotEnoughPoint < StandardError; end

  class NotEnoughBud < StandardError; end
end
