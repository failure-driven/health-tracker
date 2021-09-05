require "rails_helper"

feature "User uploads his data using nice UI", js: true do
  context "A user exists with no stats" do
    before do
      @user_claudia = User.create!(
        email: "claudia.king@automio.com",
        password: "1password",
        confirmed_at: DateTime.now,
      )
    end

    scenario "Claudia signs in, sees no stats in Stats" do
      When "Claudia signs in and views her stats in pretty UI" do
        visit root_path
        page.find("nav a", text: "Log in").click
        focus_on(:form).for(user_session_path).submit(
          "Email" => @user_claudia.email,
          "Password" => @user_claudia.password,
        )

        page.find(".nav a[href='/app/stats']", text: "Stats").click
      end

      Then "she sees no stats" do
        expect(
          page
            .find_all(".daily-stats-list .daily-stats-item")
            .size
        ).to be(0)
      end

      When "she uses the slick UI to upload a csv of stats" do
        page.find("[data-widget-type='stats-app'] .nav-tabs a[href='/app']", text: "Add").click
        # TODO dynamically generate the file with fixtures
        # let's say the file should have 10 records
        attach_file("CSV-file-upload", Rails.root + "spec/support/csv_sample.csv")
        page.find("button", text: "Upload Stats").click
      end

      Then "she sees a notification that the upload is being processed" do
        wait_for do
          page.find("p.alert [data-testid=\"message\"]").text
        end.to eq "Processing..."
      end

      Then "she sees a notification that the upload is completed" do
        wait_for do
          page.find("p.alert [data-testid=\"message\"]").text
        end.to eq "Upload complete"
      end

      Then "she sees the new stats under stats" do
        page.find(".nav a[href='/app/stats']", text: "Stats").click
        
        expect(
          page
            .find_all(".daily-stats-list .daily-stats-item")
            .size
        ).to be(10)
      end
    end
  end
end
