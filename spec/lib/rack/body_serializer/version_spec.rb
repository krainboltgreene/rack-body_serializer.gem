require "spec_helper"

describe Rack::BodySerializer::VERSION do
  it "should be a string" do
    expect(Rack::BodySerializer::VERSION).to be_kind_of(String)
  end
end
