require 'csv'
require 'json'

class StorageService
    def save_csv(file, data, headers)
      CSV.open(file, "w", :write_headers => true, :col_sep => '|', :headers => headers) do |csv|
          data.each{ |i|
            csv << i.values
          }
        end
    end
    
    def save_json(file, data)
      File.open(file, "w") do |f|
        f.puts(data.to_json)
      end
    end
end
