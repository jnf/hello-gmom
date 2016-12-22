Rails.application.routes.draw do
  controller :messages do
    post 'incoming'
  end
end
