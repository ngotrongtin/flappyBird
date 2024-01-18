require "gosu"
require "json"
def create_background(option)
    case option 
    when "select"
        return Gosu::Image.new("Image/select_background.jpg")
    when "ingame"
        return Gosu::Image.new("Image/gameplay_background.jpg")\
    else
        puts "no image found"
    end
end

def set_of_in_background_pipes(pipes, background)
    set_pipes = []
    pipes.each do |pipe|
        if (0..(background.height)).include?(pipe[:below].x_position)
            set_pipes.push(pipe)
        end
    end
    return set_pipes
end

def did_bird_touch?(bird, set_pipes, background)
    return true unless (0..background.height).include?(bird.y_position) 
    set_pipes.each do |pipe|
        range_width_pipe = ((pipe[:above].x_position - pipe[:above].image.width)..(pipe[:above].x_position))
        if range_width_pipe.include?(bird.above_corner[:x])
            if (0..(pipe[:above].y_position)).include?(bird.above_corner[:y]) || ((pipe[:below].y_position)..(background.height)).include?(bird.below_corner[:y])
                return true
            end
        end
    end
    return false
end

def num_of_score(pipes, bird)
    num = 0 
    pipes.each do |pipe|
        num += 1 if pipe[:above].x_position < bird.x_position && pipe[:above].x_position != -1
    end
    return num
end

def save_score(score)
    file_path = 'data.json'

    # Kiểm tra xem tệp có tồn tại không
    if File.exist?(file_path)
        json_content = File.read(file_path)

        # Bước 2: Chuyển đổi nội dung JSON thành cấu trúc dữ liệu Ruby
        data = JSON.parse(json_content)

        # Bước 3: Thêm dữ liệu mới vào cấu trúc dữ liệu Ruby
        keys_array = data.keys
        data.each do |key, value|
            if value <= score
              stop_key = key
              keys_array.reverse_each.with_index do |current_key, index|
                break if current_key == stop_key
                data[current_key] = data[keys_array[index - 1]]
              end
              data[stop_key] = score
              break
            end
          end

        # Bước 4: Chuyển đổi cấu trúc dữ liệu Ruby thành chuỗi JSON mới
        new_json_content = JSON.generate(data)

        # Bước 5: Ghi chuỗi JSON mới vào tệp
        File.write(file_path, new_json_content)
    end
end