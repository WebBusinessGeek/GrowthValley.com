require 'spec_helper'

describe TransactionController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'paid'" do
    it "returns http success" do
      get 'paid'
      response.should be_success
    end
  end

  describe "GET 'revoked'" do
    it "returns http success" do
      get 'revoked'
      response.should be_success
    end
  end

  describe "GET 'ipn'" do
    it "returns http success" do
      get 'ipn'
      response.should be_success
    end
  end

end
