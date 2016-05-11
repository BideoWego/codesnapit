module Dateable
  def date(options={})
    method = options[:method] || :created_at
    datetime = send(method)
    format = options[:format] || "%A, %B #{datetime.day.ordinalize} %Y"
    datetime.strftime(format)
  end
end

