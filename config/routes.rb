Rails.application.routes.draw do
  resources :messages
  resources :rs_as

  post '/rsas' => 'rs_as#new'
  get '/rsas/:id' => 'rs_as#show'
  post '/rsas/:id/encrypt_messages' => 'messages#new'
  get '/rsas/:id/encrypt_messages/:msgid' => 'messages#show'
  post '/rsas/:id/decrypt_messages' => 'messages#decrypt'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
