module CommentService
  class Client
    def initialize(user:, flower:)
      @user = user
      @flower = flower
    end

    def add(params)
      Comment.create!(flower: flower, content: params[:content], rank: params[:rank], user: user)
    end

    private

    attr_accessor :user, :flower
  end
end
