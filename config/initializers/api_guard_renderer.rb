# https://github.com/Gokul595/api_guard/blob/master/lib/api_guard/response_formatters/renderer.rb
# https://stackoverflow.com/questions/19973836/rails-how-to-override-method-in-module-which-is-inside-class
ApiGuard::ResponseFormatters::Renderer.module_eval do
  def render_error(status, options = {})
    # data = { status: I18n.t('api_guard.response.error') }
    # data[:error] = options[:object] ? options[:object].errors.full_messages[0] : options[:message]
    data = { message: options[:object] ? options[:object].errors.full_messages[0] : options[:message] }

    render json: data, status: status
  end
end