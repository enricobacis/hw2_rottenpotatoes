class Movie < ActiveRecord::Base
  def method_missing(method_id)
    /^all_(\w*)s$/.match(method_id.to_s) do |column|
      if self.column_names.include? column
        self.select(column).group(column).map{|t| t.send(column)}
      else
        super
      end
    end
  end
end
