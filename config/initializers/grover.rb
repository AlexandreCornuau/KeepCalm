# config/initializers/grover.rb
Grover.configure do |config|
  config.options = {
    launchOptions: {
      args: %w[
        --no-sandbox
        --disable-setuid-sandbox
        --disable-gpu
        --disable-dev-shm-usage
        --headless=new
      ]
    }
  }
end
