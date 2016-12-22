senders = [
  {
    number: ENV['JNF_PHONE'],
    name: 'Jeremy',
    avatar: 'jnf.jpg'
  },
  {
    number: ENV['BAF_PHONE'],
    name: 'Brenna',
    avatar: 'brennx0r.jpg'
  }
]

senders.each do |sender|
  Sender.create({
    name:   sender[:name],
    number: sender[:number],
    avatar: File.new(File.join(Rails.root, 'public', 'senders', sender[:avatar])),
  })
end
