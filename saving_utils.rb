require 'csv'
require 'json'

class Save
    def saveToCSV(file, data, headers)
      CSV.open(file, "w", :write_headers => true, :col_sep => '|', :headers => headers) do |csv|
          data.each{ |i|
            csv << i.values
          }
        end
    end
    
    def saveToJSON(file, data)
      File.write(file, JSON.dump(data))
    end
end
