# https://gist.github.com/jeremyw/5319386
# Monkey patch to remove memoization from Devise mapping lookup.
# We need to be able to switch between different mappings at runtime
# in order to authenticate different types of users.
module Devise
  module Strategies
    class Base
      def mapping
        # @mapping ||= begin
          mapping = Devise.mappings[scope]
          raise "Could not find mapping for #{scope}" unless mapping
          mapping
        # end
      end
    end
  end
end