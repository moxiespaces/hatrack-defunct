module SprintsHelper

  def print_date(date,nil_text = '')
    date ? date.strftime("%m/%d") : nil_text
  end

  def print_input_date(date,nil_text = '')
    date ? date.strftime("%m/%d/%Y") : nil_text
  end

end
