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

  def generateReceptionNumber(kode)
    month = Date.today.strftime("%m")
    year = Date.today.strftime("%Y")
    code = kode.to_s + "/" + to_roman(month.to_i).to_s + "/" + year.to_s
    sequence = getCodeSequence(code, Time.current.year)
    return code + "/" + sequence.to_s.rjust(3, "0")
  end

  def to_roman(num)
    return '' if num <= 0 || num >= 4000

    roman_mapping = {
      1000 => 'M',
      900 => 'CM',
      500 => 'D',
      400 => 'CD',
      100 => 'C',
      90 => 'XC',
      50 => 'L',
      40 => 'XL',
      10 => 'X',
      9 => 'IX',
      5 => 'V',
      4 => 'IV',
      1 => 'I'
    }

    result = ''
    roman_mapping.each do |value, letter|
      result << letter * (num / value)
      num = num % value
    end
    result
  end
end
