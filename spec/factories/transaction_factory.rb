FactoryGirl.define do
  factory :transaction do
    invoice
    credit_card_number '4242424242424242'
    credit_card_expiration_date ' '
    result 'success'
  end
end