senders = [
  {
    number: ENV['JNF_PHONE'],
    name: 'Jeremy',
    avatar: 'jnf.jpg'
  },
  {
    number: ENV['BAF_PHONE'],
    name: 'Brenna',
    avatar: 'baf.jpg'
  },
  {
    number: '111111111',
    name: 'Rosa',
    avatar: 'rosa.jpg'
  }
]

senders.each do |sender|
  Sender.create({
    name:   sender[:name],
    number: sender[:number],
    avatar: File.new(File.join(Rails.root, 'public', 'senders', sender[:avatar])),
  })
end

messages = {
  square: {
    sender: Sender.find(rand(3) + 1),
    image: File.new(File.join(Rails.root, 'public', 'messages', 'square.jpg')),
    location: 'Seattle, WA, USA',
    body: 'Spring flowers 🌺  on a morning walk.'
  },
  tall: {
    sender: Sender.find(rand(3) + 1),
    image: File.new(File.join(Rails.root, 'public', 'messages', 'tall.jpg')),
    location: 'Seattle, WA, USA',
    body: 'The raspberries are really growing!'
  },
  wide: {
    sender: Sender.find(rand(3) + 1),
    image: File.new(File.join(Rails.root, 'public', 'messages', 'wide.jpg')),
    location: 'Vancouver, BC, Canada',
    body: 'From our trip to Vancouver -- it is really beautiful here.'
  }
}

messages.each { |key, message| Message.create(message)}
