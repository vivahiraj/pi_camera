# encoding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe "App" do
  describe 'GET /' do
    before :all do
      get '/'
    end
    it "statusコードは200" do
      last_response.ok?.should be_true
    end
    it "responseは'PI CAMERA'を含む" do
      last_response.body.should include("PI CAMERA")
    end
  end
end

