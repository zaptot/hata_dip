task :add_post_prices => :environment do
  Post.find_each do |post|
    post.price = rand(1000) unless post.price
    post.save!
  end
end