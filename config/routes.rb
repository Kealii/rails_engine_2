Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do

      resources :customers,      only: [:index, :show] do
        resources :invoices,     only: [:index], controller: :customers_invoices
        resources :transactions, only: [:index], controller: :customers_transactions
        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :invoice_items, only: [:index, :show] do
        resources :invoice,     only: [:index], controller: :invoice_items_invoice
        resources :item,        only: [:index], controller: :invoice_items_item

        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :invoices,        only: [:index, :show] do
        resources :transactions,  only: [:index], controller: :invoice_transactions
        resources :invoice_items, only: [:index], controller: :invoice_invoice_items
        resources :items,         only: [:index], controller: :invoices_items
        resources :customer,      only: [:index], controller: :invoice_customer
        resources :merchant,      only: [:index], controller: :invoice_merchant
        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :items,           only: [:index, :show] do
        resources :invoice_items, only: [:index], controller: :items_invoice_items
        resources :merchant,      only: [:index], controller: :items_merchant
        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :merchants,  only: [:index, :show] do
        resources :items,    only: [:index], controller: :merchant_items
        resources :invoices, only: [:index], controller: :merchant_invoices
        get :revenue

        collection do
          get :find
          get :find_all
          get :random
        end
      end

      resources :transactions,  only: [:index, :show] do
        resources :invoice,     only: [:index], controller: :transactions_invoice
        collection do
          get :find
          get :find_all
          get :random
        end
      end
    end
  end
end
