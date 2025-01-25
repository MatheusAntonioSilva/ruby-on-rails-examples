module AuthorManager
  class Creator < ApplicationManager::Creator

    attr_reader :user, :args

    def initialize(user, args)
      @user = user
      @args = args.to_h
    end

    private

    def execute_creation
      author = ::Author.find_or_initialize_by(name: args[:name])
      author.user_id = user.id
      author.save!

      author
    end
  end
end
