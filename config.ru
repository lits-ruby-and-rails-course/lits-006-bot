require './pavlo_bot'
bot = PavloBot.new
Rack::Handler::WEBrick.run bot, Port: ENV['PORT']
