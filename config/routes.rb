Rails.application.routes.draw do
  root "front_page#index"

  devise_for :users

  resources :channels, path: "c" do
    post "subscribe" => "channels#subscribe"
    post "unsubscribe" => "channels#unsubscribe"

    resources :posts, path: "",
      only: [:new, :create],
      path_names: { new: "submit" }
  end

  resources :posts, path: "p" do
    resources :comments, path: "x" do
      post "reply" => "comments#reply"
    end
  end

end
