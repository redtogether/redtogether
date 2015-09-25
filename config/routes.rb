Rails.application.routes.draw do
  root "front_page#index"

  devise_for :users

  get "+all" => "front_page#all"

  resources :channels, path: "", id: /\+\w+/ do
    post "subscribe" => "channels#subscribe"
    post "unsubscribe" => "channels#unsubscribe"

    resources :posts, path: "",
      only: [:new, :create],
      path_names: { new: "submit" }
  end

  resources :posts do
    resources :comments do
      post "reply" => "comments#reply"
    end
  end

  resources :users

end
