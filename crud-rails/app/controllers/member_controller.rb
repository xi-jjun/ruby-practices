class MemberController < ApplicationController
  def create
    member = Member.create(name: params[:name], age: params[:age], description: params[:description])
    member.save

    render json: { "message" => "success to save" }
  end
end
