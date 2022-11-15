class Exceptions
  class InvalidCredentials < StandardError; end

  class RecordExists < StandardError; end

  class RecordNotExists < ActiveRecord::RecordNotFound; end

  class Unauthorized < StandardError; end

  class OrderInvalid < StandardError; end
end
