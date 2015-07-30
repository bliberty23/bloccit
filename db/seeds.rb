require 'faker'

# Create Users
5.times do
  user = User.new(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end


# Create an admin user
unless User.find_by_email "admin@example.com"
  admin = User.new(
    name:     'Admin User',
    email:    'admin@example.com',
    password: 'helloworld',
    role:     'admin'
  )
  admin.skip_confirmation!
  admin.save!
  puts "Admin User created."
end

# Create a moderator
unless User.find_by_email "moderator@example.com"
  moderator = User.new(
    name:     'Moderator User',
    email:    'moderator@example.com',
    password: 'helloworld',
    role:     'moderator'
  )
  moderator.skip_confirmation!
  moderator.save!
  puts "Moderator User created."
end

# Create a member
unless User.find_by_email "member@example.com"
  member = User.new(
    name:     'Member User',
    email:    'member@example.com',
    password: 'helloworld'
  )
  member.skip_confirmation!
  member.save!
  puts "Member User created."
end

users = User.all

# Note: by calling `User.new` instead of `create`,
# we create an instance of User which isn't immediately saved to the database.

# The `skip_confirmation!` method sets the `confirmed_at` attribute
# to avoid triggering an confirmation email when the User is saved.

# The `save` method then saves this User to the database.

# Create Topics
15.times do |i|
  Topic.create!(
    name:         "#{i} #{Faker::Lorem.sentence}",
    description:  "#{i} #{Faker::Lorem.paragraph}"
  )
end
topics = Topic.all
puts "#{Topic.count} topics created"


# Create Posts
50.times do |i|
  Post.create!(
    user:   users.sample,
    topic:  topics.sample,
    title:  "#{i} #{Faker::Lorem.sentence}",
    body:   "#{i} #{Faker::Lorem.paragraph(6)}"
  )
end
posts = Post.all
puts "#{Post.count} posts created"

# Create Comments
100.times do |i|
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    body: "#{i} #{Faker::Lorem.paragraph(2)}"
  )
end
puts "#{Comment.count} comments created"


puts "Seed finished"
