class RemindsController < ApplicationController
  def new
  end

  def slack
    uri = Settings.slack.test
    types = ["m", "n", "c", "l"]
    text = ""
    types.each do |type|
      case type
      when "m"
        text << "【依頼】\n"
      when "n"
        text << "【通常issuePJ】\n"
      when "c"
        text << "【チャレンジPJ】\n"
      when "l"
        text << "【学習PJ】\n"
      end
      i = 1
      params[type].to_i.times do
        n = i.to_s
        title, progress, day = "#{type + n}_title", "#{type + n}_progress", "#{type + n}_day"
        text << "#{params[title]}  #{params[progress]}  #{params[day]} \n"
        i += 1
      end
    end

    uri = Addressable::URI.parse(uri)
    rqs = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', )
    rqs.body = "{'text': '#{text}'}"
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') { |http|
      res = http.request(rqs)
    }

    redirect_to root_url
  end
end
