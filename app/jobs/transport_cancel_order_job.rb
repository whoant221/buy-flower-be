class TransportCancelOrderJob < ApplicationJob
  queue_as :default

  def perform(order)
    TransportService::GiaoHangNhanh.new(order: order).cancel
  end
end
