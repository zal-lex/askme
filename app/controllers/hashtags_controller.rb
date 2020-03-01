class HashtagsController < ApplicationController

  def show
    @hashtag = Hashtag.find params[:id]
    @questions = @hashtag.questions.order(created_at: :desc)
  end
end
