Rails.application.routes.draw do
  root 'display#show'
  controller :messages do
    post 'incoming'
  end

  controller :display do
    get 'show'
  end
end
