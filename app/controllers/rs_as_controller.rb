require "prime.rb" 
class RsAsController < ApplicationController
  before_action :set_rsa, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  def generate
    p = Prime.first 200
    q = Prime.first 200
    p = p.at(rand(1...200))
    loop do 
        q = q.at(rand(1...200))
        break if p != q
    end
    n = p * q
    tot = (p-1).lcm(q-1)
    e = 0;
    loop do
        e = rand(1...tot)
        break if e.gcd(tot) == 1
    end   
    d = 0
    inv = 0
    loop do
        if (e * inv) % tot == 1
           d = inv
           break
        end
        inv+=1
    end
    [n,e,d]
  end

  # GET /rsas/1
  # GET /rsas/1.json
  def show
    rsa = Rsa.find_by id: params[:id];
    respond_to do |format|
        format.json {render json: {'n' => rsa.n , 'e' => rsa.e,  'd' => rsa.d}}
    end
  end

  # GET /rsas/new
  def new
    required = [:n,:e,:d]
    if required.all? {|k| params.has_key? k}
      rsa = Rsa.new({d: params[:d], e: params[:e], n: params[:n]})
    else
      keys = generate()

      rsa = Rsa.new({d: keys[2], e: keys[1], n: keys[0]})
    end
 
    respond_to do |format|
        if rsa.save
          format.json {render json: {'id' => rsa.id}}
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rsa
      @rsa = Rsa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rsa_params
      params.require(:rsa).permit(:d, :e, :n)
    end
end
