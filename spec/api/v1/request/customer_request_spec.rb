require 'rails_helper'

RSpec.describe 'Customer Api' do
  describe 'customer request endpoint' do
    let(:green_tea) {Tea.create!(name: "Green Tea", description: "Green tea is a great source of antioxidants, can be uses to relieve headaches, promote weightloss, and help with digestive issues.", temp:150, brew_time: 3)}
    let(:manzanilla_tea) {Tea.create!(name: "Manzanilla Tea", description: "Manzanilla (Chamomile Tea) is used for medicinal purposes like: calming upset stomach, anxiety reducer, sleep improvement, ect.", temp:213, brew_time: 6)}
    let(:mike) {Customer.create!(first_name: "Mike", last_name: "Jones", email: "mikej@email.com", address: "2345 Some Street, CO", password:"12345", password_confirmation: "12345")}
    let(:jolie) {Customer.create!(first_name: "Jolie", last_name: "Jones", email: "joliej@email.com", address: "2345 Another Street, CO", password:"12345", password_confirmation: "12345")}
    let(:jolie_green_tea_sub) {Subscription.create!(title: "Green Tea subscription", price: "15", status:1, frequency:2, tea_id: green_tea.id, customer_id:jolie.id)}
    let(:jolie_manzanilla_tea_sub) {Subscription.create!(title: "Manzanilla Tea subscription", price: "12", status:1, frequency:2, tea_id: manzanilla_tea.id, customer_id:jolie.id)}
    context 'Happy Path', :vcr do
      it 'response is successful' do 
          customer_params = ({
                  "first_name": "Nikky",
                  "last_name": "Ro",
                  "address": "1234 Main St. Denver CO",
                  "email": "testing123@example.com",
                  "password": "testing123@example.com",
                  "password_confirmation": "testing123@example.com"
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
            it 'response is successful for retrieving all subscriptions by customer id' do
        jolie_green_tea_sub
        jolie_manzanilla_tea_sub    
        Subscription.create!(title: "Another subscription for mike", price: "15", status:1, frequency:2, tea_id: green_tea.id, customer_id:mike.id)

        get "/api/v1/customers/#{jolie.id}"
        expect(response).to be_successful
        expect(response.status).to eq(200)

        json_response = JSON.parse(response.body, symbolize_names: true)
        subscriptions = json_response[:data]
        expect(subscriptions).to be_a Array
        expect(subscriptions.count).to eq (2)
        expect(subscriptions[0][:id]).to be_an Integer
        expect(subscriptions[0][:type]).to eq("subscription")
        expect(subscriptions[0][:attributes]).to be_a Hash
        expect(subscriptions[0][:attributes][:title]).to be_a String
        expect(subscriptions[0][:attributes][:title]).to eq ("Green Tea subscription")
        expect(subscriptions[0][:attributes][:status]).to be_a String
        expect(subscriptions[0][:attributes][:status]).to eq ("subscribed")

        expect(subscriptions[0][:attributes][:frequency]).to be_an String
        expect(subscriptions[0][:attributes][:frequency]).to eq ("monthly")
        expect(subscriptions[0][:attributes][:price]).to be_an Integer
        expect(subscriptions[0][:attributes][:price]).to eq 15
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
        expect(response.body).to include("One or all of the following have occured: Passwords do not match,  Email already exist, or Field is missing")
      end 
    end
  end
end