# config/initializers/grover.rb
Grover.configure do |config|
  config.options = {
    format: 'A4',
    margin: { top: '1cm', bottom: '1cm', left: '1cm', right: '1cm' },
    launch_args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage'],
    executable_path: ENV['GOOGLE_CHROME_BIN'] || ENV['CHROME_BIN']
  }
end
