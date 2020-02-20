# http://stackoverflow.com/a/151636
class Hash
  def to_obj
    self.inject(Object.new) do |obj, ary| # ary is [:key, "value"]
      obj.instance_variable_set("@#{ary[0]}", ary[1])
      class << obj; self; end.instance_eval do # do this on obj's metaclass
        attr_reader ary[0].to_sym # add getter method for this ivar
      end
      obj # return obj for next iteration
    end
  end
end