# Create one grop
g = Group.find_or_create_by({primary_number: "48",
                         street_name: "Wall",
                         street_suffix: "St",
                         city_name: "New York",
                         state_abbreviation: "NY",
                         zipcode: "10005"})

# Create 5 Users
carol = User.create({first_name: "Carol",
                      user_id: "1",
                      last_name: "Shaw",
                      email:"carol.shaw@example.com",
                      group_id: g.id})

jean = User.create({first_name: "Jean",
                      user_id: "2",
                      last_name: "Sammet",
                      email:"jean.sammet@example.com",
                      group_id: g.id})

frances = User.create({first_name: "Frances",
                      user_id: "3",
                      last_name: "Allen",
                      email:"frances.allen@example.com",
                      group_id: g.id})

ada = User.create({first_name: "Ada",
                      user_id: "4",
                      last_name: "Lovelace",
                      email:"ada.lovelace@gmail.com",
                      group_id: g.id})

grace = User.create({first_name: "Grace",
                      user_id: "5",
                      last_name: "Hopper",
                      email:"grace.hopper@gmail.com",
                      group_id: g.id})

betty = User.create({first_name: "Betty",
                      user_id: "6",
                      last_name: "Holberton",
                      email:"betty.holberton@gmail.com",
                      group_id: g.id})

users = [carol, jean, frances, ada, grace, betty]

requests = ["I need baking soda.",
            "I need sugar.",
            "I need a hammer.",
            "Does anyone have some band-aids? Cooking is not my forte.",
            "I have friends and family over. Does anyone have a spare inflatable mattres?",
            "I need a homecooked meal. I can bring the wine!",
            "Ugh!!! My dog tore up my Official Scrabble dictionary again. Anyone have a spare I can borrow for the night?",
            "Missing chocolate chip cookies for my pancakes. Willing to share them with anyone that can provide.",
            "I need money...",
            "Trying to watch wedding video. Anyone have a VCR? (Not a joke!)",
            "Locked out of apt & phone dead. Can I use yours??",
            "Watched 24 hours of Walking Dead. I need help.",
            "Left-overs from last night's pot-luck. First come, first serve.",
            "Anyone have a printer? Just need to print 2 pages, black / white.",
            "Need a neighbor to help me translate a French poem. Google translate= bad.",
            "Need enough detergent for one load. Anyone want to help me same some cash?",
            "Anyone have a power drill I can use? Putting up shelves today!",
            "Making a huge dinner; don't have enough pots. Please help me neighborinos!",
            "My drone ran out of battries. If you have a few triple-Fs I'll let you fly little Emilia for a while.",
            "Trying to make a good impression on interviewer. Anyone have a power tie they can lend me?",
            "Forgot to send internet payment. Can someone lend me their wifi password, only need 30 minutes?"]


# create 5 request for each user
users.each do |user|
  other_users = users.select {|other_user| user.id != other_user.id  }

  # request has neighbor and is fulfilled
  2.times do |_|
    r = Request.create({content: requests.sample,
                        requester_id: user.id,
                        responder_id: other_users.sample.id,
                        group_id: user.group.id})
    r.is_fulfilled = true
    r.save
  end

  # create a conversation between responder and requester
  request_obj = Request.last
  timing = (1..45).to_a
  saluation = ["Hi.",
               "Hey.",
               "Hello.",
               "Hi there.",
               "Hey there.",
               "Hello there.",
               "Are you there?",
               "How are you?",
               "Hi neighbor!"]
  meeting_place = ["in the lobby",
                   "across the street",
                   "next to the vending machines",
                   "by the elevators",
                   "at the rooftop",
                   "in the game room"]
  party_ids = [request_obj.responder.id, request_obj.requester.id]
  Message.create({request_id: request_obj.id,
                  content: "#{saluation.sample} I think I can help you out.",
                  sender_id: party_ids[0]})
  Message.create({request_id: request_obj.id,
                  content: "Thank you that would be great!",
                  sender_id: party_ids[1]})
  Message.create({request_id: request_obj.id,
                  content: "I'd like to meet #{meeting_place.sample} if that's OK.",
                  sender_id: party_ids[0]})
  Message.create({request_id: request_obj.id,
                  content: "That's perfect. I can meet you in #{timing.sample} minutes.",
                  sender_id: party_ids[1]})
  Message.create({request_id: request_obj.id,
                  content: "See you then!",
                  sender_id: party_ids[0]})

  # create vote
  binary = [1, -1]
  candidate = party_ids.sample
  Vote.create({request_id: request_obj.id,
               candidate_id: candidate,
               value: binary.sample})

  if binary.sample > 0
    other_id = party_ids.select {|id| id != candidate }.first
    Vote.create({request_id: request_obj.id,
                candidate_id: other_id,
                value: binary.sample})
  end


  # request has neighbor but is not fulfilled
  2.times do |_|
    Request.create({content: requests.sample,
                    requester_id: user.id,
                    responder_id: other_users.sample.id,
                    group_id: user.group.id})
  end

  # request has no neighbor and is not fulfilled
  1.times do |_|
    Request.create({content: requests.sample,
                    requester_id: user.id,
                    group_id: user.group.id})
  end
end
