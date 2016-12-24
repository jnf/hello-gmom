Rails.application.routes.draw do
  root 'display#show'

  mount ActionCable.server => '/cable'

  controller :messages do
    post 'incoming'
  end

  controller :display do
    get 'show'
  end
end
