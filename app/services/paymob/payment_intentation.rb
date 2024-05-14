module Paymob
    class PaymentIntentation < Base
        attr_reader :user, :quantity, :amount
        def initialize(user, quantity, amount)
          @user = user
          @quantity = quantity
          @amount = amount
        end
        def create
            @result = send_request
        end

        def url
            @url ||= URI("#{BASE_URL}v1/intention/")
        end

        def request_body
            JSON.dump({
                "amount": amount,
                "currency": "PKR",
                "payment_methods": [
                    12,
                    "card, you can add your integration id directly as well as integration id name (If you are a new user kindly add your integratio id number)"
                ],
                "items": [
                    {
                    "name": "paid ad",
                    "amount": amount,
                    "description": "Paid ads buy",
                    "quantity": quantity
                    }
                ],
                "customer": {
                    "first_name": user.name,
                    "last_name": user.name,
                    "email": user.email,
                }
                })
        end
    end
end