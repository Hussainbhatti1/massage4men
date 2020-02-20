module Admin::EmailsHelper
  def perform_replacements(str, target)
    # raise target.to_json
    EMAIL_INTERPOLATION_WHITELIST.each do |search|
      # Determine if this method is used
      if str.include? search
        callable_method = search.match(/{\$(.+)}/)[1].downcase.to_sym
        if target.respond_to? callable_method
          data = target.send(callable_method)
          str.gsub!(search, data.nil? ? '?' : data)          
        else
          raise NoMethodError, "Method #{callable_method} does not exist on object of class #{target.class.to_s}"
        end
      end
    end
    
    return str
  end
end
