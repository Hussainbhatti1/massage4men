module ReviewsHelper
  def answer(answer)
    if answer.nil?
      'N/A'
    else
      answer
    end
  end
end
