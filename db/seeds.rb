# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create a single group

g = Group.find_or_create_by({primary_number: "48",
                         street_name: "Wall",
                         street_suffix: "St",
                         city_name: "New York",
                         state_abbreviation: "NY",
                         zipcode: "10005"})

# Create 5 Users, all in the same group
steven = User.create({first_name: "Steven",
                      last_name: "Leiva",
                      email:"leiva.steven@gmail.com",
                      group_id: g.id})

sarah = User.create({first_name: "Sarah",
                      last_name: "O'Shea",
                      email:"sarah.oshea@gmail.com",
                      group_id: g.id})

chan = User.create({first_name: "Chanyoung",
                      last_name: "Kim",
                      email:"chanyoung.kim@gmail.com",
                      group_id: g.id})

ada = User.create({first_name: "Ada",
                      last_name: "Lovelace",
                      email:"ada.lovelace@gmail.com",
                      group_id: g.id})

grace = User.create({first_name: "Grace",
                      last_name: "Hopper",
                      email:"grace.hopper@gmail.com",
                      group_id: g.id})

betty = User.create({first_name: "Betty",
                      last_name: "Holberton",
                      email:"betty.holberton@gmail.com",
                      group_id: g.id})

users = [steven, sarah, chan, ada, grace, betty]

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


# create 5 request for each user, in 3 different states
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


  # request has neighbor but is not fulfilled
  2.times do |_|
    Request.create({content: requests.sample,
                    requester_id: user.id,
                    responder_id: other_users.sample.id,
                    group_id: user.group.id})
  end

  1.times do |_|
    Request.create({content: requests.sample,
                    requester_id: user.id,
                    group_id: user.group.id})
  end

  binding.pry
end
