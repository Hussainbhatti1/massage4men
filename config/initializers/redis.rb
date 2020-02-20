$redis = Redis.new(url: ENV["REDISCLOUD_URL"] || "redis://127.0.0.1:6379")
Resque.redis = $redis