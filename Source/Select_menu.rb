require 'gosu'
require_relative 'Background'
require_relative 'Zorder'
require_relative 'GamePlay'
require_relative 'ScoreBoard'
class SelectMenu < Gosu::Window
  def initialize(menu)
    @background = create_background("select")
    super(@background.width , @background.height, false)
    self.caption = 'Select Menu'
    case menu 
    when "start"
      @options = ['Chơi', 'Dễ', 'Điểm' , 'Thoát']
    when "end"
      @options = ['Chơi tiếp', 'Thoát']
    end
    @selected_option = 0
    @font = Gosu::Font.new(20)
  end

  def draw
    @background.draw(0,0,Order::BACKGROUND)
    @options.each_with_index do |option, index|
      if index == @selected_option
        @font.draw_text(option, 150, 100 + index * 50, Order::THING, 2, 2, Gosu::Color::YELLOW)
      else
        @font.draw_text(option, 150, 100 + index * 50, Order::THING, 2, 2, Gosu::Color::GREEN)
      end
    end
  end

  def button_down(id)
    case id
    when Gosu::KbUp
      @selected_option = (@selected_option - 1) % @options.size
    when Gosu::KbDown
      @selected_option = (@selected_option + 1) % @options.size
    when Gosu::KbEnter, Gosu::KbReturn
      case @selected_option
      when 0
        close
        Game.new(@options[1]).show
      when 1
        case @options[1]
        when "Dễ"
          @options[1] = "Khó"  
        when "Khó" 
          @options[1] = "Dễ"
        when "Thoát"
          close
          SelectMenu.new("start").show
        end
      when 2
        close 
        ScoreBoard.new.show
      when 3
        close
      end
    when Gosu::KbEscape
      close
    end
  end
end


