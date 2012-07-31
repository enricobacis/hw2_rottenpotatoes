class Movie < ActiveRecord::Base
  def method_missing(method_id)
    /^all_(\w*)s$/.match(method_id.to_s)
    if self.column_names.include? $1
      self.select($1).group($1).map{|t| t.send($1)}
    else
      super
    end
  end
end
