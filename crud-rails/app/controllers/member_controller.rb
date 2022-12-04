class MemberController < ApplicationController
  def show
    member = Member.find(params[:id])
    render json: member
  end

  def create
    member = Member.create(name: params[:name], age: params[:age], description: params[:description])
    member.save

    render json: { "message" => "success to save" }
  end
end
