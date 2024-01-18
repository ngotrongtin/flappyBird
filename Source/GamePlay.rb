require 'gosu' 
require_relative 'Zorder'
require_relative 'Bird'
require_relative 'Background'
require_relative 'Pipe'
require_relative 'Select_menu'
class Game < Gosu::Window
  attr_accessor :pipes, :game_over
  def initialize(dificulty = "Dễ")
    # set up the first of all thing
    @speed = 0.5
    @speed = 1 if dificulty == "Khó"
    @game_over = false
    @font = Gosu::Font.new(20, {bold: true})
    @scores = 0
    @score_table = "Điểm #{@scores}"
    @background = create_background("ingame")
    @bird = Bird.new(@background.width/4, @background.height/2 - 50) 
    @pipes = Pipe.initialize_pipe(100)
    init_pipe_pos(@pipes[0])
    super(@background.width, @background.height, false) # setup window
    self.caption = "Flappy Bird"
  end

  def draw
    # draw background
    @background.draw(0,0,Order::BACKGROUND)
    # draw bird
    @bird.image.draw(@bird.x_position,@bird.y_position, Order::THING,0.8 ,0.8 )
    # draw pipe
    pipe_draw
    score_font_draw
  end

  def update
    pipe_init_move
    @bird.y_position += 3
    @bird.update_info
    if did_bird_touch?(@bird, set_of_in_background_pipes(@pipes, @background), @background)
      @game_over = true 
      save_score(@scores)
      close
      SelectMenu.new("end").show
    end
    @scores = num_of_score(@pipes, @bird)
    @score_table = "Điểm #{@scores}"
  end

  def button_down(ascii_key)
    case ascii_key
    when Gosu::MsLeft, Gosu::KB_B
      @bird.y_position -= 70
      @bird.update_info
    when Gosu::KbEscape
      close
      SelectMenu.new("start").show
    end
  end

  private 
  def score_font_draw
    @font.draw_text(@score_table, @background.width - 150, 10, Order::SCORE, 2, 2, Gosu::Color.argb(0xff_000000) )
  end

  def init_pipe_pos(pipe)
    space_between_pipe = 200
    num = rand(100..328)
    pipe[:below].x_position = @background.width - pipe[:below].image.width
    pipe[:below].y_position = @background.height - num
    pipe[:above].x_position = @background.width
    pipe[:above].y_position = pipe[:below].y_position - space_between_pipe
  end

  def pipe_draw
    @pipes.each do |pipe|
      unless not_init?(pipe)
        pipe[:below].image.draw(pipe[:below].x_position,pipe[:below].y_position, Order::THING)
        pipe[:above].image.draw_rot(pipe[:above].x_position,pipe[:above].y_position, Order::THING, 180, 0,0)
      end
    end
  end
 

  def pipe_move(pipe)
      pipe[:above].x_position -= @speed
      pipe[:below].x_position -= @speed  
  end

  def pipe_init_move
    space_between_pairs = 300
    @pipes.each_with_index do |pipe, index|
      if pipe[:below].x_position == @background.width - space_between_pairs
        init_pipe_pos(@pipes[index + 1])
        break if index == @pipes.length - 2
      end 
      unless not_init?(pipe)
        pipe_move(pipe)
      end
    end
  end

  def not_init?(pipe)
    return pipe[:below].x_position == -1 && pipe[:below].y_position == -1 
  end

  def init_all?
    return (@pipes[@pipes.length - 1][:below].x_position != -1 && @pipes[@pipes.length - 1][:below].y_position != -1)
  end
end

