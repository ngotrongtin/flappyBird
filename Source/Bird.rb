require "gosu"
class Bird
    attr_accessor :x_position, :y_position, :image, :above_corner, :below_corner 
    def initialize(x = -1, y = -1)
        @x_position = x
        @y_position = y
        @image = Gosu::Image.new("Image/bird.png")
    end

    def update_info
        @below_corner = {x: (self.x_position + self.image.width), y: (self.y_position + self.image.height)}
        @above_corner = {x: (self.x_position + self.image.width), y: (self.y_position)}
    end
end

