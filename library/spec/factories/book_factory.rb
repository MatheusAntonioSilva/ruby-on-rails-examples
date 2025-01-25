FactoryBot.define do
  factory :book do
    title { 'test' }
    description { 'test' }
    public_url { 'https://library-app-files.s3.amazonaws.com/07a00c25-2b06-475e-be08-4d3c42705a30.png' }
    file_name { '07a00c25-2b06-475e-be08-4d3c42705a30.png' }
    user_id { nil }
    author_id { nil }
  end
end
