require 'programr'

bot_name = "BIANCA"
usr_name = "SARAH"

brains = Dir.glob("chatbots/*")

robot = ProgramR::Facade.new
robot.learn(brains)

puts " Welcome to Bianca. This is the terminal for my chatbot. She can perform ciphers, write poetry, study pictures, learn new words, and how to classify them."

while true
  print "#{usr_name } >> "
  s = STDIN.gets.chomp

  reaction = robot.get_reaction(s)

  if reaction == ""
    # reaction.play("en")

    STDOUT.puts "#{bot_name} << Sorry, I don't know."
  #elsif reaction ==        "I will perform a toy cipher.";        mixed_13
  #elsif reaction ==            "I will write you a poem.";    write_poetry
  #elsif reaction ==           "Lets study some pictures.";    check_images
  #elsif reaction ==              "Lets learn some words.";    train_bianca
  #elsif reaction ==         "Give me a word to classify."; bianca_classify
  #elsif reaction == "Teach me the meaning of a new word.";     duck_search
  else
    STDOUT.puts "#{bot_name} << #{reaction}"
  end
end
