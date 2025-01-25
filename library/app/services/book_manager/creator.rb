module BookManager
  class Creator < ApplicationManager::Creator

    attr_reader :user, :args

    def initialize(user, args)
      @user = user
      @args = args
    end

    private

    def execute_creation
      validate!
      save!
    end

    def validate!
      return if user.kind.to_sym == ::User::LIBRARIAN

      raise Exceptions::AccessNotAllowedError
    end

    def save!
      book = ::Book.new(args.slice(:title, :description).merge(user_id: user.id))
      author = ::AuthorManager::Creator.new(user, args[:author]).create
      book.author_id = author.id
      book.public_url = upload_file_s3!
      book.file_name = file_name

      book.save!
      book.reload
    rescue ::StandardError => e
      raise e if Rails.env.production? || @upload_file_s3.blank?

      obj = s3.bucket(::Book::BUCKET).object(file_name)
      obj.delete

      raise e
    end

    def upload_file_s3!
      return @upload_file_s3 if @upload_file_s3.present?

      obj = s3.bucket(::Book::BUCKET).object(file_name)
      obj.upload_file(args[:file], content_type: args[:file].content_type)
      @upload_file_s3 = obj.public_url
    rescue StandardError
      raise ::Exceptions::FileError
    end

    def s3
      @s3 ||= Aws::S3::Resource.new(region: 'us-east-1',
                                    credentials: Aws::Credentials.new(Rails.application.config.app.aws.access_key_id,
                                                                      Rails.application.config.app.aws.secret_key_id))
    end

    def file_name
      @file_name ||= "#{::SecureRandom.uuid}"
    end
  end
end
