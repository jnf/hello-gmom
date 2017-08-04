Rails.application.routes.draw do
  root 'display#show'

  mount ActionCable.server => '/cable'

  controller :messages do
    post 'incoming'
  end

  controller :display do
    get 'show'
    get ':sender', action: :by_sender, as: :show_sender
  end

  get '/api/redirect/:name', to: 'redirects#incoming'
end
