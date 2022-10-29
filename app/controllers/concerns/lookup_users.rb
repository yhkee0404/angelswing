module LookupUsers
  extend ActiveSupport::Concern

  included do
    # https://stackoverflow.com/questions/7293894/is-there-a-way-to-add-a-custom-folder-to-the-partials-path
    _prefixes.prepend :users
  end
end
