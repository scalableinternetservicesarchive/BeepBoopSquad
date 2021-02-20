class RecordPortfolioValuesJob < BackgroundJob
  def perform
    PortfolioValueHistory.transaction do
      User.all.each do |user|
        PortfolioValueHistory.create(user: user, portfolio_value: user.portfolio_value)
      end
    end
    RecordPortfolioValuesJob.perform_in(60*60*8)
  end
end