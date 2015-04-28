if ENV["REDISCLOUD_URL"]
    Socialization.redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
end
