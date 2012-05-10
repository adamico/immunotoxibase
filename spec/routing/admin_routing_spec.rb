require "spec_helper"

describe "routes for administration" do
  %w(chapters families molecules).each do |model|
    it "routes /admin/#{model}/new to #{model}#new" do
      { get: "/admin/#{model}/new" }.should route_to(
        controller: "#{model}",
        action: "new"
      )
    end
    it "routes POST /admin/#{model} to #{model}#create" do
      { post: "/admin/#{model}" }.should route_to(
        controller: "#{model}",
        action: "create"
      )
    end
    it "routes /admin/#{model}/:id/edit to #{model}#edit for chapter id" do
      { get: "/admin/#{model}/1/edit" }.should route_to(
        controller: "#{model}",
        action: "edit",
        id: "1"
      )
    end
    it "routes PUT /admin/#{model}/id to #{model}#update for chapter id" do
      { put: "/admin/#{model}/1" }.should route_to(
        controller: "#{model}",
        action: "update",
        id: "1"
      )
    end
    it "routes DELETE /admin/#{model}/id to #{model}#destroy for chapter id" do
      { delete: "/admin/#{model}/1" }.should route_to(
        controller: "#{model}",
        action: "destroy",
        id: "1"
      )
    end
  end
end
