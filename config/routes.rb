Rails.application.routes.draw do
  controller :messages do
    post 'incoming'
  end

  controller :display do
    get 'show'
  end
end
