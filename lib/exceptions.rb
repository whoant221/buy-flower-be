class Exceptions
  class InvalidCredentials < StandardError; end

  class RecordExists < StandardError; end

  class RecordNotExists < ActiveRecord::RecordNotFound; end

  class Unauthorized < StandardError; end
end
