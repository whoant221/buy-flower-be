module Api
  module Admin
    module RenderConcern

      STATUSES = %i[
        ok
        created
        accepted
        no_content
        not_found

        bad_request
        unauthorized
        request_timeout
        unprocessable_entity
        not_acceptable
        forbidden
        precondition_failed
      ]

      def render_record_invalid(exception)
        render json: exception.record.errors.to_a.map { |m| { message: m } },
               status: :unprocessable_entity
      end

      STATUSES.each do |status|
        define_method "render_#{status}" do |data = nil|
          if data.present? && [Hash, Array].include?(data.class)
            render json: data, status: status
          else
            render json: [{ message: data.to_s }], status: status
          end
        end
      end

    end
  end
end
