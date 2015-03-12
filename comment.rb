class Comment
  attr_reader :user_name, :text

  def initialize(user_name, text)
    @user_name = user_name
    @text = text
  end

end