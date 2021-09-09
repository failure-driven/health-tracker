require "rails_helper"

describe DailyStatsDataImporter do
  let(:user) { create(:user_claudia) }

  it "Raises an error with an invalid file path" do
    importer = described_class.new("")
    expect do
      importer.import_daily_stats(user.id)
    end.to raise_error(Errno::ENOENT, "No such file or directory @ rb_sysopen - ")
  end

  it "Creates data for a valid file" do
    importer = described_class.new("spec/support/csv_sample.csv")
    importer.import_daily_stats(user.id)
    expect(DailyStat.find_by(date: "2021-08-08").data).to eq({"Push ups" => "200"})
  end

  it "Can be run idempotently" do
    importer = described_class.new("spec/support/csv_sample.csv")
    importer.import_daily_stats(user.id)
    importer.import_daily_stats(user.id)
    expect(DailyStat.find_by(date: "2021-08-08").data).to eq({"Push ups" => "200"})
  end
end
