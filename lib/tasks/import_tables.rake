require "csv"

namespace :db do
  desc "Import tables from a CSV file"
  task import_tables: :environment do
    puts "importing simple tables"
    %w(species reference molecule section measure).each do |model|
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
    puts "importing section endpoints"
    CSV.foreach("db/data/csv/molecules.csv", headers: true, header_converters: :symbol) do |row|
      if Section.find_by_name(row[:name])
        puts "skipping existing Section : #{row[:name]}"
      else
        section = Section.new(row.to_hash)
        puts "initialising '#{section.name}' endpoint section"
        parent = Section.find_by_old_id("f" + row[:parent_id].to_s)
        puts "assigning parent section : #{parent.name}"
        section.parent = parent
        section.save!
      end
    end
  end
end
