module ViewPathSync
  extend ActiveSupport::Concern

  included do
    prepend_view_path view_paths[0].to_s + '/' + module_parents[-3].to_s.underscore
  end
end
