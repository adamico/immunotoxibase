require "csv"

namespace :db do
  desc "Import tables from a CSV file"
  task import_tables: :environment do
    %w(chapter).each do |model|
      puts "importing #{model.pluralize} records from a CSV file"
      CSV.foreach("db/data/csv/#{model.pluralize}.csv", headers: true, header_converters: :symbol) do |row|
        klass = model.classify.constantize
        if klass.find_by_name(row[:name])
          puts "skipping existing #{model} : #{row[:name]}"
        else
          record = klass.new(row.to_hash)
          puts "creating '#{record.name}' #{model}"
          record.save!
        end
      end
    end
  end
end
