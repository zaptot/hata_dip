# frozen_string_literal: true
# ClientSideValidations Initializer

# Disabled validators
# ClientSideValidations::Config.disabled_validators = []

# Uncomment to validate number format with current I18n locale
# ClientSideValidations::Config.number_format_with_locale = true

# Uncomment the following block if you want each input field to have the validation messages attached.
#
# Note: client_side_validation requires the error to be encapsulated within
# <label for="#{instance.send(:tag_id)}" class="message"></label>
#
ActionView::Base.field_error_proc = proc do |html_tag, instance|
  if html_tag =~ /^<label/
    html_tag.html_safe
  elsif html_tag =~ /^<input/
    node = Nokogiri::HTML(html_tag).at_css('input')
    node['class'] = [node['class'], 'is-invalid'].compact.join(' ')
    %(#{node.to_html}<div class="invalid-feedback">#{instance.error_message.first}</div>).html_safe
  end
end
