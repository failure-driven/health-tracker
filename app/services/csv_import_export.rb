require 'csv'

class CsvImportExport
  attr_accessor :file_path

  def initialize(file_path)
    @file_path = file_path
  end

  def import_daily_stats(user_id)
    daily_stats_data = {}
    CSV.foreach(file_path, headers: true) do |row|
      date = Date.parse(row['Date'])
      data = {
        row["Activity Name"] => row["Quantity"]
      }
      daily_stats_data[date].present? ? daily_stats_data[date].merge(data) : daily_stats_data[date] = data
    end

    daily_stats = []
    invalid_daily_stats = []
    daily_stats_data.each do |date, data|
      daily_stat = DailyStat.new(date: date, data: data, user_id: user_id)
      if daily_stat.valid? 
        daily_stats << daily_stat
      else
        invalid_daily_stats << [daily_stat.date, daily_stat.data, daily_stat.errors.full_messages]
      end
    end

    begin
      DailyStat.transaction do
        daily_stats.each do |daily_stat|
          daily_stat.save
        end
      end
    rescue ActiveRecord::ActiveRecordError => error
      # TODO: what do we do with these errors? Records are valid, but something went wrong
      puts error.to_json
    end
    # binding.pry
    generate_csv(invalid_daily_stats, "Date", "Data", "Error")

  end

  # TODO a method to handle errors and output them in a csv
  def generate_csv(data, *headers)
    CSV.generate(
      write_headers: true, 
      headers: headers
      ) do |csv|
      data.each do |data|
        csv << data
      end
    end
  end

end
