require 'rspec/expectations'

RSpec::Matchers.define :eq_as_json do |expected|
  match do |actual|
    expect(json_like actual).to eq json_like(expected)
  end

  failure_message do |actual|
    "expected:\n#{json_like expected}:\ngot:\n#{json_like actual}"
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
