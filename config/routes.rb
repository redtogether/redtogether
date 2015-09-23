Rails.application.routes.draw do
  root "front_page#index"

  devise_for :users

  resources :channels, path: "c" do
    post "subscribe" => "channels#subscribe"
    post "unsubscribe" => "channels#unsubscribe"
  end

  resources :posts, path: "p" do
    resources :comments, path: "c" do
      post "reply" => "comments#reply"
    end
  end

end
