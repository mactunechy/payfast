resources :carts do
  member do
    get "make-payment", to: "carts#make_payment", as: :make_payment
    get "success", to: "carts#success", as: :success
    get "failure", to: "carts#failure", as: :failure
  end
end
