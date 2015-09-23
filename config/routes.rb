Rails.application.routes.draw do
  root "front_page#index"

  devise_for :users

  resources :channels, path: "c" do
    post "subscribe" => "channels#subscribe"
    post "unsubscribe" => "channels#unsubscribe"

    resources :posts, path: "p", only: [:new, :create]
  end

  resources :posts, path: "p" do
    resources :comments, path: "c" do
      post "reply" => "comments#reply"
    end
  end

end
