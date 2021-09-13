require "rails_helper"

describe DailyStatsDataImporter do
  let(:user) { create(:user_claudia) }
  let(:file) do
    generate_file_with_contents("health_sample", ".csv") do
      <<~HEALTH_SAMPLE_CSV
        Date,Activity Name,Quantity
        15/08/2021,Weight,67.1
        14/08/2021,Weight,66.8
        13/08/2021,Weight,66.5
        12/08/2021,Weight,66
        11/08/2021,Pull ups,50
        10/08/2021,Weight,67
        08/08/2021,Push ups,200
        07/08/2021,Weight,66.4
        06/08/2021,Weight,66.8
        05/08/2021,Weight,66.6
      HEALTH_SAMPLE_CSV
    end
  end

  let(:file_with_repeated_dates) do
    generate_file_with_contents("health_sample", ".csv") do
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
  end

  let(:file_with_invalid_data) do
    generate_file_with_contents("health_sample", ".csv") do
      <<~HEALTH_SAMPLE_CSV
        Date,Activity Name,Quantity
        15/08/2021,Weight,67.1
        14/08/2021,Weight,66.8
        ,Pull Ups,100
      HEALTH_SAMPLE_CSV
    end
  end

  let(:incorrect_file_extension) do
    generate_file_with_contents("health_sample", ".txt") do
      <<~HEALTH_SAMPLE_CSV
        Date,Activity Name,Quantity
        15/08/2021,Weight,67.1
      HEALTH_SAMPLE_CSV
    end
  end

  it "Creates data for a valid file" do
    described_class.import(file.path, user.id)
    expect(user.daily_stats.find_by(date: "2021-08-15").data).to eq({"Weight" => 67.1})
  end

  it "Saves numerical data as Floats" do
    described_class.import(file.path, user.id)
    expect(user.daily_stats.find_by(date: "2021-08-15").data["Weight"]).to be_a(Float)
  end

  it "Fails gracefully when the wrong file type is provided" do
    expect do
      described_class.import(incorrect_file_extension.path, user.id)
    end.to raise_error(RuntimeError, "Unknown file type")
  end

  it "Can be run idempotently" do
    described_class.import(file.path, user.id)
    described_class.import(file.path, user.id)
    expect(user.daily_stats.find_by(date: "2021-08-15").data).to eq({"Weight" => 67.1})
  end

  it "Combines records from rows with the same date" do
    described_class.import(file_with_repeated_dates.path, user.id)
    expect(user.daily_stats.find_by(date: "2021-08-11").data).to eq({"Weight" => 66.5, "Pull ups" => 50})
  end
end
