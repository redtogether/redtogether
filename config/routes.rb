Rails.application.routes.draw do
  root "front_page#index"

  devise_for :users

  resources :channels, path: "c" do
    post "subscribe" => "channel#subscribe"
    post "unsubscribe" => "channel#unsubscribe"
  end

  resources :posts, path: "p" do
    resources :comments, path: "c" do
      post "reply" => "comment#reply"
    end
  end

end
