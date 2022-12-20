# frozen_string_literal: true
$redis_report = Redis.new(url: "#{ENV["REDIS_URL"]}/1/report") if ENV["REDIS_URL"]
