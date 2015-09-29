Rails.application.routes.draw do
  root "front_page#index"

  devise_for :users

  get "+all" => "front_page#all"

  resources :channels,
    path: "",
    id: /\+\w+/ do

    post "subscribe" => "channels#subscribe"
    post "unsubscribe" => "channels#unsubscribe"

    resources :posts,
      path: "",
      id: /[\w-]+/,
      except: [:index],
      path_names: { new: "submit" } do

      put "upvote" => "posts#upvote"
      put "downvote" => "posts#downvote"
      delete "unvote" => "posts#unvote"

      resources :comments do
        post "reply" => "comments#reply"

        put "upvote" => "comments#upvote"
        put "downvote" => "comments#downvote"
        delete "unvote" => "comments#unvote"
      end
    end
  end

  resources :users,
    path: "",
    id: /@\w+/,
    only: [:show]
end
