module CommentService
  class Client
    def initialize(user:)
      @user = user
    end

    def add(flower, content)
      Comment.create!(flower: flower, content: content, user: user)
    end

    private

    attr_accessor :user
  end
end
