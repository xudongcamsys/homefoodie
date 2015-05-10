namespace :seed do
  desc "seed food categories"
  task :food_categories => :environment do
    require File.join(Rails.root, 'db', 'tasks/seed_food_categories.rb')
  end
end
