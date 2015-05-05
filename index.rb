require "sinatra"

# Function to convert birthdate into single digit
def get_one_digit(n)
  if n.length > 1
    n = n.chars.to_a
    n.map! { |i| i.to_i }
    n = n.reduce(:+).to_s
    get_one_digit(n)
  else
    return n.to_i
  end
end

# Matches Number with Message
def get_path_message(n)
  case n
  when 1
    message = "Your numerology number is 1.\nOne is the leader. The number one indicates the ability to stand alone, and is a strong vibration. Ruled by the Sun."
  when 2
    message = "Your numerology number is 2.\nThis is the mediator and peace-lover. The number two indicates the desire for harmony. It is a gentle, considerate, and sensitive vibration. Ruled by the Moon."
  when 3
    message = "Your numerology number is 3.\nNumber Three is a sociable, friendly, and outgoing vibration. Kind, positive, and optimistic, Three's enjoy life and have a good sense of humor. Ruled by Jupiter."
  when 4
    message = "Your numerology number is 4.\nThis is the worker. Practical, with a love of detail, Fours are trustworthy, hard-working, and helpful. Ruled by Uranus."
  when 5
    message = "Your numerology number is 5.\nThis is the freedom lover. The number five is an intellectual vibration. These are 'idea' people with a love of variety and the ability to adapt to most situations. Ruled by Mercury."
  when 6
    message = "Your numerology number is 6.\nThis is the peace lover. The number six is a loving, stable, and harmonious vibration. Ruled by Venus."
  when 7
    message = "Your numerology number is 7.\nThis is the deep thinker. The number seven is a spiritual vibration. These people are not very attached to material things, are introspective, and generally quiet. Ruled by Neptune."
  when 8
    message = "Your numerology number is 8.\nThis is the manager. Number Eight is a strong, successful, and material vibration. Ruled by Saturn."
  when 9
    message = "Your numerology number is 9.\nThis is the teacher. Number Nine is a tolerant, somewhat impractical, and sympathetic vibration. Ruled by Mars."
  end
end

def setup_index_view
  birthdate = params[:birthdate]
  path_number = get_one_digit(birthdate)
  @message = get_path_message(path_number)
end

def valid_birthdate(input)
  if input.length == 8 && input.match(/^[0-9]+[0-9]$/)
    return true
  else
    return false
  end
end

get '/' do
  erb :form
end

post '/' do
  birthdate = params[:birthdate].gsub("-","")
  if valid_birthdate(birthdate)
    path_number = get_one_digit(birthdate)
    redirect "/message/#{path_number}"
  else
    @error = "Your submission was invalid! Use the MMDDYYYY format."
    erb :form
  end
end

get '/message/:path_number' do
  path_number = params[:path_number].to_i
  @message = get_path_message(path_number)
  erb :index
end

get '/bigfour/' do
  @show = get_path_message(4).upcase
  erb :bigfour
end

get '/:birthdate' do
  setup_index_view
  erb :index
end
