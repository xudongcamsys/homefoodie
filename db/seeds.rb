# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin_user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << admin_user.email

# vip user
vip_user = User.find_or_create_by!(email: 'vip@example.com') do |user|
  user.password = 'changeme'
  user.password_confirmation = 'changeme'
  user.vip!
end
puts 'CREATED VIP USER: ' << vip_user.email

# regular user
user = User.find_or_create_by!(email: 'user@example.com') do |user|
  user.password = 'changeme'
  user.password_confirmation = 'changeme'
  user.user!
end
puts 'CREATED USER: ' << user.email
