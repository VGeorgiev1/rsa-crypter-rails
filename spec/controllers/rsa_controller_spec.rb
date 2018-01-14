RSpec.describe RsAsController do
    
    it "should create rsa without args" do
        post :new, as: :json
        expect(Rsa.where(id: JSON.parse(response.body)["id"])).to exist
    end 
    it "should create rsa with parameters" do
        post :new, params: {n: 1000, e: 2000, d: 3000}, as: :json
        expect(Rsa.where(id: JSON.parse(response.body)["id"])).to exist
        rsa = Rsa.find_by id: JSON.parse(response.body)["id"]
        expect(rsa.n).to eq 1000
        expect(rsa.e).to eq 2000
        expect(rsa.d).to eq 3000
    end
    it "should get a rsa with a specific id" do
        post :new,as: :json
        rsaid =  JSON.parse(response.body)["id"]
        get :show, params: {id: rsaid}
        expect(response.header["Content-Type"]).to eq "application/json; charset=utf-8"
    end
end