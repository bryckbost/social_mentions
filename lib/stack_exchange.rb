require 'faraday_middleware'
require 'json'

class StackExchange
  def self.connection
    Faraday.new "http://api.stackoverflow.com/1.1/" do |conn|
      conn.request :json
      conn.adapter Faraday.default_adapter
    end
  end
  
  def self.search(keyword)
    response = connection.get("search?intitle=#{keyword}")
    questions = []
    JSON.parse(response.body)["questions"].each do |question|
      questions << Question.new(question)
    end
    questions
  end
  
end