require "csv"

namespace :db do
  desc "Import tables from a CSV file"
  task import_tables: :environment do
    puts "importing simple tables"
    %w(species reference).each do |model|
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
    puts "importing non endpoint sections"
    CSV.foreach("db/data/csv/sections.csv", headers: true, header_converters: :symbol) do |row|
      if Section.find_by_name(row[:name])
        puts "skipping existing Section : #{row[:name]}"
      else
        section = Section.new(row.to_hash)
        if row[:parent_id] != "nil"
          chapter = Section.find_by_old_id("c" + row[:parent_id].to_s)
          puts "initialising family '#{section.name}' section"
          puts "assigning chapter section : #{chapter.name}"
          section.parent = chapter
        else
          puts "creating chapter '#{section.name}' section"
          section.parent_id = nil
        end
        section.save
      end
    end
    puts "importing endpoint sections"
    CSV.foreach("db/data/csv/molecules.csv", headers: true, header_converters: :symbol) do |row|
      if Section.find_by_name(row[:name])
        puts "skipping existing Section : #{row[:name]}"
      else
        section = Section.new(row.to_hash)
        puts "initialising '#{section.name}' endpoint section"
        parent = Section.find_by_old_id("f" + row[:parent_id].to_s)
        puts "assigning parent section : #{parent.name}"
        section.parent = parent
        puts "saving"
        section.save!
      end
    end
    puts "importing measures without parents"
    CSV.foreach("db/data/csv/measures.csv", headers: true, header_converters: :symbol) do |row|
      if Measure.find_by_name(row[:name])
        puts "skipping existing Measure : #{row[:name]}"
      else
        measure = Measure.create!(name: row[:name], old_id: row[:old_id])
      end
    end
    puts "assigning measures parents"
    CSV.foreach("db/data/csv/measures.csv", headers: true, header_converters: :symbol) do |row|
      measure = Measure.find_by_name(row[:name])
      puts "processing measure : #{measure.name}"
      parent = Measure.find_by_old_id(row[:parent_id])
      if parent
        puts "assigning parent measure : #{parent.name}"
        measure.parent = parent
        puts "saving measure"
        measure.save!
        puts "done"
      else
        puts "this measure is a root element, skipping"
      end
    end
    puts "importing assessments"
    CSV.foreach("db/data/csv/assessments.csv", headers: true, header_converters: :symbol) do |row|
      if Assessment.find_by_old_id(row[:old_id])
        puts "skipping existing Assessment: #{row[:old_id]}"
      else
        assessment = Assessment.new(row.to_hash)
        puts "initialising '#{assessment.old_id}' assessment"
        molecule = Section.find_by_old_id("m" + row[:molecule_id].to_s)
        if molecule
          puts "assigning molecule section : #{molecule.name}"
          assessment.molecule = molecule
          measure = Measure.find_by_old_id(row[:measure_id])
          puts "assigning measure : #{measure.name}"
          assessment.measure = measure
          species = Species.find_by_old_id(row[:species_id])
          reference = Reference.find_by_old_id(row[:reference_id])
          puts "assigning reference : #{reference.name}"
          assessment.reference = reference
          puts "saving"
          assessment.save!
        else
          puts "skipping this assessment, molecule not found"
        end
      end
    end
  end
end
