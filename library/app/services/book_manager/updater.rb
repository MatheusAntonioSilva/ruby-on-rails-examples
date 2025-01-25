module BookManager
  class Updater < ApplicationManager::Updater

    attr_reader :user, :old_file

    def initialize(id, user, args)
      @user = user

      super(id, args)
    end

    private

    def execute_updater
      validate!

      @old_file = old_file
      author = ::AuthorManager::Creator.new(user, args[:author]).create
      instance.update!(title: args[:title], description: args[:description], user_id: user.id,
                       author_id: author.id, public_url: upload_file_s3!, file_name: file_name)

      delete_old_file!

      instance.reload
    rescue ::StandardError => e
      raise e if @upload_file_s3.blank?

      delete_new_file!
      old_file.upload_file(args[:file], content_type: args[:file].content_type)

      raise e
    end

    def validate!
      return if user.kind.to_sym == ::User::LIBRARIAN

      raise Exceptions::AccessNotAllowedError
    end

    def instance
      ::Book.find(id)
    end

    def delete_old_file!
      old_file.delete
    end

    def delete_new_file!
      obj = s3.bucket(::Book::BUCKET).object(file_name)
      obj.delete
    end

    def upload_file_s3!
      return @upload_file_s3 if @upload_file_s3.present?

      obj = s3.bucket(::Book::BUCKET).object(file_name)
      obj.upload_file(args[:file], content_type: args[:file].content_type)
      @upload_file_s3 = obj.public_url
    end

    def get_object!
      s3.get_object(key: instance.file_name)
    end

    def old_file
      @old_file = s3.bucket(::Book::BUCKET).object(instance.file_name)
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
