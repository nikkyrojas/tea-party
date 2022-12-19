require 'rails_helper'

RSpec.describe 'Subscription Api' do
  describe 'subscription request endpoint' do
    let(:green_tea) {Tea.create!(name: "Green Tea", description: "Green tea is a great source of antioxidants, can be uses to relieve headaches, promote weightloss, and help with digestive issues.", temp:150, brew_time: 3)}
    let(:manzanilla_tea) {Tea.create!(name: "Manzanilla Tea", description: "Manzanilla (Chamomile Tea) is used for medicinal purposes like: calming upset stomach, anxiety reducer, sleep improvement, ect.", temp:213, brew_time: 6)}
    let(:mike) {Customer.create!(first_name: "Mike", last_name: "Jones", email: "mikej@email.com", address: "2345 Some Street, CO")}
    let(:jolie) {Customer.create!(first_name: "Jolie", last_name: "Jones", email: "joliej@email.com", address: "2345 Another Street, CO")}
    let(:jolie_green_tea_sub) {Subscription.create!(title: "Green Tea subscription", price: "15", status:1, frequency:2, tea_id: green_tea.id, customer_id:jolie.id)}
    let(:jolie_manzanilla_tea_sub) {Subscription.create!(title: "Manzanilla Tea subscription", price: "12", status:1, frequency:2, tea_id: manzanilla_tea.id, customer_id:jolie.id)}
    context 'Happy Path', :vcr do
      it 'response is successful for creating a subscription' do 
        subscription_params = ({
                    "title": "Manzanilla subscription",
                    "price": 10,
                    "status": 1,
                    "frequency": 1,
                    "tea_id": "#{manzanilla_tea.id}",
                    "customer_id": "#{mike.id}"
                          })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription_params)

        expect(response).to be_successful
        expect(response.status).to eq(201)

        json_response = JSON.parse(response.body)
        
        new_subscription= Subscription.last

        expect(json_response).to be_a Hash
        expect(new_subscription.title).to eq("Manzanilla subscription")
        expect(new_subscription.price).to eq(10)
        expect(new_subscription.status).to eq("subscribed")
        expect(new_subscription.frequency).to eq("weekly")
      end 
      
      it 'response is successful for retrieving all subscriptions' do
        jolie_green_tea_sub
        jolie_manzanilla_tea_sub      

        get "/api/v1/subscriptions?"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        json_response = JSON.parse(response.body, symbolize_names: true)
        subscriptions = json_response[:data]
        
        expect(subscriptions).to be_a Array
        expect(subscriptions[0][:id]).to be_an Integer
        expect(subscriptions[0][:type]).to eq("subscription")
        expect(subscriptions[0][:attributes]).to be_a Hash
        expect(subscriptions[0][:attributes][:title]).to be_a String
        expect(subscriptions[0][:attributes][:status]).to be_a String
        expect(subscriptions[0][:attributes][:frequencey]).to be_an String
        expect(subscriptions[0][:attributes][:price]).to be_an Integer
      end 

      xit 'it deletes a subscription' do
        subscription1 = jolie_green_tea_sub
        subscription2 = jolie_manzanilla_tea_sub    
        expect{ delete "/api/v1/subscriptions/#{subscription2.id}"}.to change(subscription, :count).by(-1)
        expect(response).to be_successful
        expect(response.status).to eq(204)
      end 
    end
    context 'Edgecase Sad Path', :vcr do
      xit 'return error if a param is missing for create', :vcr do 
        fsubscription_params = ({
                    "title": "Manzanilla subscription",
                    "price": 10,
                    "status": 1,
                    "tea_id": "#{manzanilla_tea.id}",
                          })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription_params)
        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(response.body).to include("something went wrong, param may be missing")
      end 
    end
  end
end