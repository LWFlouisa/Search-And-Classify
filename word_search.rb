def word_search
  old_data = File.read("data/archive/model.txt")
  old_label = File.read("data/archive/label.txt")

  print "Create a label >> "; label = gets.chomp

  request  = label
  train_on = "a.train(:#{request}, '#{request}', 'word');"

  new_label = label

  ## Retrain the algorithm.
  open("script.rb", "w") { |f|
    f.puts 'require "naive_bayes"'
    f.puts "a = NaiveBayes.new(#{old_label}:#{new_label})"
    f.puts 'a.db_filepath = "data/baysian/language.nb"'
    f.puts "#{old_data}"
    f.puts "#{train_on}\n\n"
    f.puts 'a.save'
  }

  open("data/archive/model.txt", "w") { |f|
    f.puts train_on
  }

  open("data/archive/label.txt", "w") { |f|
    f.puts ":#{label}, "
  }

  system("ruby script.rb")

  ## Word search process
  require "duck_duck_go"
  require "naive_bayes"

  ddg = DuckDuckGo.new
  zci = ddg.zeroclickinfo(request) # ZeroClickInfo object

  header         = "What is a #{zci.heading}?"
  definition     = zci.abstract_text
  related_topics = zci.related_topics["_"][0].text

  open("queue/words/results.txt", "w") { |f|
    f.puts label
  }

  ## Classification process
  a = NaiveBayes.load('data/baysian/language.nb') 

  b = File.read("queue/words/results.txt").split(' ')

  a.classify(*b)

  classification = a.classify(*b)

  distribution = "The word #{request} with a label of #{classification[0]} has a probability of #{classification[1]} percent."

  ## AIML scripting process
  aiml_script = "<aiml version='1.0.1' encoding='UTF-8'>
  <category>
    <pattern>I want to talk about #{request}.</pattern>
    <template>For #{request}, what do you want to discuss?</template>
  </category>

  <topic this_topic='#{request}'>
    <category>
      <pattern>What is a #{request}</pattern>
      <template>#{definition} #{related_topics}</template>
    </category>

    <category>
      <pattern>What is the probability of #{request}?</pattern>
      <template>#{distribution}</template>
    </category>
  </topic>
</aiml>
  "

  open("chatbots/#{request}.aiml", "w") { |f|
    f.puts aiml_script
  }
end

word_search
