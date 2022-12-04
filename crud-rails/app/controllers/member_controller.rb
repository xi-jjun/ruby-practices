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

  def update
    member = Member.find(params[:id])
    member.name = params[:name]
    member.age = params[:age]
    member.description = params[:description]

    member.save

    render json: { "message" => "success to update member id=#{params[:id]}" }
  end

  def delete
    member = Member.find(params[:id])
    member.delete

    render json: { "message" => "success to remove member id=#{params[:id]}" }
  end
end
