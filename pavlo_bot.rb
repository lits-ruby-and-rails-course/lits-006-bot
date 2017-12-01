require 'open-uri'
require 'rack'
require 'json'

#curl -X POST -d @data.json -H "Content-Type: application/json" "https://api.telegram.org/bot508721328:AAGyhaLWI_l1Dpl4WQ8U9E0gzQ44r2YvjnE/setWebhook"

class PavloBot
  TELEGRAM_API_KEY = '508721328:AAGyhaLWI_l1Dpl4WQ8U9E0gzQ44r2YvjnE'

  def call env
    return [200, {"Content-Type" => "text/plain"}, []] if env['PATH_INFO'] == '/favicon.ico'

    send_message_url = "https://api.telegram.org/bot#{TELEGRAM_API_KEY}/sendMessage"

    if env['REQUEST_METHOD'] == 'POST'# && env['PATH_INFO'] == '/webhook'
      req = Rack::Request.new(env)
      params = JSON.parse(req.body.read)

      if params
        chat_id = params['message']['from']['id']
        msg_text = params['message']['text'].downcase

        request_params = {
          chat_id: chat_id,
          text: "I don't undestand you"
        }

        if msg_text && msg_text.include?('what') && msg_text.include?('name')
          request_params[:text] = 'My name is Pavlo Bot'
        end

        if msg_text && msg_text.include?('how') && msg_text.include?('old')
          request_params[:text] = 'I\'m 1 day old!'
        end

        if msg_text && msg_text.include?('what') && msg_text.include?('time')
          request_params[:text] = "Current time is #{DateTime.now.strf('HH:mm')}"
        end

        url = URI.parse(send_message_url)
        ::Net::HTTP.post_form(url, request_params)
      end

      return [201, {"Content-Type" => "text/plain"}, []]
    end

    [200, {}, ["<h1 style='color:#cc0000;'>Hello World 222</h1>"]]
  end
end
