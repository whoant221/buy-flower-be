module TransportService
  class GiaoHangNhanh

    def initialize(order:)
      @order = order
    end

    def create
      resp = create_order
      order.shipping_ref = resp['data']['order_code']
      order.save!
    rescue Exception
      order.mark_as_pending
    end

    private

    attr_reader :order

    def create_order
      body = {
        payment_type_id: 1,
        note: 'Giao nhanh',
        from_name: 'Võ Văn Hoàng Tuân',
        from_phone: '0909999999',
        from_address: '881 Sư Vạn Hạnh',
        from_ward_name: 'Phường 12',
        from_district_name: 'Quận 10',
        from_province_name: 'TP Hồ Chí Minh',
        required_note: 'CHOXEMHANGKHONGTHU',
        return_name: 'Võ Văn Hoàng Tuân',
        return_phone: '0909999999',
        return_address: '881 Sư Vạn Hạnh',
        return_ward_name: 'Phường 12',
        return_district_name: 'Quận 10',
        return_province_name: 'TP Hồ Chí Minh',
        client_order_code: '',
        to_name: order.additional_data['receiver'],
        to_phone: order.additional_data['receive_phone'],
        to_address: order.receive_address,
        to_ward_name: 'Phường 12',
        to_district_name: 'Quận 10',
        to_province_name: 'TP Hồ Chí Minh',
        cod_amount: 0,
        content: order.additional_data['reason'],
        weight: 200,
        length: 1,
        width: 19,
        height: 10,
        insurance_value: 0,
        service_id: 0,
        service_type_id: 2,
        items: items
      }

      resp = Timeout::timeout(30) do
        HTTParty.post(
          'https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/create',
          body: body.to_json,
          headers: headers
        )
      end

      if resp.success?
        JSON.parse(resp.body)
      else
        raise StandardError, "Body #{resp.body} has code #{resp.code}"
      end
    end

    def items
      order.order_details.map do |order_detail|
        {
          name: order_detail.flower.name,
          # code: 'Polo123',
          quantity: order_detail.amount,
          price: order_detail.flower.sale_price.to_i,
          length: 12,
          width: 12,
          height: 12,
          # category:
          #   {
          #     level1: 'Áo'
          #   }
          #
        }
      end
    end

    def headers
      { 'ShopId' => ENV['GHN_SHOP_ID'], 'Token' => ENV['GHN_TOKEN'], 'Content-Type' => 'application/json' }
    end

  end
end
