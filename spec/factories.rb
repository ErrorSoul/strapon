FactoryGirl.define do  
  factory :user do
    provider "MyString"
    uid "MyString"
    name "MyString"
    nickname "Anonymus"
    image "http://image.png"

  end
  


 
  

  
  factory :photo do
    
  end


  sequence(:title) { |n| "Example title #{n}" }
  sequence(:text)  { |n| Faker::Lorem.sentence(4, false, 2)}
  factory :author do
    name     "Michael"
    login    "michael10"
     bio      "This is my bio"
    password "foobar"
    password_confirmation "foobar"

    factory :author_with_posts do
      login "artur"
      transient do 
        
        posts_count 5
      end	
      after(:create) do |author, evaluator|
        create_list(:post, evaluator.posts_count, author: author)
      end	
  end
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
  

  factory :post do |e|
     title
     text
     author 
  end

  factory :post_with_asset, parent: :post do |x|
    x.asset   { File.new("#{Rails.root}/spec/fixtures/dream.jpg") } end


 factory :comment do
    user
    text "MyText"
     post
    child 0
   
  end
end


