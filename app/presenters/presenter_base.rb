class PresenterBase < SimpleDelegator
  def model
    __getobj__
  end
end
