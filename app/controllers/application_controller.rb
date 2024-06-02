class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def getCodeSequence(code, year)
    result = 0
    codeSeq = CodeSequence.where("code = ? AND year = ?", code, year).first()

    if codeSeq.present?
      codeSeq.sequence = codeSeq.sequence + 1
      result = codeSeq.sequence
      codeSeq.save!
    else
      codeSeq = CodeSequence.new
      codeSeq.code = code
      codeSeq.year = year
      codeSeq.sequence = 1
      codeSeq.save!
      result = 1
    end

    result
  end
end
