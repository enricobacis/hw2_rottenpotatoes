class Movie < ActiveRecord::Base

  def self.all_ratings
    select(:rating).group(:rating).map{|t| t.rating}
  end

#  def self.method_missing(method, *args, &block)
#    /^all_(\w*)s$/.match(method.to_s)
#    if self.column_names.include? $1
#      self.select($1).group($1).map{|t| t.send($1)}
#    else
#      super(method, *args, &block)
#    end
#  end

end
