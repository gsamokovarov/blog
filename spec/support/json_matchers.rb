require 'rspec/expectations'

RSpec::Matchers.define :eq_as_json do |expected|
  match do |actual|
    expect(json_like expected).to eq json_like(actual)
  end

  def json_like(value)
    case value
    when Hash, Array
      value
    else
      JSON.parse(value)
    end.deep_symbolize_keys
  end
end
