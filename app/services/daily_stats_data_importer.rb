require "csv"

class DailyStatsDataImporter
  def self.import(filepath, user_id)
    new.import(filepath, user_id)
  end

  def import(filepath, user_id)
    user = User.find(user_id)
    read_file(filepath)
      .map { |data| process_data(data) }
      .map { |data| user.daily_stats.create(data) }
  end

  private

  def read_file(filepath)
    case File.extname(filepath)
    when ".csv"
      read_csv(filepath)
    else
      raise "Unknown file type"
    end
  end

  def read_csv(filepath)
    results = []
    CSV.foreach(filepath, headers: true) do |row|
      row_data = {
        date: row["Date"],
        data: {
          row["Activity Name"] => row["Quantity"],
        },
      }
      same_date_item = results.find do |item|
        item[:date] == row_data[:date]
      end
      if same_date_item.present?
        same_date_item[:data] = same_date_item[:data].merge(row_data[:data])
      else
        results << row_data
      end
    end
    results
  end

  def process_data(data)
    parse_date(data)
      .then { |new_data| parse_values(new_data) }
  end

  def parse_date(data)
    data[:date] = Date.parse(data[:date])
    data
  end

  def parse_values(data)
    data[:data].each do |key, value|
      data[:data][key] = value.to_f
    end
    data
  end
end
