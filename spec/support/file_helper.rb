module FileHelper
  def generate_file_with_contents(*filename)
    file = Tempfile.new(filename)
    content = yield
    content = csv_lines_to_string(content) if content.is_a?(Array)
    file.write(content)
    file.close
    file
  end

  private

  def csv_lines_to_string(csv_lines)
    ordered_columns = csv_lines.map(&:keys).flatten.uniq.sort
    CSV.generate do |csv|
      csv << ordered_columns
      csv_lines
        .each do |csv_line|
        csv << ordered_columns.map { |col| csv_line[col] }
      end
    end
  end
end
