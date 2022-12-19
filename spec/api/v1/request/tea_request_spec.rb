require 'rails_helper'

RSpec.describe 'Subscriptions Api' do
  describe 'tea request endpoint' do
    let (:green_tea) {Tea.create!(name: "Green Tea", description: "Green tea is a great source of antioxidants, can be uses to relieve headaches, promote weightloss, and help with digestive issues.", temp:150, brew_time: 3)}
    context 'Happy Path', :vcr do
      it 'response is successful for creating a tea' do 
        green_tea
        tea_params = ({
                    "name": "Manzanilla Tea",
                    "description": "Manzanilla (Chamomile Tea) is used for medicinal purposes such as : calming upset stomach, anxiety reducer, sleep improement, cect.",
                    "temp": 212,
                    "brew_time": 6
                          })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/teas", headers: headers, params: JSON.generate(tea_params)

        expect(response).to be_successful
        expect(response.status).to eq(201)

        json_response = JSON.parse(response.body)
        
        new_tea = Tea.last
        expect(json_response).to be_a Hash
        expect(new_tea.name).to eq("Manzanilla Tea")
        expect(new_tea.name).to_not eq("Green Tea")
        expect(new_tea.temp).to eq(212)
        expect(new_tea.brew_time).to eq(6)
      end 
      
      it 'response is successful for retrieving all teas' do
          tea_params = ({
                      "name": "Manzanilla Tea",
                      "description": "Manzanilla (Chamomile Tea) is used for medicinal purposes like: calming upset stomach, anxiety reducer, sleep improvement, ect.",
                      "temp": 212,
                      "brew_time": 6
                            })
          headers = {"CONTENT_TYPE" => "application/json"}
          post "/api/v1/teas", headers: headers, params: JSON.generate(tea_params)

          get "/api/v1/teas?"

          expect(response).to be_successful
          expect(response.status).to eq(200)

          json_response = JSON.parse(response.body, symbolize_names: true)
          teas = json_response[:data]
          
          expect(teas).to be_a Array
          expect(teas[0][:id]).to be_an Integer
          expect(teas[0][:type]).to eq("tea")
          expect(teas[0][:attributes]).to be_a Hash
          expect(teas[0][:attributes][:name]).to be_a String
          expect(teas[0][:attributes][:description]).to be_a String
          expect(teas[0][:attributes][:temp]).to be_an Integer
          expect(teas[0][:attributes][:brew_time]).to be_an Integer
        end 

      xit 'it deletes a tea' do
        tea = Tea.create!(name: "Green Tea", description: "Green tea is a great source of antioxidants, can be uses to relieve headaches, promote weightloss, and help with digestive issues.", temp:150, brew_time: 3)
        
        expect{ delete "/api/v1/teas/#{tea.id}"}.to change(Tea, :count).by(-1)
        expect(response).to be_successful
        expect(response.status).to eq(204)
      end 
    end
    context 'Edgecase Sad Path', :vcr do
      xit 'return error if a param is missing', :vcr do 
        subscription_params = ({
                    "name": "Ginger Tea",
                    "description": "Ginger tea is good for motion sickness relief, eleviate nausea, and may help manage blood pressure ",
                    "brew_time": "10"
                          })
        headers = {"CONTENT_TYPE" => "application/json"}

        post "/api/v1/teas", headers: headers, params: JSON.generate(subscription_params)
        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(response.body).to include("something went wrong, param may be missing")
      end 
    end
  end
end