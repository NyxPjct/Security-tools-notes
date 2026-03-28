require_relative 'engine/scene'

def build_scene
  scene = Scene.new(self)

  scene.add(Dialogue.new("Fausto", "Todo conhecimento... e ainda sinto o vazio."))
  scene.add(Dialogue.new("Narrador", "A noite observa você..."))

  scene.add(Choice.new(
    "Invocar forças ocultas?",
    ["Sim", "Não", "Ignorar"]
  ))

  scene
end