require "uri"
require "json"
require "net/http"

class Paymob::Base
    attr_accessor :result
    BASE_URL = "https://pakistan.paymob.com/"

    API_KEY = "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRRM016a3dMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuNnBEQWhKMF9sRy0zSEkwd0RaMXFiZDFxMEpCWXVvUHpTTFJJZFVHWW1GbE40Z2gxT1pJaEluQVh1YllzX0lxSFhlVXFZR3RSclRoeXptU3JKLUhpM1E="

    def send_request

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(url)
        request["Authorization"] = API_KEY
        request["Content-Type"] = "application/json"
        request.body = request_body
        response = https.request(request)
        response.read_body
    end

end