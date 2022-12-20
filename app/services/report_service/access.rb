# frozen_string_literal: true
module ReportService
  class Access
    class << self
      def get_analyze_in_month(from_date, to_date)
        # from_date = '1/12/2022'
        # to_date = '21/12/2022'
        (from_date.to_date...to_date.to_date).map {|d| [d.strftime("%d/%m/%Y"), get_analyze_access_per_day(d.strftime("%d/%m/%Y"))]}
      end

      def analyze_access_per_day(tracking_id)
        return if tracking_id == ''
        unless $redis_report.exists(tracking_id)
          $redis_report.setex(tracking_id, 2, "true")
          now = Time.now.strftime("%d/%m/%Y")
          $redis_report.incr("report_access_#{now}")
        end
      end

      def get_analyze_access_per_day(day)
        $redis_report.get("report_access_#{day}").to_i || 0
      end
    end
  end
end

