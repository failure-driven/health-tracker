require "rails_helper"

describe DailyStatsDataImporter do
  let(:user) { create(:user_claudia) }
  let(:file) {
    generate_file_with_contents("health_sample.csv") do
          <<~HEALTH_SAMPLE_CSV
            Date,Activity Name,Quantity
            15/08/2021,Weight,67.1
            14/08/2021,Weight,66.8
            13/08/2021,Weight,66.5
            12/08/2021,Weight,66
            11/08/2021,Pull ups,50
            11/08/2021,Weight,66.5
            10/08/2021,Weight,67
            08/08/2021,Push ups,200
            08/08/2021,Weight,66
            07/08/2021,Weight,66.4
            06/08/2021,Weight,66.8
            05/08/2021,Weight,66.6
          HEALTH_SAMPLE_CSV
        end
  }

  it "Raises an error with an invalid file path" do
    importer = described_class.new("")
    expect do
      importer.import_daily_stats(user.id)
    end.to raise_error(Errno::ENOENT, "No such file or directory @ rb_sysopen - ")
  end

  it "Creates data for a valid file" do
    importer = described_class.new(file.path)
    importer.import_daily_stats(user.id)
    expect(user.daily_stats.find_by(date: "2021-08-15").data).to eq({"Weight" => "67.1"})
  end

  it "Can be run idempotently" do
    importer = described_class.new(file.path)
    importer.import_daily_stats(user.id)
    importer.import_daily_stats(user.id)
    expect(user.daily_stats.find_by(date: "2021-08-15").data).to eq({"Weight" => "67.1"})
  end

  it "Adds the expected data on a single Daily Stat" do
    importer = described_class.new(file.path)
    importer.import_daily_stats(user.id)
    expect(user.daily_stats.find_by(date: "2021-08-11").data).to eq({"Pull ups"=> "50", "Weight"=> "66.5"})
  end  
end
