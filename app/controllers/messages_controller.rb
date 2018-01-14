class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session
  # GET /messages/1
  # GET /messages/1.json
  def show
    message = Message.find_by rsaid: params[:id], id: params[:msgid];
    respond_to do |format|
        format.json {render json: {'message' => message.message}}
    end
  end
  # GET /messages/new
  def new
    rsa = Rsa.find_by id: params[:id];

    crypted = params[:message].each_char.map {|c| ((c.ord ** rsa.e % rsa.n)).to_s }.join(":")
    message = Message.new({rsaid: rsa.id, message: crypted})
    respond_to do |format|
      if message.save
        format.json {render json: {'id' => message.id}}
      end
  end
  end
  def decrypt
      rsa = Rsa.find_by id: params[:id];
      decrypted = params[:message].split(":").map{| chunk | (chunk.to_i ** rsa.d % rsa.n).chr }.join("")
      respond_to do |format|
        format.json {render json: {'message' => decrypted}}
      end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:rsaid, :message)
    end
end
