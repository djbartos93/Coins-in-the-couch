class Coinlog
  def self.debug(message=nil)
    @coinlog ||= Logger.new("#{Rails.root}/log/coin.log")
    @coinlog.debug(message) unless message.nil?
  end
end
