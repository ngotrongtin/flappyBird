require 'gosu'
class Pipe
    attr_accessor :x_position, :y_position, :image, :in
    def initialize()
        @image = Gosu::Image.new("Image/pipe2.png")
        @x_position = -1
        @y_position = -1
    end

    def self.initialize_pipe(num_of_pipe)
        arr = []
        num_of_pipe.times{
            pipe1 = Pipe.new
            pipe2 = Pipe.new
            hash = {above: pipe1,below: pipe2 }
            arr.push(hash)
        }
        return arr
    end
end

