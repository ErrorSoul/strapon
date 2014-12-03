namespace :db do 
  desc "Fill database with sample data"
  task populate: :environment do 
    make_authors
    make_posts
  end
end


def make_authors
  Author.create!(name: "Oleg Petrov",
                 login: "oleg_mail",
                 bio:  "My bio is not your bio",
                 password: "foobar",
                 password_confirmation: "foobar")
  2.times do |n|
    name = Faker::Name.name
    login = Faker::Name.last_name + n.to_s
    puts login
    password = "password"
    bio = Faker::Lorem.sentence(3)
    Author.create!(name: name,
                 login: login,
                 bio: bio,
                 password: password,
                 password_confirmation: password)
  end
end

def make_posts
  authors = Author.all.limit(3)
  authors.each do |author|
    
    12.times do |n|
      title = Faker::Lorem.sentence(Random.rand(1..4), false, 2)
      text = Faker::Lorem.paragraphs(Random.rand(2..6))
      text.map { |x| x + "\n"}
      text = text.join("")
      asset = File.open(File.join("app", ActionController::Base.helpers.asset_path("assets/images/pictures/#{n + 1 }.jpg")))
      author.posts.create!(title: title, text: text, asset: asset)
    end
  end
    
end
