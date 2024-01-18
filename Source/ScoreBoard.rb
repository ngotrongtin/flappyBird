require 'gosu'
require 'json'
require_relative 'Background'
require_relative 'Zorder'
require_relative 'Select_menu'


class ScoreBoard < Gosu::Window
    def initialize
        @background = create_background("select")
        super(@background.width, @background.height)
        self.caption = "Score Board"
        @font_1 = Gosu::Font.new(40, {bold: true} )
        @font_2 = Gosu::Font.new(20)
        @scores = score_taken
    end

    def draw 
        @background.draw(0,0, Order::BACKGROUND)
        margin = 60
        @font_1.draw_text_rel("Điểm", @background.width / 2, margin, Order::THING , 0.5, 0.5, 1,1, Gosu::Color::BLACK )
        @scores.each_pair do |key, value|
            margin += 60
            @font_2.draw_text_rel("TOP. #{key}: #{value}", @background.width / 2, margin, Order::THING, 0.55, 0.5, 1, 1, Gosu::Color::BLACK )   
        end
    end

    #no update for scoreboard
    def update
    end

    def button_down(id)
        if id == Gosu::KbEscape
            close
            SelectMenu.new("start").show
        end
    end

    private
    def score_taken
        data = File.exist?('data.json') ? JSON.parse(File.read('data.json')) : {}
        return data = File.exist?('data.json') ? JSON.parse(File.read('data.json')) : {}
    end
end