class TransportOrderJob < ApplicationJob
  queue_as :default

  def perform(order)
    TransportService::GiaoHangNhanh.new(order: order).create
  end
end
