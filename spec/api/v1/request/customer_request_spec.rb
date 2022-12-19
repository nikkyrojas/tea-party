require 'rails_helper'

RSpec.describe 'Customer Api' do
  describe 'customer request endpoint' do
    context 'Happy Path', :vcr do
      it 'response is successful' do 
          customer_params = ({
                  "first_name": "Nikky",
                  "last_name": "Ro",
                  "address": "1234 Main St. Denver CO",
                  "email": "testing123@example.com"
                })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/customers", headers: headers, params: JSON.generate(customer_params)

        expect(response).to be_successful
        expect(response.status).to eq(201)
        json_response = JSON.parse(response.body)
        
        new_customer = Customer.last

        expect(json_response).to be_a Hash
        expect(new_customer.email).to eq("testing123@example.com")
        expect(new_customer.first_name).to eq("Nikky")
        expect(new_customer.last_name).to eq("Ro")
        expect(new_customer.address).to eq("1234 Main St. Denver CO")
      end 
    end
    context 'Edgecase Sad Path', :vcr do
      it 'return error if param is missing', :vcr do 
        customer_params = ({
                        "name": "Test Example",
                        "email": "testing@example.com"
                      })

        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v1/customers", headers: headers, params: JSON.generate(customer_params)
        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(response.body).to include("One or all of the following have occured: Email already exist or field is missing")
      end 
    end
  end
end