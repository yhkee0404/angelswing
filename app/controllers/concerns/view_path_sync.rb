module ViewPathSync
  extend ActiveSupport::Concern

  included do
    prepend_view_path view_paths[0].to_s + '/' + File.dirname(File.dirname controller_path)
  end
end
