# main.rb
require 'gosu'
require_relative 'engine/dialogue'
require_relative 'engine/choice'

class Game < Gosu::Window
  def initialize
    super 800, 600
    self.caption = "FAUSTO VISUAL NOVEL"

    @bg = Gosu::Image.new("assets/bg.png")
    @fausto = Gosu::Image.new("assets/fausto.png")
    @mefisto = Gosu::Image.new("assets/mefisto.png")

    @font = Gosu::Font.new(24)

    @scene_index = 0
    @dialogue = build_story
    @choice = nil

    @alma = 100
    @corrupcao = 0
  end

  # ===== HISTÓRIA =====
  def build_story
    [
      Dialogue.new("Fausto", "Todo conhecimento... e ainda sinto o vazio."),
      Dialogue.new("Narrador", "A noite parece observar você..."),
      :choice_invocar
    ]
  end

  def update; end
  def draw_background
    img_ratio = @bg.width.to_f / @bg.height
    screen_ratio = width.to_f / height
  
    if img_ratio > screen_ratio
      # imagem mais larga → corta lados
      scale = height.to_f / @bg.height
      new_width = @bg.width * scale
      x = (width - new_width) / 2
      y = 0
    else
      # imagem mais alta → corta topo/baixo
      scale = width.to_f / @bg.width
      new_height = @bg.height * scale
      x = 0
      y = (height - new_height) / 2
    end
  
    @bg.draw(x, y, 0, scale, scale)
  end
  def draw
  draw_background

  # personagem
  @fausto.draw(400,100,1,1,1)

  # diálogo
  if @choice
    @choice.draw(@font)
  else
    @dialogue[@scene_index]&.draw(@font)
  end

  draw_stats
end

  def draw_stats
    @font.draw_text("Alma: #{@alma}", 10, 10, 2)
    @font.draw_text("Corrupção: #{@corrupcao}", 10, 30, 2)
  end

  def button_down(id)
    if @choice
      handle_choice(id)
    else
      next_scene if id == Gosu::KB_SPACE
    end
  end

  # ===== FLUXO =====
  def next_scene
    @scene_index += 1

    case @dialogue[@scene_index]
    when :choice_invocar
      @choice = Choice.new(
        "Invocar forças?",
        ["Sim", "Não", "Ignorar"],
      )
    end
  end

  def handle_choice(id)
    result = @choice.select(id)

    return unless result

    case result
    when 0
      @corrupcao += 20
      @dialogue << Dialogue.new("Mefisto", "Você me chamou...")
    when 1
      @alma += 10
      @dialogue << Dialogue.new("Narrador", "Você resiste...")
    when 2
      @dialogue << Dialogue.new("Narrador", "O silêncio continua...")
    end

    @choice = nil
    @scene_index += 1
  end
end

Game.new.show