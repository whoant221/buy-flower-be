module Api
  module V1
    class CommentsController < ApiController
      before_action :required_login, only: [:create]

      def index
        comments = Comment.where(flower: comment_params[:flower_id])
        render 'index', locals: {
          comments: comments
        }, formats: [:json], status: :ok
      end

      def create
        authorize flower, policy_class: CommentPolicy
        CommentService::Client.new(user: current_user).add(flower, comment_params[:content])
      end

      private

      def comment_params
        params.permit(:content, :flower_id)
      end

      def flower
        @flower ||= Flower.find_by(id: comment_params[:flower_id])
        raise ActiveRecord::RecordNotFound, I18n.t('services.flower_service.not_exists') unless @flower

        @flower
      end

    end
  end
end