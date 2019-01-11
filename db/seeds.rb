# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Post.destroy_all

category_keys = ["情報","哲学","社会科学","言語","自然科学","数学","文学"]
# ['Information', 'Philosophy', 'SocialScience', 'Language', 'NaturalScience', 'Math', 'Literature']
# ["情報","哲学","社会科学","言語","自然科学","数学","文学"]

# categories
7.times do |i|
  Category.create!({
    name: category_keys[i]
  })
end

# A user
user = User.new({
  name: 'ririco',
  email: 'ririco@example.com',
  password: 'momomo',
  password_confirmation: 'momomo',
  image: 'profile.png',
  point: 1500
})
user.save!

# A project
ririco = User.first

7.times do |i|
  ririco.posts.create!({
    title: Faker::HarryPotter.character,
    description: Faker::HarryPotter.house,
    body: Faker::HarryPotter.quote,
    category_id: i+1,
    point: 200
  })
end

post = ririco.posts.first
5.times do |i|
  post.comments.create!({
    content: Faker::Lorem.paragraph,
    user_id: ririco.id
  })
end