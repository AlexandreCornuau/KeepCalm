Grover.configure do |config|
  config.options = {
    launchOptions: {
      executablePath: ENV[‘PUPPETEER_EXECUTABLE_PATH’],
      args: %w[
        --no-sandbox
        --disable-setuid-sandbox
        --disable-gpu
        --disable-dev-shm-usage
      ]
    }
  }
end
