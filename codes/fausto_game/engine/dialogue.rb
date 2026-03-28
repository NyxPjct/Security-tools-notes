# engine/dialogue.rb
class Dialogue
    def initialize(name, text)
      @name = name
      @text = text
    end
  
    def draw(font)
      Gosu.draw_rect(0, 400, 800, 200, Gosu::Color::BLACK)
  
      font.draw_text("#{@name}:", 20, 420, 2)
      font.draw_text(@text, 20, 460, 2)
    end
  end