FactoryGirl.define do

  sequence(:title) { |n| "Example title #{n}" }
  sequence(:text)  { |n| Faker::Lorem.sentence(4, false, 2)}
  factory :author do
    name     "Michael"
    login    "michael10"
     bio      "This is my bio"
    password "foobar"
    password_confirmation "foobar"
  end


   factory :ataman, parent: :user  do |f|
    f.name     "Nusha"
    f.login    "nusha11"
    
    f.password "foobar"
    f.password_confirmation "foobar"
  end
  factory :invalid_author_password, parent: :author do |f|
    f.password " "
    f.password_confirmation " "
  end

  factory :invalid_author_login, parent: :author do |z|
    z.login  nil 
  end
  

  factory :post do
   
    title 
    text
    author
  end

  factory :post_with_asset, parent: :post do |x|
    x.asset   { File.new("#{Rails.root}/spec/fixtures/dream.jpg") } end
end


