class ApiVersion
  attr_reader :version, :default

  def initialize(version, default = false)
    @version = version
    @default = default
  end

  # check wheather version is specified or default
  def matches?(request)
    check_headers(request.headers) || default
  end

  private

  def check_headers(headers)
    # check version from Accept headers; expect custom media type `patients`
    accept = headers[:accept]
    accept && accept.include?("application/vnd.patients.#{version}+json")
  end
end