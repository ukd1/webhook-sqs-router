WebhookSqsRouter::Application.routes.draw do
  root 'application#index'

  match "*path", via: [:get, :post], to: "application#queue", as: 'queue'
end
