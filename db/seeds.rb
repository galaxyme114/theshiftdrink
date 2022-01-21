# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create do |user|
  user.name      = 'Scott Cruwys'
  user.email     = 'scruwys@gmail.com'
  user.password  = 'password1234'
  user.title     = 'Technology Coordinator'
  user.role      = 'Administrator'
end


user = User.create do |user|
  user.name      = 'Scott Cruwys'
  user.email     = 'scott.cruwys@gmail.com'
  user.password  = 'password1234'
  user.title     = 'Reader'
  user.role      = 'Reader'
end


if Rails.env.development?
  issue = Issue.create(title: 'Addicted to Sugar', alias_name: 'addicted', creator: user, number: '001')

  issue.articles.create(title: 'First Article')
  issue.articles.create(title: 'Second Article')
  issue.articles.create(title: 'Third Article')
end