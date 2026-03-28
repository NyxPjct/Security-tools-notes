# engine/choice.rb
class Choice
    def initialize(question, options)
      @question = question
      @options = options
      @selected = 0
    end
  
    def draw(font)
      Gosu.draw_rect(0, 350, 800, 250, Gosu::Color::BLACK)
  
      font.draw_text(@question, 20, 370, 2)
  
      @options.each_with_index do |opt, i|
        prefix = i == @selected ? "> " : "  "
        font.draw_text(prefix + opt, 40, 420 + i*40, 2)
      end
    end
  
    def select(key)
      case key
      when Gosu::KB_UP
        @selected = (@selected - 1) % @options.size
      when Gosu::KB_DOWN
        @selected = (@selected + 1) % @options.size
      when Gosu::KB_RETURN
        return @selected
      end
      nil
    end
  end