class ChallengeTextView < BaseView
  stylesheet :call

  attr_accessor :words

  def render
    @title = subview(UILabel, :challenge_text_title)
    @words = subview(UILabel, :challenge_text_words)
  end
end