RSpec.describe MessagesController do
    
    it "should create message" do
        post :new, params: {id: 1, message: "Hello there guys!"}, as: :json
        expect(Message.where(id: JSON.parse(response.body)["id"])).to exist
    end 
    it "should return the crypted message" do
        post :new, params: {id: 1, message: "Hello there guys!"}, as: :json
        id = JSON.parse(response.body)["id"]
        get :show, params: {id: 1, msgid: id}, as: :json
        expect(response.header["Content-Type"]).to eq "application/json; charset=utf-8"
        expect(JSON.parse(response.body)).not_to be_empty
    end
    it "should encrypt and decrypt a message" do   
       post :decrypt, params: {id: 1, message: "15841:5339:10931:10931:4625:9048:19701:5689:5339:10566:5339:9048:15591:783:19969:5945:17032"}, as: :json ## encrypted "Hello there guys!" with the keys for id 1
       expect(JSON.parse(response.body)["message"]).to eq "Hello there guys!"
      
    end
end


