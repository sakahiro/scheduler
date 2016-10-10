class Slack
  def self.send_message(text)
    uri = Addressable::URI.parse(Settings.slack.test)
    rqs = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json', )
    rqs.body = "{'text': '#{text}'}"
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') { |http|
      res = http.request(rqs)
    }
  end
end