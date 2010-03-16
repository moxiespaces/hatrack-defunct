module SprintsHelper

  def print_date(date,nil_text = '')
    date ? date.strftime("%m/%d") : nil_text
  end

  def print_input_date(date,nil_text = '')
    date ? date.strftime("%m/%d/%Y") : nil_text
  end

  def new_hat_button(color)
    color_key = if color == 'blue'
      "b<span class=\"underline\">L</span>ue"
    else
      "<span class=\"underline\">#{color[0,1].capitalize}</span>#{color[1..-1]}"
    end
    "<button class=\"add_hat #{color}\" value=\"#{color}\">Add #{color_key} Hat</button>"
  end

end
