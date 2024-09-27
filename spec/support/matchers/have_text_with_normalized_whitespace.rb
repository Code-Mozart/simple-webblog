matcher_class = Capybara::RSpecMatchers::Matchers::HaveText
type_mapping = {
  only_visible_text: :visible,
  include_hidden_text: :all
}

RSpec::Matchers.define :have_text_with_normalized_whitespace do |expected, type = :only_visible_text|
  unless type.in? type_mapping.keys
    raise ArgumentError("`type` must be `:only_visible_text` or `:include_hidden_text`, but was #{type}")
  end

  normalized_expected = expected.gsub(/\n+/, " ")
  type = type_mapping[type]
  matcher = matcher_class.new(type, normalized_expected, normalize_ws: true)

  match { |actual| matcher.matches? actual }
  failure_message { matcher.failure_message }
  failure_message_when_negated { matcher.failure_message_when_negated }
  description { matcher.description }
end
