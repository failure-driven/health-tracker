require "rails_helper"

feature "User uploads his data using nice UI", js: true do
  context "with a user that has no stats" do
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
            .size,
        ).to be(0)
      end

      When "she uses the slick UI to upload a csv of stats" do
        page.find("[data-widget-type='stats-app'] .nav-tabs a[href='/app']", text: "Add").click
        import_file = generate_file_with_contents("health_sample.csv") do
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
            08/08/2021,Push ups,100
          HEALTH_SAMPLE_CSV
        end
        attach_file("CSV-file-upload", import_file.path)
        page.find("button", text: "Upload Stats").click
      end

      Then "she sees a notification that the upload is being processed" do
        pending "a way of actually processing the file"
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
            .size,
        ).to be(10)
      end
    end
  end
end
