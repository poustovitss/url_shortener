Rails.application.routes.draw do
  root 'urls#new'

  get '/new', to: 'urls#new'
  get '/url/:unique_hash', to: 'urls#show', as: 'url'
  post '/urls', to: 'urls#create'
end
