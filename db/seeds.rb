# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(name: "sample", email:"sample@aol.com", password:"password", password_confirmation:"password", admin:true)
# User.create!(name: "hoge", email:"hoge@aol.com", password:"password", password_confirmation:"password")
10.times do |n|
  User.create!(
    name: "hoge#{n + 1}",
    email: "hoge#{n + 1}@fuga.com",
    password: "password",
    password_confirmation: "password",
    admin: true
   )
end
User.all.each do |user|
  user.tasks.create!(
    name: "task",
    detail: "detail" ,
   )
end
10.times do |n|
  Label.create!(
    name: "ラベル#{n + 1}" )
end
