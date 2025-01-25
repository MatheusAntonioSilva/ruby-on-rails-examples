FactoryBot.define do
  factory :user do
    first_name { 'Matheus' }
    last_name { 'Silva' }
    email { 'test@gmail.com' }
    password { 'test123' }
    password_confirmation { 'test123' }
    kind { 'librarian' }
   end
end
