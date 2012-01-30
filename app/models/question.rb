class Question
  attr_accessor :id, :title
  
  def initialize(question)
    @id = question["question_id"]
    @title = question["title"]
  end
end