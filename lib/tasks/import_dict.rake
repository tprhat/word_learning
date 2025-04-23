namespace :db do
    desc "Import words and definitions app/assets/dict.csv"
    task import_dict: :environment do
        require "csv"
        csv_path = Rails.root.join "app/assets/dict.csv"

        words = []
        CSV.foreach(csv_path, headers: true) do |row|
            words << Word.new(word: row["word"], definition: row["definition"])
        end

        Word.import words
        puts "Import completed! Imported #{words.size} words."
    end
end
